from pathlib import Path

from bs4 import BeautifulSoup
import pytest

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
    for child in LOCALITY_POINT_CHILDREN:
        child_sections = soup.findAll('section', {'class': child})
        assert len(child_sections) > 0


def test_get_report_data(fdc_project: FieldDataCapture, report_builder: ReportBuilder):
    # Act
    report_data = report_builder.get_report_data()

    # Assert
    assert report_data['project']
    # Check that the correct amount of data has been obtained
    row_count = locality_point_count(fdc_project)
    assert len(report_data['locality_points']) == row_count
    for locality in report_data['locality_points'].values():
        # Check that the children dict has been created
        assert set(LOCALITY_POINT_CHILDREN) == set(locality['children'].keys())


@pytest.mark.parametrize(
    "sql, count",
    [("SELECT * FROM field_project", 1),
     ("SELECT *, AsText(CastAutomagic(geometry)) as geom FROM locality_point", 2)]
)
def test_get_rows(report_builder: ReportBuilder, sql: str, count: int):
    # Act
    rows = report_builder.get_rows(sql)

    # Assert
    assert isinstance(rows, list)
    assert len(rows) == count
    assert isinstance(rows[0], dict)


def test_remove_microseconds_by_row(report_builder: ReportBuilder):
    # Arrange
    fixture = [{'date_entered': '2023-10-31T16:54:28.908', 'date_updated': '2023-10-31T16:54:28.908'},
               {'date_entered': '2023-10-31T16:54:28', 'date_updated': '2023-10-31T16:54:28'},
               {'date_entered': '2023-10-31T16:54:28.908', 'date_updated': None}]
    expected = [{'date_entered': '2023-10-31T16:54:28', 'date_updated': '2023-10-31T16:54:28'},
                {'date_entered': '2023-10-31T16:54:28', 'date_updated': '2023-10-31T16:54:28'},
                {'date_entered': '2023-10-31T16:54:28', 'date_updated': None}]

    # Act
    result = report_builder.remove_microseconds_by_row(fixture)

    # Assert
    assert expected == result
