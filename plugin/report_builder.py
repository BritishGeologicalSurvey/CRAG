import logging
import shutil
import sqlite3
from typing import Any

from jinja2 import (
    Environment,
    FileSystemLoader,
)
from qgis.core import (
    QgsCoordinateReferenceSystem,
    QgsCoordinateTransform,
    QgsGeometry,
    QgsProject,
)
from qgis.PyQt.QtWidgets import QMessageBox

from .config import LOCALITY_POINT_CHILDREN
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
    def create_field_report(self) -> bool:
        """
        Create and save HTML and PDF field reports.
        Returns a boolean indicating success of the process.
        """
        html_success = self.create_html_field_report()
        pdf_success = self.create_pdf_field_report()
        return html_success and pdf_success


    def create_pdf_field_report(self) -> bool:
        """
        Create and save a PDF field report.
        If an older report already exists, issue a warning with an option to cancel.
        If confirmed, parse the locality point layer creating an entry for each point
        in an PDF document, overwriting the older report if necessary.
        Returns a boolean indicating success of the process.
        """
        return True


    def create_html_field_report(self) -> bool:
        """
        Create and save an HTML field report.
        If an older report already exists, issue a warning with an option to cancel.
        If confirmed, parse the locality point layer creating an entry for each point
        in an HTML document using a Jinja2 template, overwriting the older report if necessary.
        Returns a boolean indicating success of the process.
        """

        try:
            if self.report_file.exists():
                result = QMessageBox.question(
                    None, "HTML Report file Already Exists",
                    f"The report file already exists, would you like to overwrite the file?\n\n{self.report_file}",
                )
                if result == QMessageBox.No:
                    return False

            environment = Environment(loader=FileSystemLoader(self.templates_dir))
            template = environment.get_template("report.html")
            context = self.get_report_data()
            content = template.render(context)

            with open(self.report_file, mode="w", encoding="utf-8") as report:
                report.write(content)
            # Copy CSS and font files to project directory
            self.css_dest_dir.mkdir(parents=True, exist_ok=True)
            self.font_dest_dir.mkdir(parents=True, exist_ok=True)
            shutil.copy(self.css_src_file, self.css_dest_dir / self.css_filename)
            shutil.copy(self.font_src_file, self.font_dest_dir / self.font_filename)

            result = QMessageBox.question(
                None,
                "Created Field Report",
                (
                    "An HTML field report has been created in the project folder. "
                    f"Would you like to open it now?\n\n{self.report_file}"
                ),
            )
            if result == QMessageBox.Yes:
                self.open_local_filepath(self.report_file)

        except Exception as exc:
            msg = ""
            if isinstance(exc, sqlite3.OperationalError):
                msg = "Unable to access the geopackage\n"
            elif isinstance(exc, OSError):
                msg = "Unable to write report file\n"
            logger.exception(f"Failed to create field report: {self.report_file}\n{msg}")
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
        return rows[0]


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
            google_link = (f'<a href="https://www.google.co.uk/maps/place/{point.y()},{point.x()}'
                           '" target="_blank">Open Google Map</a>')
            # Get point co-ordinates in local EPSG
            geom.transform(tr)
            point = geom.asPoint()
            row['geometry'] = f'{(int(point.x()), int(point.y()))} - {google_link}'

            locality_points[row['name']] = row
            locality_points[row['name']]['children'] = self.get_child_data(row['name'])

        return locality_points


    def get_child_data(self, locality_name: str) -> dict[str, Any]:
        """
        Get the child data for each attribute for a given locality
        """
        children = {}
        for child_table_name in LOCALITY_POINT_CHILDREN:
            children[child_table_name] = []
            child_rows = self.get_child_rows_for_locality_from_table(child_table_name, locality_name)
            for child in child_rows:
                children[child_table_name].append(child)

        return children


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
            row['date_entered'] = row['date_entered'].split('.')[0]
            if row['date_updated']:
                row['date_updated'] = row['date_updated'].split('.')[0]

        return rows
