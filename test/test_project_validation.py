from pathlib import Path

import pytest

from plugin.field_data_capture import (
    FieldDataCapture,
    FieldDataCaptureProject,
)
from plugin.project_validation import (
    ValidationResult,
    ValidationStatus,
    validate_project,
)
from plugin.utils import (  # noqa
    MultilineMessageBox,
    get_msgbox_icon_pixmap,
    ipdb_breakpoint,
)
from conftest import create_fdc_project_files


@pytest.fixture()
def fdc_project_bad(tmp_path: Path) -> Path:
    """
    Fixture to setup a test project which is purposefully invalid and breaks all validation checks.
    Creates a project with a database which contains some data and photo files.
    """
    project_dir = tmp_path / "fdc_project_invalid"
    project = FieldDataCaptureProject(project_dir)
    feature_filepaths = {
        "photos": [
            Path("test/data/photos/exif_data.jpg"),
            # Does not have a row in the database
            Path("test/data/photos/no_exif_data.jpg"),
        ],
        "media": [],
    }

    create_fdc_project_files(
        project_dir=project_dir,
        insert_data_sql=Path("test/data/fdc_project_invalid.sql"),
        feature_filepaths=feature_filepaths,
    )

    # Add a dummy conflict GeoPackage to the project
    dummy_conflict_gpkg = project_dir / "test_project (conflicted copy).gpkg"
    dummy_conflict_gpkg.touch()

    dummy_unlinked_files = [
        project.photos_dir / project.unlinked_dir_name / "dummy_a.png",
        project.photos_dir / project.unlinked_dir_name / "dummy_b.png",
        project.media_dir / project.unlinked_dir_name / "dummy_c.csv",
    ]
    for dummy_unlinked_file in dummy_unlinked_files:
        dummy_unlinked_file.parent.mkdir(exist_ok=True, parents=True)
        dummy_unlinked_file.touch()

    return project_dir


def test_validate_project_good(fdc_project: FieldDataCapture):
    # Act
    results = validate_project(project_dir=fdc_project.project_dir)

    # Assert
    for result in results:
        assert result.status == ValidationStatus.PASS
        assert result.messages == []


def test_validate_project_bad(fdc_project_bad: Path):
    # Arrange
    expected_results = [
        ValidationResult(
            validation_function='check_project_name',
            status=ValidationStatus.FAIL,
            messages=[
                (f"File name '{fdc_project_bad / "test_project.gpkg"}' "
                 "does not match 'field_project.short_name': leos_test_project"),
                (f"File name '{fdc_project_bad / "test_project.qgz"}' "
                 "does not match 'field_project.short_name': leos_test_project"),
            ]
        ),
        ValidationResult(
            validation_function="check_features_valid_parents",
            status=ValidationStatus.FAIL,
            messages=[
                "Record in 'bedrock_line' with invalid parent 'field_project' found: algal_band",
                "Record in 'locality_point' with invalid parent 'field_project' found: leorudczenko_002",
            ],
        ),
        ValidationResult(
            validation_function="check_locality_children_valid_parents",
            status=ValidationStatus.FAIL,
            messages=[
                "Record in 'media' with invalid parent 'locality_point' found: file_does_no_exist.mov",
                "Record in 'sample' with invalid parent 'locality_point' found: sample_001",
            ],
        ),
        ValidationResult(
            validation_function="check_field_project_plugin_version",
            status=ValidationStatus.FAIL,
            messages=[
                "The 'field_project' record does not include a valid 'qgis_plugin_version'",
            ],
        ),
        ValidationResult(
            validation_function="check_unlinked_attachment_files",
            status=ValidationStatus.WARNING,
            messages=[
                ("Directory 'unlinked' for 'media' table contains 1 file(s), "
                 "these files will not be included in reports or visible in QGIS forms."),
                ("Directory 'unlinked' for 'photo' table contains 2 file(s), "
                 "these files will not be included in reports or visible in QGIS forms."),
            ],
        ),
        ValidationResult(
            validation_function="check_attached_filepaths_not_null",
            status=ValidationStatus.FAIL,
            messages=[
                "File referenced in 'photo' table is NULL, feature ID: 3",
            ],
        ),
        ValidationResult(
            validation_function="check_attached_filepaths_not_placeholder",
            status=ValidationStatus.FAIL,
            messages=[
                "File referenced in 'media' table is placeholder image, feature ID: 2",
            ],
        ),
        ValidationResult(
            validation_function="check_attached_filepaths_exist",
            status=ValidationStatus.FAIL,
            messages=[
                "File referenced in 'media' table not found: file_does_no_exist.mov",
                "File referenced in 'photo' table not found: file_does_no_exist.jpg",
            ],
        ),
        ValidationResult(
            validation_function="check_attachment_filepaths_recorded",
            status=ValidationStatus.FAIL,
            # Project path here is dynamic because it comes from the tmp_path fixture
            messages=[
                f"Unlinked file in 'photo' directory: {fdc_project_bad / 'photos/no_exif_data.jpg'}",
            ],
        ),
        ValidationResult(
            validation_function="check_no_conflict_gpkg_exists",
            status=ValidationStatus.WARNING,
            messages=[
                "Conflict GeoPackage file found: test_project (conflicted copy).gpkg",
            ],
        ),
    ]

    # Act
    results = validate_project(project_dir=fdc_project_bad)

    # Assert
    assert expected_results == results


def test_validation_dialog_pass(fdc_project: FieldDataCapture, monkeypatch_multiline_msgbox):
    # Arrange
    expected_title = "Project Validation"
    expected_message = "Validation for project 'test_project_dir': PASSED"
    expected_text = None

    # Act
    fdc_project.run_project_validation()

    # Assert
    MultilineMessageBox.information.assert_called_once_with(expected_title, expected_message, expected_text)


def test_validation_dialog_fail(fdc_project: FieldDataCapture, monkeypatch_multiline_msgbox):
    # Arrange
    # Add unlinked photo to the project
    dummy_photo = fdc_project.photos_dir / "not_a_photo.png"
    dummy_photo.touch()
    # Add a dummy conflict GeoPackage to the project
    dummy_conflict_gpkg = fdc_project.project_dir / "test_project (conflicted copy).gpkg"
    dummy_conflict_gpkg.touch()

    expected_title = "Project Validation"
    expected_message = "Validation for project 'test_project_dir': FAILED"
    expected_text = "\n".join([
        f"• FAILED: Unlinked file in 'photo' directory: {dummy_photo}",
        "\n• WARNING: Conflict GeoPackage file found: test_project (conflicted copy).gpkg"
    ])

    # Act
    fdc_project.run_project_validation()

    # Assert
    MultilineMessageBox.critical.assert_called_once_with(expected_title, expected_message, expected_text)
