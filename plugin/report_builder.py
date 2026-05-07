import codecs
import logging
from pathlib import Path
import shutil
import sqlite3
from typing import (
    Any,
    Optional,
)

from jinja2 import (
    Environment,
    FileSystemLoader,
)

from PIL import Image, ImageOps, UnidentifiedImageError

from qgis.core import (
    QgsCoordinateReferenceSystem,
    QgsCoordinateTransform,
    QgsGeometry,
    QgsProject,
)
from qgis.PyQt.QtWidgets import QMessageBox

from .config import ATTRIBUTE_TABLES, THUMBNAIL_SIZE
from .pdf_content import ReportTemplate
from .utils import (  # noqa
    FieldDataCaptureProject,
    get_table_rows,
    ipdb_breakpoint,
)

logger = logging.getLogger('report_builder')

CHILD_ATTRIBUTES = {
    "lithology": ", dic_rock_field.label ",
    "manmade_landform": ", dic_manmade_landform.description ",
    "media": ", dic_media.description ",
    "photo": "",
    "sample": ", dic_sample_material.description ",
    "structural_measurement": (", dic_structure.description "
                               ", dic_structure_secondary.description as secondary_description "
                               ", dic_structure_third.description as third_description "),
    "superficial_landform": ", dic_superficial_landform.description ",
}

CHILD_JOINS = {
    "lithology": " JOIN dic_rock_field ON code == child.lithology_code ",
    "manmade_landform": " JOIN dic_manmade_landform ON code == child.manmade_type_code ",
    "media": " JOIN dic_media ON code == child.media_type_code ",
    "photo": "",
    "sample": " JOIN dic_sample_material ON code == child.sample_type_code ",
    "structural_measurement": (" JOIN dic_structure ON dic_structure.code == child.structure_type_code "
                               " LEFT JOIN dic_structure_secondary ON dic_structure_secondary.code "
                               "== child.secondary_attribute "
                               " LEFT JOIN dic_structure_third ON dic_structure_third.code "
                               "== child.third_attribute "),
    "superficial_landform": " JOIN dic_superficial_landform ON code == child.superficial_type_code ",
}


class ReportBuilder(FieldDataCaptureProject):
    def create_field_report(self) -> tuple[bool, bool]:
        """
        Create and save HTML and PDF field reports. If either older report already exists,
        issue a warning with an option to cancel.
        Returns a tuple of booleans indicating success of the process.
        """
        if self.html_report_file.exists() or self.pdf_report_file.exists():
            result = QMessageBox.question(
                None, "HTML and/or PDF Report files already exist",
                f"Would you like to overwrite the file(s)?\n\n{self.html_report_file}\n{self.pdf_report_file}",
            )
            if result == QMessageBox.StandardButton.No:
                return False, False

        # If the PDF report file is already open it cannot be written to.
        # Attempting to rename the file to itself causes an OSError if the
        # file is open. This hack is an alternative to checking using the
        # package psutil which is not available in QGIS
        if self.pdf_report_file.exists():
            try:
                self.pdf_report_file.rename(self.pdf_report_file)
            except OSError:
                msg = "PDF Report file is open by another process\n"
                logger.exception(f"Failed to create field report: {self.pdf_report_file}\n{msg}")
                QMessageBox.critical(
                    None, "Error",
                    f"{msg}\nPlease close {self.pdf_report_file} before creating a report",
                )
                return False, False

        self.create_thumbnails()
        try:
            report_data = self.get_report_data()
        except sqlite3.OperationalError:
            msg = "Unable to access the geopackage\n"
            logger.exception(f"Failed to create field report: {self.pdf_report_file}\n{msg}")
            QMessageBox.information(None, "Error",
                                    f"Failed to create field report\n{msg}See logs for more information")
            return False, False

        html_success = self.create_html_field_report(report_data)
        pdf_success = self.create_pdf_field_report(report_data)

        if html_success or pdf_success:
            msg = "Field reports have been created in the project folder:\n"
            if html_success:
                msg += f"\n{self.html_report_file}"
            if pdf_success:
                msg += f"\n{self.pdf_report_file}"
            msg += "\n\nWould you like to open them now?"
            result = QMessageBox.question(None, "Created Field Reports", msg)
            if result == QMessageBox.StandardButton.Yes:
                if html_success:
                    self.open_local_filepath(self.html_report_file)
                if pdf_success:
                    self.open_local_filepath(self.pdf_report_file)

        return html_success, pdf_success


    def create_pdf_field_report(self, report_data) -> bool:
        """
        Create and save a PDF field report.
        Parse the report_data creating an entry for the project and for each point
        in an PDF document, overwriting the older report if necessary.
        Returns a boolean indicating success of the process.
        """
        try:
            report = ReportTemplate(str(self.pdf_report_file))
            report.render(report_data, self.thumbnails_dir)

        except OSError:
            msg = "Unable to write report file\n"
            logger.exception(f"Failed to create field report: {self.pdf_report_file}\n{msg}")
            QMessageBox.information(None, "Error", f"Failed to create field report\n{msg}See logs for more information")
            return False

        return True


    def create_html_field_report(self, report_data) -> bool:
        """
        Create and save an HTML field report.
        Parse the report_data creating an entry for the project and for each point
        in an HTML document using a Jinja2 template, overwriting the older report if necessary.
        Returns a boolean indicating success of the process.
        """

        try:
            environment = Environment(loader=FileSystemLoader(self.templates_dir))
            template = environment.get_template("report.html")
            content = template.render(report_data)

            with open(self.html_report_file, mode="w", encoding="utf-8") as report:
                report.write(content)
            self.copy_plugin_files_to_project(plugin_src=self.css_src_file, project_dest=self.css_dest_dir)
            self.copy_plugin_files_to_project(plugin_src=self.font_src_file, project_dest=self.font_dest_dir)

        except OSError:
            msg = "Unable to write report file\n"
            logger.exception(f"Failed to create field report: {self.html_report_file}\n{msg}")
            QMessageBox.information(None, "Error", f"Failed to create field report\n{msg}See logs for more information")
            return False

        return True


    def get_report_data(self) -> dict[str, Any]:
        """
        Extract data for the report
        """
        report_data = {}
        report_data['project'] = self.get_project_data()
        local_epsg = report_data['project']['local_epsg']
        report_data['locality_points'] = self.get_locality_data(local_epsg)
        return report_data


    def get_project_data(self) -> dict[str, Any]:
        """
        Query the field_project table to extract data for the single project
        """
        sql = "SELECT * FROM field_project"
        rows = get_table_rows(self.db_file, sql)
        rows = self.remove_microseconds_by_row(rows)
        project_data = rows[0]
        if not project_data['title']:
            project_data['title'] = project_data['short_name']
        project_data['description'] = self.split_lines(project_data['description'])
        project_data['notes'] = self.split_lines(project_data['notes'])
        return project_data


    def get_locality_data(self, local_epsg: int) -> dict[str, Any]:
        """
        Query the locality_point table to extract data for all the points
        """
        # Transform geometry to local EPSG from the project
        sourceCrs = QgsCoordinateReferenceSystem.fromEpsgId(4326)
        destCrs = QgsCoordinateReferenceSystem.fromEpsgId(local_epsg)
        tr = QgsCoordinateTransform(sourceCrs, destCrs, QgsProject.instance())

        sql = "SELECT *, AsText(CastAutomagic(geometry)) as geom FROM locality_point ORDER BY name"
        rows = get_table_rows(self.db_file, sql)
        rows = self.remove_microseconds_by_row(rows)

        locality_points = {}
        for row in rows:
            # Get point co-ordinates for Google link
            geom = QgsGeometry().fromWkt(row['geom'])
            point = geom.asPoint()
            google_ref = f'https://www.google.co.uk/maps/place/{point.y()},{point.x()}'
            pdf_link = (f'<link href="{google_ref}">Open Google Map</link>')
            html_link = (f'<a href="{google_ref}" target="_blank">Open Google Map</a>')
            # Get point co-ordinates in local EPSG
            geom.transform(tr)
            point = geom.asPoint()
            row['geometry'] = f'{(int(point.x()), int(point.y()))} - {html_link}'
            row['pdf_geometry'] = f'{(int(point.x()), int(point.y()))} - {pdf_link}'
            # Split long text on line breaks
            row['locality_description'] = self.split_lines(row['locality_description'])
            row['map_face_note'] = self.split_lines(row['map_face_note'])
            row['geology_description'] = self.split_lines(row['geology_description'])

            locality_points[row['name']] = row
            locality_points[row['name']]['children'] = self.get_child_data(row['name'])

        return locality_points


    def get_child_data(self, locality_name: str) -> dict[str, Any]:
        """
        Get the child data for each attribute for a given locality
        """
        children = {}
        for child_table_name in ATTRIBUTE_TABLES:
            children[child_table_name] = []
            child_rows = self.get_child_rows_for_locality_from_table(child_table_name, locality_name)
            for child in child_rows:
                child = self.modify_child(child, child_table_name)
                children[child_table_name].append(child)

        return children


    def modify_child(self, child: dict[str, Any], child_table_name: str) -> dict[str, Any]:
        if child_table_name == 'lithology':
            child['lithology'] = f"{child['label']} ({child['lithology_code']})"
            child['notes'] = self.split_lines(child['notes'])
        elif child_table_name == 'structural_measurement':
            child['dip_azimuth'] = f"{child['dip']} / {child['azimuth']}"
            child['notes'] = self.split_lines(child['notes'])
            child['measurement_type'] = child['description']
            if child['secondary_description'] is not None:
                child['measurement_type'] += f"; {child['secondary_description']}"
            if child['third_description'] is not None:
                child['measurement_type'] += f"; {child['third_description']}"
        elif child_table_name == 'superficial_landform':
            child['notes'] = self.split_lines(child['notes'])
        elif child_table_name == 'manmade_landform':
            child['notes'] = self.split_lines(child['notes'])
        elif child_table_name == 'sample':
            child['sample_description'] = self.split_lines(child['sample_description'])
        elif child_table_name == 'media':
            child['media_description'] = self.split_lines(child['media_description'])
        elif child_table_name == 'photo':
            child['caption'] = self.split_lines(child['caption'])
            child['description'] = self.split_lines(child['description'])
        return child


    def get_child_rows_for_locality_from_table(self, table: str, locality_name: str) -> dict[str, Any]:
        """
        Get the data as a dictionary for a given attibute (table) and locality point
        """

        # Each child requires diffeent columns to be returned
        # and is dependent of a different join
        sql = "SELECT child.* "
        sql += CHILD_ATTRIBUTES[table]
        sql += f" FROM {table} AS child JOIN locality_point ON child.locality_fuid == locality_point.uuid "
        sql += CHILD_JOINS[table]
        sql += f" WHERE locality_point.name LIKE '{locality_name}'"

        rows = get_table_rows(self.db_file, sql)
        rows = self.remove_microseconds_by_row(rows)
        return rows


    def remove_microseconds_by_row(self, rows: dict[str, Any]) -> dict[str, Any]:
        """
        Remove any microseconds from the two date strings
        """
        for row in rows:
            row['recorded_on'] = row['recorded_on'].split('.')[0]

        return rows


    def create_thumbnails(self, thumbnail_size=THUMBNAIL_SIZE):
        """
        Create a thumbnail for each photo if it does not exist.
        Remove any stale paths and thumbnails.
        """
        def make_thumbnail(path):
            try:
                with Image.open(path) as im:
                    ImageOps.exif_transpose(im, in_place=True)
                    im.thumbnail((thumbnail_size, thumbnail_size))
                    im.save(tn_path)
            except UnidentifiedImageError:
                # not an image readable by PIL (e.g. HEIC file)
                pass

        photos_str = str(self.photos_dir)
        thumbnails_str = str(self.thumbnails_dir)

        if not self.thumbnails_dir.exists():
            self.thumbnails_dir.mkdir()

        # Create directories in thumbnails that are in photos
        for path in list(self.photos_dir.rglob('*/')):
            tn_path = Path(str(path).replace(photos_str, thumbnails_str))
            if path.is_dir() and not tn_path.exists():
                tn_path.mkdir()

        # Remove directories in thumbnails that are no longer in photos
        for tn_path in list(self.thumbnails_dir.rglob('*/')):
            path = Path(str(tn_path).replace(thumbnails_str, photos_str))
            if tn_path.is_dir() and not path.exists():
                shutil.rmtree(tn_path)

        # Create thumbnails if needed
        for path in list(self.photos_dir.rglob('*.*')):
            if path.is_file():
                tn_path = Path(str(path).replace(photos_str, thumbnails_str))
                if tn_path.exists():
                    # Create resized thumbnail
                    with Image.open(tn_path) as tn:
                        if max(tn.size) != thumbnail_size:
                            make_thumbnail(path)
                else:
                    # Create completely new thumbnail
                    make_thumbnail(path)

        # Remove redundant thumnails
        for tn_path in list(self.thumbnails_dir.rglob('*.*')):
            path = Path(str(tn_path).replace(thumbnails_str, photos_str))
            if tn_path.is_file() and not path.exists():
                tn_path.unlink()


    def split_lines(self, input_str: Optional[str]) -> Optional[list[str]]:
        if not isinstance(input_str, str):
            return input_str

        # See: https://sqlpey.com/python/python-string-unescaping-techniques/ approach 4
        # 1. Encode to bytes (UTF-8)
        as_bytes = bytes(input_str, "utf-8")
        # 2. Decode escapes (bytes -> bytes), this step handles sequences like b'\\n' -> b'\n'
        #    escape_decode returns a tuple (decoded_bytes, length_consumed)
        decoded_bytes = codecs.escape_decode(as_bytes)[0]
        # 3. Final decode back to string using intended final encoding (UTF-8)
        decoded_str = decoded_bytes.decode("utf-8")
        # Split on line-breaks
        split_str = decoded_str.splitlines()
        # Remove any empty strings to avois over large HTML elements
        while '' in split_str:
            split_str.remove('')

        return split_str
