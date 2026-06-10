# Copyright 2026 UKRI / British Geological Survey
# Licensed under GPLv3 licence
# SPDX-License-Identifier: GPL-3.0-or-later
import builtins
from pathlib import Path
import shutil

from bs4 import BeautifulSoup
from jinja2 import Environment, FileSystemLoader
import pytest
from PIL import Image, ImageOps
from pypdf import PdfReader
from pypdf.errors import PdfReadError

from conftest import locality_point_count, setup_db_conn

from CRAG.config import THUMBNAIL_SIZE
from CRAG.report_builder import ReportBuilder
from CRAG.utils import (  # noqa
    ipdb_breakpoint,
)

# Minimum set of columns needed to produce a report using the templates
EXPECTED_COMMON_COLUMNS = {"recorded_by", "recorded_on"}
EXPECTED_PROJECT_COLUMNS = {"project_lead", "start_date", "end_date", "description"}
EXPECTED_LOCALITY_COLUMNS = {"name", "locality_type_code", "geometry",
                             "locality_description", "map_face_note", "geology_description"}
EXPECTED_CHILD_COLUMNS = {
    "lithology": {"label", "lithology_code"},
    "manmade_landform": {"description", "notes"},
    "media": {"description", "media_type_code", "media_link", "media_description"},
    "photo": {"photo_file", "caption", "description"},
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
    report_headings = soup.find_all('h1')
    assert len(report_headings) == 1
    assert 'Field Report: test field project title' in report_headings[0]
    project_sections = soup.find_all('section', {'class': "project"})
    assert len(project_sections) == 1
    locality_sections = soup.find_all('section', {'class': "locality_point"})
    row_count = locality_point_count(report_builder)
    assert len(locality_sections) == row_count
    for child in EXPECTED_CHILD_COLUMNS.keys():
        child_sections = soup.find_all('section', {'class': child})
        assert len(child_sections) > 0
    paragraph_text = set([p.get_text() for p in soup.find_all('p')])
    assert paragraph_text == {'William Smith building', 'Keyworth', 'Nottingham',
                              'Lyell Centre', 'Research Avenue South', 'Edinburgh'}


def test_create_pdf_field_report(report_builder: ReportBuilder):
    """
    Tests for contents of pdf file.  Note the pdf results are structured by page
    and that page numbers vary depending on contents of the geopackage, so these
    tests may need updating if there are changes to the test data.
    """
    # Arrange
    report_builder.create_thumbnails()
    report_data = report_builder.get_report_data()

    # Act
    success = report_builder.create_pdf_field_report(report_data)

    # Assert
    assert success
    # Check file exists and is not empty
    assert report_builder.pdf_report_file.name == "test_project_field_report.pdf"
    assert report_builder.pdf_report_file.exists()
    assert report_builder.pdf_report_file.stat().st_size > 0
    try:
        pdf = PdfReader(report_builder.pdf_report_file)
    except PdfReadError as exc:
        assert False, f"Invalid PDF {exc}"

    # Check document metadata
    assert 'Field Report: test_project' == pdf.metadata['/Title']
    assert 'test_user' == pdf.metadata['/Author']
    assert 'test field project title' == pdf.metadata['/Subject']
    assert len(pdf.pages) == 6

    # Page 1 - Project information
    page = pdf.pages[0]
    assert 'Field Report: test field project title' in page.extract_text()

    # Page 2 - Start of locality points section.
    page = pdf.pages[1]
    assert 'Locality Points\nLocality point: test_point_001' in page.extract_text()
    assert 'Locality point: test_point_001' in page.extract_text()

    # Page 4 - Photos for test_point_001
    page = pdf.pages[3]
    # Only the jpeg image is valid
    assert len(page.images) == 2
    # The heic image should be absent and replaced by message
    assert 'Broken or missing thumbnail:' in page.extract_text()
    assert 'test_point_001.heic' in page.extract_text()

    # Page 5 - Start of test_point_002
    page = pdf.pages[4]
    assert 'Locality point: test_point_002' in page.extract_text()

    # Page 6 - Photos for test_point_002
    page = pdf.pages[5]
    assert len(page.images) == 1

    # Calling twice should not concatenate to existing PDF report
    success = report_builder.create_pdf_field_report(report_data)
    pdf = PdfReader(report_builder.pdf_report_file)
    assert len(pdf.pages) == 6


def test_create_field_report_no_title(report_builder: ReportBuilder, monkeypatch_qmsgbox_question_yes):
    """
    Tests that creating reports with the title set to NULL succeeds
    and that the short_name is used in place of the title.
    """
    # Arrange
    update_sql = "UPDATE field_project SET title = NULL WHERE fid = 1;"
    with setup_db_conn(report_builder.db_file) as conn:
        conn.executescript(update_sql)

    # Act
    html_success, pdf_success = report_builder.create_field_report()

    # Assert
    assert html_success and pdf_success

    # Confirm short name used for title in HTML
    soup = BeautifulSoup(report_builder.html_report_file.read_text(encoding="utf-8"), 'lxml')
    report_heading = soup.find_all('h1')
    assert 'Field Report: test_project' in report_heading[0]

    # Confirm short name used for title in PDF
    pdf = PdfReader(report_builder.pdf_report_file)
    assert 'test_project' == pdf.metadata['/Subject']
    assert 'Field Report: test_project' in pdf.pages[0].extract_text()


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
    assert result['short_name'] == 'test_project'
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
    fixture = [{'recorded_on': '2023-10-31T16:54:28.908'},
               {'recorded_on': '2023-10-31T16:54:28'},
               {'recorded_on': '2023-10-31T16:54:28.908'}]
    expected = [{'recorded_on': '2023-10-31T16:54:28'},
                {'recorded_on': '2023-10-31T16:54:28'},
                {'recorded_on': '2023-10-31T16:54:28'}]

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
        photo_dirs = [str(sub) for sub in subdirs(report_builder.photos_dir)]
        assert photo_dirs == [str(sub) for sub in subdirs(report_builder.thumbnails_dir)]

    def assert_thumbnail_sizes_and_orientations(thumbnail_size):
        photos = sorted(report_builder.photos_dir.rglob('*.jpeg'))
        thumbnails = sorted(report_builder.thumbnails_dir.rglob('*.jpeg'))
        for index in range(len(photos)):
            tn = Image.open(thumbnails[index])
            # A thumbnail's maximum dimension should be THUMBNAIL_SIZE pixels
            assert thumbnail_size == max(tn.size)
            im = Image.open(photos[index])
            # A thumbnails orientation should be the same as the original image
            ImageOps.exif_transpose(im, in_place=True)
            if im.size[0] >= im.size[1]:
                assert tn.size[0] >= tn.size[1]
            else:
                assert tn.size[0] < tn.size[1]

    def create_folder_and_nested_image(name):
        existing_image = list(report_builder.photos_dir.rglob('*.jpeg'))[0]
        sub1 = report_builder.photos_dir / name
        sub1.mkdir()
        sub1_image = sub1 / (name + '_image.jpeg')
        sub1_image.write_bytes(existing_image.read_bytes())

    # Initially report_builder has two images in the photos_dir
    create_folder_and_nested_image('sub1')

    # Assert initial state
    # There should be the new subdir
    assert len(subdirs(report_builder.photos_dir)) == 1
    assert len(image_files(report_builder.photos_dir)) == 4
    assert not report_builder.thumbnails_dir.exists()

    # Test for basic creation from scratch using reduced thumbnail size
    new_thumbnail_size = int(THUMBNAIL_SIZE / 2)
    report_builder.create_thumbnails(thumbnail_size=new_thumbnail_size)
    assert report_builder.thumbnails_dir.exists()
    assert_images_and_subdirs_match()
    assert_thumbnail_sizes_and_orientations(new_thumbnail_size)

    # Test for recreation after change of thumbnail size back to default
    report_builder.create_thumbnails()
    assert_thumbnail_sizes_and_orientations(THUMBNAIL_SIZE)

    # Test for running again with no changes
    report_builder.create_thumbnails()
    assert_images_and_subdirs_match()
    assert_thumbnail_sizes_and_orientations(THUMBNAIL_SIZE)

    # Create a new subfolder and nested image file
    create_folder_and_nested_image('sub2')
    assert len(subdirs(report_builder.photos_dir)) == 2
    assert len(image_files(report_builder.photos_dir)) == 5
    # Test for creation of new subfolder and thumbnail
    report_builder.create_thumbnails()
    assert report_builder.thumbnails_dir.exists()
    assert_images_and_subdirs_match()

    # Remove one thumbnail of four to force thumbnail creation
    list(report_builder.thumbnails_dir.rglob('*.jpeg'))[0].unlink()
    # Confirm removal
    assert len(image_files(report_builder.thumbnails_dir)) == 4
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
    assert len(image_files(report_builder.photos_dir)) == 4
    report_builder.create_thumbnails()
    assert_images_and_subdirs_match()

    # Remove one photo folder of two to force folder deletion
    shutil.rmtree([p for p in report_builder.photos_dir.rglob('*') if p.is_dir()][0])
    # Confirm removal
    assert len(subdirs(report_builder.photos_dir)) == 1
    report_builder.create_thumbnails()
    assert_images_and_subdirs_match()


@pytest.mark.parametrize(
    "string,split_string",
    [
        ("1\n2\n3", ["1", "2", "3"]),          # simple unix line-breaks
        ("1\\n2\\n3", ["1", "2", "3"]),        # escaped line-breaks
        ("1\n2\n3\n", ["1", "2", "3"]),        # trailing line-break
        ("1\n\n\n2\n3\n\n", ["1", "2", "3"]),  # extra line-breaks
        ("1\r\n2\r\n3", ["1", "2", "3"])       # Windows line-breaks
    ]
)
def test_split_lines(string, split_string):
    report_builder = ReportBuilder()
    assert split_string == report_builder.split_lines(string)


def test_template_macro():
    # Arrange
    test_data = {'test': {
        'none': None,
        'string': 'single_string',
        'one_item': ['single_item_in_list'],
        'multiple_items': ['one', 'two', 'three']
    }}
    environment = Environment(loader=FileSystemLoader("CRAG/templates"))
    template = environment.get_template("test_templates/_test.html")

    # Act
    content = template.render(test_data)

    # Assert
    soup = BeautifulSoup(content, 'lxml')
    # The first section should represent None
    sections = soup.find_all('section', {'class': "none"})
    assert len(sections) == 1
    assert str(test_data['test']['none']) in sections[0].get_text()
    # The next two sections should simply contain the text string
    sections = soup.find_all('section', {'class': "string"})
    assert len(sections) == 1
    assert test_data['test']['string'] in sections[0].get_text()
    sections = soup.find_all('section', {'class': "one_item"})
    assert len(sections) == 1
    assert test_data['test']['one_item'][0] in sections[0].get_text()
    # This section should contain three p tags in order
    sections = soup.find_all('section', {'class': "multiple_items"})
    assert len(sections) == 1
    assert test_data['test']['multiple_items'] == [p.get_text() for p in sections[0].find_all('p')]
