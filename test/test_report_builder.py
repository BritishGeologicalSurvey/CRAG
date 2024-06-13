from pathlib import Path

from bs4 import BeautifulSoup

from conftest import locality_point_count

from plugin.config import LOCALITY_POINT_CHILDREN
from plugin.field_data_capture import FieldDataCapture
from plugin.report_builder import ReportBuilder
from plugin.utils import ipdb_breakpoint  # noqa


def test_create_field_report(fdc_project: FieldDataCapture):
    # Act
    fdc_project.create_field_report()

    # Assert
    # Check file exists and is not empty
    report_builder = ReportBuilder(fdc_project.project_dir, fdc_project.db_file)
    report_file = Path(report_builder.project_dir / report_builder.report_filename)
    assert report_file.exists()
    assert report_file.stat().st_size > 0
    # Confirm the correct number of sections has been created
    soup = BeautifulSoup(report_file.read_text(encoding="utf-8"), 'lxml')
    project_sections = soup.findAll('section', {'class': "project"})
    assert len(project_sections) == 1
    locality_sections = soup.findAll('section', {'class': "locality_point"})
    row_count = locality_point_count(fdc_project)
    assert len(locality_sections) == row_count


def test_get_report_data(fdc_project: FieldDataCapture, qgs_project: Path):
    # Arrange

    # Act
    report_builder = ReportBuilder(fdc_project.project_dir, fdc_project.db_file)
    report_data = report_builder.get_report_data()

    # Assert
    assert report_data['project']
    # Check that the correct amount of data has been obtained
    row_count = locality_point_count(fdc_project)
    assert len(report_data['locality_points']) == row_count
    for locality in report_data['locality_points'].values():
        # Check that the children dict has been created
        assert set(LOCALITY_POINT_CHILDREN) == set(locality['children'].keys())
