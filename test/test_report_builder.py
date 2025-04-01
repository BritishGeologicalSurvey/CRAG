import builtins
from pathlib import Path
import shutil

from bs4 import BeautifulSoup
import pytest
from PIL import Image
from pypdf import PdfReader
from pypdf.errors import PdfReadError

from conftest import locality_point_count

from plugin.config import THUMBNAIL_SIZE
from plugin.report_builder import ReportBuilder
from plugin.utils import (  # noqa
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


def test_create_field_report(report_builder: ReportBuilder, monkeypatch_qmsgbox_question_yes):
    # Act
    html_success, pdf_success = report_builder.create_field_report()

    # Assert
    if html_success:
        assert report_builder.html_report_file.exists()
        assert report_builder.html_report_file.stat().st_size > 0
        # Check that the method to open the file after creation was called
        report_builder.open_local_filepath.assert_called()
    if pdf_success:
        assert report_builder.pdf_report_file.exists()
        assert report_builder.pdf_report_file.stat().st_size > 0
        # Check that the method to open the file after creation was called
        report_builder.open_local_filepath.assert_called()


def test_create_html_field_report(report_builder: ReportBuilder):
    # Arrange
    report_builder.create_thumbnails()
    report_data = report_builder.get_report_data()

    # Act
    success = report_builder.create_html_field_report(report_data)

    # Assert
    assert success
    # Check file exists and is not empty
    assert report_builder.html_report_file.exists()
    assert report_builder.html_report_file.stat().st_size > 0
    # Confirm the correct number of sections has been created
    soup = BeautifulSoup(report_builder.html_report_file.read_text(encoding="utf-8"), 'lxml')
    project_sections = soup.findAll('section', {'class': "project"})
    assert len(project_sections) == 1
    locality_sections = soup.findAll('section', {'class': "locality_point"})
    row_count = locality_point_count(report_builder)
    assert len(locality_sections) == row_count
    for child in EXPECTED_CHILD_COLUMNS.keys():
        child_sections = soup.findAll('section', {'class': child})
        assert len(child_sections) > 0


def test_create_pdf_field_report(report_builder: ReportBuilder):
    # Arrange
    report_builder.create_thumbnails()
    # Remove one thumbnail to create broken image
    Path(report_builder.thumbnails_dir / 'test_point_001.jpeg').unlink()

    report_data = report_builder.get_report_data()

    # Act
    success = report_builder.create_pdf_field_report(report_data)

    # Assert
    assert success
    # Check file exists and is not empty
    assert report_builder.pdf_report_file.exists()
    assert report_builder.pdf_report_file.stat().st_size > 0
    try:
        pdf = PdfReader(report_builder.pdf_report_file)
    except PdfReadError as exc:
        assert False, f"Invalid PDF {exc}"
    assert len(pdf.pages) == 5
    assert 'Field Report: test field project title' in pdf.pages[0].extract_text()

    assert 'Locality Points\nLocality point: test_point_001' in pdf.pages[1].extract_text()
    # The first image should be absent and replaced by message
    assert len(pdf.pages[2].images) == 0
    assert 'Broken or missing thumbnail:' in pdf.pages[2].extract_text()
    assert 'test_point_001.jpeg' in pdf.pages[2].extract_text()
    assert 'Locality point: test_point_002' in pdf.pages[3].extract_text()
    # The second image should be present
    assert len(pdf.pages[4].images) == 1

    # Calling twice should not concatenate to existing PDF report
    success = report_builder.create_pdf_field_report(report_data)
    pdf = PdfReader(report_builder.pdf_report_file)
    assert len(pdf.pages) == 5


def test_get_report_data(report_builder: ReportBuilder):
    # Act
    report_data = report_builder.get_report_data()

    # Assert
    assert report_data['project']
    # Check that the correct amount of data has been obtained
    row_count = locality_point_count(report_builder)
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


def test_create_field_report_no_db(report_builder: ReportBuilder, caplog):
    # Arrange
    # Remove database to force error
    report_builder.db_file.unlink()

    # Act
    result = report_builder.create_field_report()

    # Assert
    assert result == (False, False)
    assert 'Failed to create field report' in caplog.text
    assert 'Unable to access the geopackage' in caplog.text


def test_create_field_report_pdf_file_open(report_builder: ReportBuilder, monkeypatch, caplog,
                                           monkeypatch_qmsgbox_question_yes):
    # Arrange
    # Force rename to throw an OSError, uses underlying os.rename which
    # takes two arguments.
    def mock_rename(file1, file2):
        raise OSError()
    monkeypatch.setattr(Path, 'rename', mock_rename)

    # The file must also exist for rename to be tried, which means the
    # qmsgbox needs to be acknowledged
    def mock_exists(file):
        return True
    monkeypatch.setattr(Path, 'exists', mock_exists)

    # Act
    result = report_builder.create_field_report()

    # Assert
    assert result == (False, False)
    assert 'Failed to create field report' in caplog.text
    assert 'PDF Report file is open by another process' in caplog.text


@pytest.mark.parametrize("method_name", ["create_html_field_report", "create_pdf_field_report"])
def test_create_reports_file_not_writeable(method_name, report_builder: ReportBuilder,
                                           monkeypatch, caplog):
    # Arrange
    # Force open to throw an OSError, covering several failure types
    def mock_open(file, mode='r', buffering=-1, encoding=None, errors=None, newline=None, closefd=True, opener=None):
        raise OSError()

    monkeypatch.setattr(builtins, 'open', mock_open)
    report_data = report_builder.get_report_data()
    create_report_call = getattr(report_builder, method_name)

    # Act
    result = create_report_call(report_data)

    # Assert
    assert not result
    assert 'Failed to create field report' in caplog.text
    assert 'Unable to write report file' in caplog.text


def test_create_thumbnails(report_builder: ReportBuilder):
    def image_files(dir_path):
        return [p.relative_to(dir_path) for p in dir_path.rglob('*.jpeg')]

    def subdirs(dir_path):
        return [p.relative_to(dir_path) for p in dir_path.rglob('*') if p.is_dir()]

    def assert_images_and_subdirs_match():
        assert image_files(report_builder.photos_dir) == image_files(report_builder.thumbnails_dir)
        assert subdirs(report_builder.photos_dir) == subdirs(report_builder.thumbnails_dir)

    def create_folder_and_nested_image(name):
        existing_image = list(report_builder.photos_dir.rglob('*.jpeg'))[0]
        sub1 = report_builder.photos_dir / name
        sub1.mkdir()
        sub1_image = sub1 / (name + '_image.jpeg')
        sub1_image.write_bytes(existing_image.read_bytes())

    # Initially report_builder has two images in the photos_dir
    create_folder_and_nested_image('sub1')

    # Assert initial state
    assert len(subdirs(report_builder.photos_dir)) == 1
    assert len(image_files(report_builder.photos_dir)) == 3
    assert not report_builder.thumbnails_dir.exists()

    # Test for basic creation from scratch
    report_builder.create_thumbnails()
    assert report_builder.thumbnails_dir.exists()
    assert_images_and_subdirs_match()
    # A thumbnail's maximum dimension should be THUMBNAIL_SIZE pixels
    for path in report_builder.thumbnails_dir.rglob('*.jpeg'):
        im = Image.open(path)
        assert THUMBNAIL_SIZE == max(im.size)

    # Test for running again with no changes
    report_builder.create_thumbnails()
    assert_images_and_subdirs_match()

    # Create a new subfolder and nested image file
    create_folder_and_nested_image('sub2')
    assert len(subdirs(report_builder.photos_dir)) == 2
    assert len(image_files(report_builder.photos_dir)) == 4
    # Test for creation of new subfolder and thumbnail
    report_builder.create_thumbnails()
    assert report_builder.thumbnails_dir.exists()
    assert_images_and_subdirs_match()

    # Remove one thumbnail of four to force thumbnail creation
    list(report_builder.thumbnails_dir.rglob('*.jpeg'))[0].unlink()
    # Confirm removal
    assert len(image_files(report_builder.thumbnails_dir)) == 3
    report_builder.create_thumbnails()
    assert_images_and_subdirs_match()

    # Remove one thumbnail folder of two to force folder and thumbnail creation
    shutil.rmtree([p for p in report_builder.thumbnails_dir.rglob('*') if p.is_dir()][0])
    # Confirm removal
    assert len(subdirs(report_builder.thumbnails_dir)) == 1
    report_builder.create_thumbnails()
    assert_images_and_subdirs_match()

    # Remove one photo of four to force thumbnail deletion
    list(report_builder.photos_dir.rglob('*.jpeg'))[0].unlink()
    # Confirm removal
    assert len(image_files(report_builder.photos_dir)) == 3
    report_builder.create_thumbnails()
    assert_images_and_subdirs_match()

    # Remove one photo folder of two to force folder deletion
    shutil.rmtree([p for p in report_builder.photos_dir.rglob('*') if p.is_dir()][0])
    # Confirm removal
    assert len(subdirs(report_builder.photos_dir)) == 1
    report_builder.create_thumbnails()
    assert_images_and_subdirs_match()
