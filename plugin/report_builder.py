import shutil
import sqlite3
from pathlib import Path
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
from .create_gpkg_from_sql import WORKDIR
from .utils import ipdb_breakpoint  # noqa


CHILD_ATTRIBUTES = {
    "lithology": ", dic_rock_field.label ",
    "manmade_landform": ", dic_manmade_landform.description ",
    "media": ", dic_media.description ",
    "photo": "",
    "sample": ", dic_sample.description ",
    "structural_measurement": ", dic_structure.description ",
    "superficial_landform": ", dic_superficial_landform.description ",
}

CHILD_JOINS = {
    "lithology": " JOIN dic_rock_field ON code == child.lithology_code ",
    "manmade_landform": " JOIN dic_manmade_landform ON code == child.manmade_type_code ",
    "media": " JOIN dic_media ON code == child.media_type_code ",
    "photo": "",
    "sample": " JOIN dic_sample ON code == child.sample_type_code ",
    "structural_measurement": " JOIN dic_structure ON code == child.structure_type_code ",
    "superficial_landform": " JOIN dic_superficial_landform ON code == child.superficial_type_code ",
}


class ReportBuilder:
    def __init__(self, project_dir: Path, db_file: Path):
        """Constructor.

        """
        self.project_dir = project_dir
        self.db_file = db_file
        self.report_filename = Path("field-report.html")
        self.css_filename = Path("style.css")


    @property
    def report_file(self) -> Path:
        """
        Get the field report file path from the current project.
        """
        return self.project_dir / self.report_filename


    @property
    def css_src_file(self) -> Path:
        """
        Get the ccs file path from the plugin folder.
        """
        return WORKDIR / "css" / self.css_filename


    @property
    def css_dest_dir(self) -> Path:
        """
        Get the ccs directory from the current project.
        """
        return self.project_dir / "css"


    @property
    def templates_dir(self) -> Path:
        """
        Get the Jinja2 template directory path from the plugin folder.
        """
        return WORKDIR / "templates"


    def create_field_report(self) -> bool:
        """
        Create and save a field report.
        If an older report already exists, issue a warning with an option to cancel.
        If confirmed, parse the locality point layer creating an entry for each point
        in an HTML document using a Jinja2 template, overwriting the older report if necessary.
        Returns a boolean indicating success of the process.
        """

        if self.report_file.exists():
            result = QMessageBox.question(
                None, "Report file Already Exists",
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
        # Copy CSS file to project directory
        self.css_dest_dir.mkdir(parents=True, exist_ok=True)
        shutil.copy(self.css_src_file, self.css_dest_dir / self.css_filename)

        QMessageBox.information(None, "Information", f"Created field report:\n\n{self.report_file}")
        return True


    def get_report_data(self) -> dict[str, Any]:
        """
        Parse the project layers to extract data for the report
        """
        report_data = {
            'locality_points': []
        }

        report_data['project'] = self.get_project_data()
        local_epsg = report_data['project']['local_epsg']
        locality_data = self.get_locality_data(local_epsg)
        report_data['locality_points'] = {}
        for locality in locality_data:
            name = locality['name']
            report_data['locality_points'][name] = locality
            report_data['locality_points'][name]['children'] = self.get_child_data(name)

        return report_data


    def get_project_data(self) -> dict[str, Any]:
        """
        Query the field_project table to extract data for the single project
        """
        sql = "SELECT * FROM field_project"
        rows = self.get_rows(sql)
        return rows[0]


    def get_locality_data(self, local_epsg: int) -> dict[str, Any]:
        """
        Query the locality_point table to extract data for all the points
        """
        # Transform geometry to local EPSG from the project
        sourceCrs = QgsCoordinateReferenceSystem.fromEpsgId(4326)
        destCrs = QgsCoordinateReferenceSystem.fromEpsgId(local_epsg)
        tr = QgsCoordinateTransform(sourceCrs, destCrs, QgsProject.instance())

        sql = "SELECT *, AsText(CastAutomagic(geometry)) as geom FROM locality_point"
        rows = self.get_rows(sql)

        for row in rows:
            geom = QgsGeometry().fromWkt(row['geom'])
            point = geom.asPoint()
            google_link = (f'<a href="https://www.google.co.uk/maps/place/{point.y()},{point.x()}'
                           '" target="_blank">Open Google Map</a>')
            geom.transform(tr)
            point = geom.asPoint()
            row['geometry'] = f'{(int(point.x()), int(point.y()))} - {google_link}'

        return rows


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

        rows = self.get_rows(sql)
        return rows


    def get_rows(self, sql: str) -> dict[str, Any]:
        """
        Get the data as a dictionary for a given attibute (table) and locality point.
        """

        # See https://docs.python.org/3/library/sqlite3.html#sqlite3-howto-row-factory
        def dict_factory(cursor, row):
            fields = [column[0] for column in cursor.description]
            return {key: value for key, value in zip(fields, row)}

        rows = []
        with sqlite3.connect(self.db_file) as conn:
            conn.enable_load_extension(True)
            conn.execute("SELECT load_extension('mod_spatialite');")
            conn.row_factory = dict_factory
            cursor = conn.cursor()
            cursor.execute(sql)
            rows = cursor.fetchall()

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
