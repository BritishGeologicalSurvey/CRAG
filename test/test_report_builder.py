import builtins

from bs4 import BeautifulSoup

from conftest import locality_point_count

from plugin.field_data_capture import FieldDataCapture
from plugin.report_builder import ReportBuilder
from plugin.utils import (  # noqa
    FieldDataCaptureProject,
    ipdb_breakpoint,
)

# Minimum set of columns needed to produce a report using the templates
EXPECTED_COMMON_COLUMNS = {"user_entered", "date_entered", "user_updated", "date_updated"}
EXPECTED_PROJECT_COLUMNS = {"project_lead", "start_date", "end_date", "description"}
EXPECTED_LOCALITY_COLUMNS = {"name", "locality_type_code", "geometry",
                             "locality_description", "map_face_note", "geology_description"}
EXPECTED_CHILD_COLUMNS = {
    "lithology": {"label", "lithology_code"},
    "manmade_landform": {"description", "notes"},
    "media": {"description", "media_type_code", "media_link", "media_description"},
    "photo": {"photo_file", "caption"},
    "sample": {"description", "sample_id", "sample_description"},
    "structural_measurement": {"description", "secondary_description", "third_description", "dip", "azimuth", "notes"},
    "superficial_landform": {"description", "notes"},
}


def test_create_field_report(fdc_project: FieldDataCapture, monkeypatch_qmsgbox_question_yes):
    # Act
    html_success, pdf_success = fdc_project.create_field_report()

    # Assert
    assert html_success
    assert pdf_success


def test_create_html_field_report(fdc_project: FieldDataCapture, report_builder: ReportBuilder,
                                  monkeypatch_qmsgbox_question_yes):
    # Act
    success = report_builder.create_html_field_report()

    # Assert
    assert success
    # Check file exists and is not empty
    assert fdc_project.html_report_file.exists()
    assert fdc_project.html_report_file.stat().st_size > 0
    # Confirm the correct number of sections has been created
    soup = BeautifulSoup(fdc_project.html_report_file.read_text(encoding="utf-8"), 'lxml')
    project_sections = soup.findAll('section', {'class': "project"})
    assert len(project_sections) == 1
    locality_sections = soup.findAll('section', {'class': "locality_point"})
    row_count = locality_point_count(fdc_project)
    assert len(locality_sections) == row_count
    for child in EXPECTED_CHILD_COLUMNS.keys():
        child_sections = soup.findAll('section', {'class': child})
        assert len(child_sections) > 0

    # Check that the method to open the file after creation was called
    FieldDataCaptureProject.open_local_filepath.assert_called_once_with(fdc_project.html_report_file)


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
        assert set(EXPECTED_CHILD_COLUMNS.keys()) == set(locality['children'].keys())


def test_get_project_data(report_builder: ReportBuilder):
    # Act
    result = report_builder.get_project_data()

    # Assert
    assert result['short_name'] == 'test_field_project'
    assert EXPECTED_COMMON_COLUMNS < set(result.keys())
    assert EXPECTED_PROJECT_COLUMNS < set(result.keys())


def test_get_locality_data(report_builder: ReportBuilder):
    # Arrange
    project = report_builder.get_project_data()
    local_epsg = project['local_epsg']

    # Act
    localities = report_builder.get_locality_data(local_epsg)

    # Assert
    assert list(localities.keys()) == ['test_point_001', 'test_point_002']
    for locality in localities.values():
        assert EXPECTED_COMMON_COLUMNS < set(locality.keys())
        assert EXPECTED_LOCALITY_COLUMNS < set(locality.keys())
        assert 'children' in locality


def test_get_child_data(report_builder: ReportBuilder):
    # Act
    child = report_builder.get_child_data('test_point_001')

    # Assert
    assert set(child.keys()) == set(EXPECTED_CHILD_COLUMNS.keys())


def test_get_child_rows_for_locality_from_table(report_builder: ReportBuilder):
    # Act & assert
    for table in EXPECTED_CHILD_COLUMNS.keys():
        rows = report_builder.get_child_rows_for_locality_from_table(table, 'test_point_001')
        assert rows
        for row in rows:
            assert EXPECTED_COMMON_COLUMNS < set(row.keys())
            assert EXPECTED_CHILD_COLUMNS[table] < set(row.keys())


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


def test_create_html_field_report_no_db(report_builder: ReportBuilder, caplog):
    # Arrange
    # Remove database to force error
    report_builder.db_file.unlink()

    # Act
    result = report_builder.create_html_field_report()

    # Assert
    assert not result
    assert 'Failed to create field report' in caplog.text
    assert 'Unable to access the geopackage' in caplog.text


def test_create_field_html_report_file_not_writeable(report_builder: ReportBuilder, monkeypatch, caplog):
    # Arrange
    # Force open to throw an OSError, covering several failure types
    def mock_open(file, mode='r', buffering=-1, encoding=None, errors=None, newline=None, closefd=True, opener=None):
        raise OSError()

    monkeypatch.setattr(builtins, 'open', mock_open)

    # Act
    result = report_builder.create_html_field_report()

    # Assert
    assert not result
    assert 'Failed to create field report' in caplog.text
    assert 'Unable to write report file' in caplog.text
