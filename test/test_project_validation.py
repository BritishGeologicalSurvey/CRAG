# Copyright 2026 UKRI / British Geological Survey
# Licensed under GPLv3 licence
# SPDX-License-Identifier: GPL-3.0-or-later
from pathlib import Path

import pytest

from CRAG.crag import (
    Crag,
    CragProject,
)
from CRAG.project_validation import (
    ValidationResult,
    ValidationStatus,
    validate_project,
)
from CRAG.utils import MultilineMessageBox
from conftest import create_crag_project_files


@pytest.fixture()
def crag_project_bad(tmp_path: Path) -> Path:
    """
    Fixture to setup a test project which is purposefully invalid and breaks all validation checks.
    Creates a project with a database which contains some data and photo files.
    """
    project_dir = tmp_path / "crag_project_invalid"
    project = CragProject(project_dir)
    feature_filepaths = {
        "photos": [
            Path("test/data/photos/exif_data.jpg"),
            # Does not have a row in the database
            Path("test/data/photos/no_exif_data.jpg"),
        ],
        "media": [],
        "_crag": [],
        # baseline_data omitted for test
    }

    create_crag_project_files(
        project_dir=project_dir,
        insert_data_sql=Path("test/data/crag_project_invalid.sql"),
        feature_filepaths=feature_filepaths,
    )

    # Add a dummy conflict GeoPackage to the project
    dummy_conflict_gpkg = project_dir / "test_project (conflicted copy).gpkg"
    dummy_conflict_gpkg.touch()

    # Add a dummy user file to the project
    dummy_user_file = project_dir / "test_project.doc"
    dummy_user_file.touch()

    dummy_unlinked_files = [
        project.unlinked_files_dir / "dummy_a.png",
        project.unlinked_files_dir / "dummy_b.png",
        project.unlinked_files_dir / "dummy_c.csv",
    ]
    for dummy_unlinked_file in dummy_unlinked_files:
        dummy_unlinked_file.parent.mkdir(exist_ok=True, parents=True)
        dummy_unlinked_file.touch()

    return project_dir


def test_validate_project_good(crag_project_quick: Crag):
    # Arrange
    # Delete unlinked file in test project to get passing validation
    unlinked_file = crag_project_quick.unlinked_files_dir / "test_unlinked_photo.jpeg"
    unlinked_file.unlink()

    # Act
    results = validate_project(project_dir=crag_project_quick.project_dir)

    # Assert
    for result in results:
        assert result.status == ValidationStatus.PASSED
        assert result.messages == []


def test_validate_project_warn(crag_project_quick: Crag):
    # Act
    results = validate_project(project_dir=crag_project_quick.project_dir)

    # Assert
    for result in results:
        assert result.status in (ValidationStatus.PASSED, ValidationStatus.WARNING)
        if result.status == ValidationStatus.WARNING:
            assert result.messages == [
                "Directory 'unlinked_files' contains 1 file(s), "
                "these files will not be included in reports or visible in QGIS forms."
            ]


def test_validate_project_bad(crag_project_bad: Path):
    # Arrange
    expected_results = [
        ValidationResult(
            validation_function='check_project_name',
            status=ValidationStatus.FAILED,
            messages=[
                (f"File name '{crag_project_bad / "test_project.gpkg"}' "
                 "does not match 'field_project.short_name': user_a_test_project"),
                (f"File name '{crag_project_bad / "test_project.qgz"}' "
                 "does not match 'field_project.short_name': user_a_test_project"),
            ]
        ),
        ValidationResult(
            validation_function="check_features_valid_parents",
            status=ValidationStatus.FAILED,
            messages=[
                "Record in 'bedrock_line' with invalid parent 'field_project' found: algal_band",
                "Record in 'locality_point' with invalid parent 'field_project' found: user_a_002",
            ],
        ),
        ValidationResult(
            validation_function="check_locality_children_valid_parents",
            status=ValidationStatus.FAILED,
            messages=[
                "Record in 'media' with invalid parent 'locality_point' found: file_does_no_exist.mov",
                "Record in 'sample' with invalid parent 'locality_point' found: sample_001",
            ],
        ),
        ValidationResult(
            validation_function="check_field_project_plugin_version",
            status=ValidationStatus.FAILED,
            messages=[
                "The 'field_project' record does not include a valid 'qgis_plugin_version'",
            ],
        ),
        ValidationResult(
            validation_function="check_unlinked_attachment_files",
            status=ValidationStatus.WARNING,
            messages=[
                ("Directory 'unlinked_files' contains 3 file(s), "
                 "these files will not be included in reports or visible in QGIS forms."),
            ],
        ),
        ValidationResult(
            validation_function="check_attached_filepaths_not_null",
            status=ValidationStatus.FAILED,
            messages=[
                "File referenced in 'photo' table is NULL, feature ID: 3",
            ],
        ),
        ValidationResult(
            validation_function="check_attached_filepaths_not_placeholder",
            status=ValidationStatus.FAILED,
            messages=[
                "File referenced in 'media' table is placeholder image, feature ID: 2",
            ],
        ),
        ValidationResult(
            validation_function="check_attached_filepaths_exist",
            status=ValidationStatus.FAILED,
            messages=[
                "File referenced in 'media' table not found: file_does_no_exist.mov",
                "File referenced in 'photo' table not found: file_does_no_exist.jpg",
            ],
        ),
        ValidationResult(
            validation_function="check_attachment_filepaths_recorded",
            status=ValidationStatus.FAILED,
            # Project path here is dynamic because it comes from the tmp_path fixture
            messages=[
                f"Unlinked file in 'photo' directory: {crag_project_bad / 'photos/no_exif_data.jpg'}",
            ],
        ),
        ValidationResult(
            validation_function="check_no_conflict_gpkg_exists",
            status=ValidationStatus.WARNING,
            messages=[
                "Conflict GeoPackage file found: test_project (conflicted copy).gpkg",
            ],
        ),
        ValidationResult(
            validation_function='check_required_filepaths_in_project_dir',
            status=ValidationStatus.FAILED,
            messages=[
                "Required file or directory missing from project directory: baseline_data",
            ],
        ),
        ValidationResult(
            validation_function='check_no_user_filepaths_in_project_dir',
            status=ValidationStatus.WARNING,
            messages=[
                "User file found in project dir: test_project.doc; "
                "all user files should be in media, photos, baseline_data "
                "or unlinked files",
            ],
        ),
    ]

    # Act
    results = validate_project(project_dir=crag_project_bad)

    # Assert
    assert expected_results == results


def test_validation_dialog_pass(crag_project_quick: Crag):
    # Arrange
    # Delete unlinked file in test project to get passing validation
    unlinked_file = crag_project_quick.unlinked_files_dir / "test_unlinked_photo.jpeg"
    unlinked_file.unlink()
    expected_title = "Project Validation"
    expected_message = "Validation for project 'test_project_dir': PASSED"
    expected_text = None

    # Act
    crag_project_quick.run_project_validation()

    # Assert
    MultilineMessageBox.information.assert_called_once_with(expected_title, expected_message, expected_text)


def test_validation_dialog_fail(crag_project_quick: Crag):
    # Arrange
    # Add unlinked photo to the project
    dummy_photo = crag_project_quick.photos_dir / "not_a_photo.png"
    dummy_photo.touch()
    # Add a dummy conflict GeoPackage to the project
    dummy_conflict_gpkg = crag_project_quick.project_dir / "test_project (conflicted copy).gpkg"
    dummy_conflict_gpkg.touch()

    expected_title = "Project Validation"
    expected_message = "Validation for project 'test_project_dir': FAILED"
    expected_text = "\n".join([
        ("• WARNING: Directory 'unlinked_files' contains 1 file(s), "
         "these files will not be included in reports or visible in QGIS forms."),
        f"\n• FAILED: Unlinked file in 'photo' directory: {dummy_photo}",
        "\n• WARNING: Conflict GeoPackage file found: test_project (conflicted copy).gpkg"
    ])

    # Act
    crag_project_quick.run_project_validation()

    # Assert
    MultilineMessageBox.critical.assert_called_once_with(expected_title, expected_message, expected_text)


def test_validation_dialog_warning(crag_project_quick: Crag):
    # Arrange
    # Add a dummy conflict GeoPackage to the project
    dummy_conflict_gpkg = crag_project_quick.project_dir / "test_project (conflicted copy).gpkg"
    dummy_conflict_gpkg.touch()

    expected_title = "Project Validation"
    expected_message = "Validation for project 'test_project_dir': WARNING"
    expected_text = "\n".join([
        ("• WARNING: Directory 'unlinked_files' contains 1 file(s), "
         "these files will not be included in reports or visible in QGIS forms."),
        "\n• WARNING: Conflict GeoPackage file found: test_project (conflicted copy).gpkg"
    ])

    # Act
    crag_project_quick.run_project_validation()

    # Assert
    MultilineMessageBox.warning.assert_called_once_with(expected_title, expected_message, expected_text)
