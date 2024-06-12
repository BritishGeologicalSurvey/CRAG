import shutil
from pathlib import Path
from typing import Any

from jinja2 import (
    Environment,
    FileSystemLoader,
)
from qgis.core import (
    QgsCoordinateReferenceSystem,
    QgsCoordinateTransform,
    QgsFeature,
    QgsProject,
)
from qgis.PyQt.QtCore import QVariant
from qgis.PyQt.QtWidgets import QMessageBox

from .create_gpkg_from_sql import WORKDIR
from .utils import ipdb_breakpoint  # noqa


class ReportBuilder:
    def __init__(self, project_dir: Path):
        """Constructor.

        """
        self.project_dir = project_dir
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

        report_data['project'] = self.get_attribute_values_from_project()
        local_epsg = report_data['project']['local_epsg']
        localities = QgsProject.instance().mapLayersByName('locality_point')[0]
        for feature in localities.getFeatures():
            attribute_values = self.get_attribute_values_from_locality_point(feature, local_epsg)
            report_data['locality_points'].append(attribute_values)

        return report_data

    def get_attribute_values_from_project(self) -> dict[str, Any]:
        """
        Parse the field_project feature to extract data for the report
        """
        # Get the first (only) field project feature from the field project layer
        field_projects = QgsProject.instance().mapLayersByName('field_project')[0]
        attribute_values = self.get_attribute_values_from_feature(next(field_projects.getFeatures()))
        # Transform project start and end dates
        if attribute_values['start_date']:
            attribute_values['start_date'] = attribute_values['start_date'].toPyDate()
        if attribute_values['end_date']:
            attribute_values['end_date'] = attribute_values['end_date'].toPyDate()

        return attribute_values


    def get_attribute_values_from_locality_point(
        self,
        feature: QgsFeature,
        local_epsg: int
    ) -> dict[str, Any]:
        """
        Parse the locality_point feature to extract data for the report
        """
        attribute_values = self.get_attribute_values_from_feature(feature)
        # Create link out to Google Maps
        geom = feature.geometry()
        point = geom.asPoint()
        google_link = (f'<a href="https://www.google.co.uk/maps/place/{point.y()},{point.x()}'
                       '" target="_blank">Open Google Map</a>')
        # Transform geometry to local EPSG from the project
        sourceCrs = QgsCoordinateReferenceSystem.fromEpsgId(4326)
        destCrs = QgsCoordinateReferenceSystem.fromEpsgId(local_epsg)
        tr = QgsCoordinateTransform(sourceCrs, destCrs, QgsProject.instance())
        geom.transform(tr)
        point = geom.asPoint()
        attribute_values['geometry'] = f'{(int(point.x()), int(point.y()))} - {google_link}'

        return attribute_values


    def get_attribute_values_from_feature(self, feature: QgsFeature) -> dict[str, Any]:
        field_names = [f.name() for f in feature.fields()]
        # If the field attribute is a PyQt NULL value replace with a Python None
        values = [None if isinstance(a, QVariant) and a.isNull() else a for a in feature.attributes()]
        attribute_values = dict(zip(field_names, values))

        # Transform entered and updated datetimes (all features have these columns)
        attribute_values['date_entered'] = (attribute_values['date_entered']
                                            .toPyDateTime()
                                            .replace(microsecond=0))
        if attribute_values['date_updated']:
            attribute_values['date_updated'] = (attribute_values['date_updated']
                                                .toPyDateTime()
                                                .replace(microsecond=0))

        return attribute_values
