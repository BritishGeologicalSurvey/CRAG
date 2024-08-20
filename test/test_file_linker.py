import datetime as dt
from pathlib import Path
from typing import Any

import pytest
from qgis.core import (
    QgsProject,
    QgsVectorLayerUtils,
)
from qgis.PyQt.QtGui import QPixmap
from qgis.PyQt.QtWidgets import (
    QComboBox,
    QFileDialog,
    QLabel,
    QTextEdit,
)

from plugin.field_data_capture import FieldDataCapture
from plugin.file_linker import FileLinker
from plugin.utils import (  # noqa
    get_combobox_items_dict,
    set_combobox_index_by_data,
    ipdb_breakpoint,
)

UnlinkedTestFiles = dict[str, dict[Path, dict[str, str]]]

EXPECTED_COMBOBOX_ITEMS = {
    "QComboBox_locality": {
        "Select Locality Point": None,
        "test_point_001 | 2023-10-31 16:24:14": "{abc43098-fe9b-4da0-b008-7518694466bb}",
        "test_point_002 | 2023-10-31 16:25:36": "{b5bf63bb-0811-4074-99bc-422a78aa5b52}",
    },
}


def get_file_modified_datetime(filepath: Path) -> dt.datetime:
    return dt.datetime.fromtimestamp(filepath.stat().st_mtime).replace(microsecond=0)


@pytest.fixture()
def unlinked_test_files(fdc_project: FieldDataCapture) -> UnlinkedTestFiles:
    """
    Add some unlinked files to project folder for testing.
    Returns a dictionary of layer names as keys, where the values are another dictionary
    which contains unlinked filepaths as keys, where the values are another dictionary
    which contains widget_dict labels as keys, and expected string values for the widgets.
    """
    # Make some sub-directories
    sub_dir_a = fdc_project.photos_dir / "sub_photos_dir_A"
    sub_dir_b = sub_dir_a / "sub_photos_dir_B"
    for sub_dir in [sub_dir_a, sub_dir_b]:
        sub_dir.mkdir()

    # Create copies of existing photos in various directories in project_dir/photos/
    new_photo_a = sub_dir_a / "exif_data.jpg"
    new_photo_a.write_bytes(Path("test/data/photos/exif_data.jpg").read_bytes())
    new_photo_b = sub_dir_b / "no_exif_data.jpg"
    new_photo_b.write_bytes(Path("test/data/photos/no_exif_data.jpg").read_bytes())

    unlinked_files = {
        "photo": {
            new_photo_a:
                {
                    "QLabel_filepath": f"<a href=file://{new_photo_a}>{new_photo_a.name}</a>",
                    "QLabel_file_date": "2023-11-21 14:44:07 | EXIF Metadata",
                },
            new_photo_b:
                {
                    "QLabel_filepath": f"<a href=file://{new_photo_b}>{new_photo_b.name}</a>",
                    "QLabel_file_date": f"{get_file_modified_datetime(new_photo_b)} | File Modified",
                },
        },
    }

    # Add QComboBox_locality to all widget dictionaries
    for files_to_widgets in unlinked_files.values():
        for widget_dict in files_to_widgets.values():
            widget_dict["QComboBox_locality"] = EXPECTED_COMBOBOX_ITEMS["QComboBox_locality"]

    return unlinked_files


def assert_widgets_dict_types(widgets_dict: dict[str, Any]) -> None:
    """
    Check that the widgets in the given dictionary have the correct type.
    """
    assert isinstance(widgets_dict["QLabel_filepath"], QLabel)
    assert isinstance(widgets_dict["QLabel_file_date"], QLabel)
    assert isinstance(widgets_dict["QLabel_image_widget"].pixmap(), QPixmap)
    assert isinstance(widgets_dict["QComboBox_locality"], QComboBox)
    assert isinstance(widgets_dict["QTextEdit_notes"], QTextEdit)


def test_open_file_linker(fdc_project: FieldDataCapture):
    # Act
    fdc_project.open_file_linker()

    # Assert
    assert isinstance(fdc_project.file_linker, FileLinker)
    assert fdc_project.photos_dir == fdc_project.file_linker.photos_dir


def test_close_file_linker(fdc_project: FieldDataCapture):
    # Arrange
    fdc_project.open_file_linker()

    # Act
    fdc_project.file_linker.cancel_button.click()

    # Assert
    assert fdc_project.file_linker is None


def test_select_files_good(
    fdc_project: FieldDataCapture,
    unlinked_test_files: UnlinkedTestFiles,
):
    # Arrange
    # Add a new photo feature with a NULL photo_file attribute to ensure it is not picked up or breaks the linker
    photo_layer = QgsProject.instance().mapLayersByName("photo")[0]
    photo_layer.startEditing()
    photo_feature = QgsVectorLayerUtils.createFeature(photo_layer)
    photo_layer.addFeature(photo_feature)
    photo_layer.commitChanges()

    # Act
    fdc_project.open_file_linker()

    # Assert
    # Check that each photo row contains the correct widgets with the correct settings
    for layer, expected_files_to_widgets in unlinked_test_files.items():
        for filepath, expected_widgets_dict in expected_files_to_widgets.items():
            actual_widgets_dict = fdc_project.file_linker.layers_to_files_to_widgets[layer][filepath]

            assert_widgets_dict_types(actual_widgets_dict)

            # We don't directly compare expected_widgets_dict to actual_widgets_dict because expected is incomplete
            for widget_name, expected_value in expected_widgets_dict.items():

                if widget_name.startswith("QLabel_"):
                    assert expected_value == actual_widgets_dict[widget_name].text()

                elif widget_name.startswith("QCombobox"):
                    assert expected_value == get_combobox_items_dict(actual_widgets_dict[widget_name])

            # Check photo display size
            image_widget = actual_widgets_dict["QLabel_image_widget"]
            assert image_widget.pixmap().width() <= fdc_project.file_linker.thumbnail_size
            assert image_widget.pixmap().height() <= fdc_project.file_linker.thumbnail_size


def test_select_photos_independently(fdc_project: FieldDataCapture, monkeypatch: pytest.MonkeyPatch):
    # Arrange
    # Specify test photos and their expected widget settings
    photo_files = {
        Path("test/data/photos/exif_data.jpg"): {
            "photo_path_label": "<a href=file:test/data/photos/exif_data.jpg>exif_data.jpg</a>",
            "photo_date_label": "2023-11-21 14:44:07 | EXIF Metadata",

        },
        Path("test/data/photos/no_exif_data.jpg"): {
            "photo_path_label": "<a href=file:test/data/photos/no_exif_data.jpg>no_exif_data.jpg</a>",
            "photo_date_label": "2024-06-04 13:56:40 | File Modified",
        },
    }
    fdc_project.open_file_linker()

    # Act 1 - Select a single photo
    # Apply monkey patch for QFileDialog.getOpenFileNames to return the first filepath only
    monkeypatch.setattr(QFileDialog, "getOpenFileNames", lambda *args, **kwargs: [[list(photo_files.keys())[0]]])
    fdc_project.file_linker.select_photos_button.click()

    # Act 2 - Select another single photo
    # Apply monkey patch for QFileDialog.getOpenFileNames to return the first filepath only
    monkeypatch.setattr(QFileDialog, "getOpenFileNames", lambda *args, **kwargs: [[list(photo_files.keys())[1]]])
    fdc_project.file_linker.select_photos_button.click()

    # Assert
    # Check that the widgets have been saved according to both independently selected filepaths
    for photo, widgets_dict in fdc_project.file_linker.photos_to_widgets.items():
        assert photo in photo_files
        assert_widgets_dict_types(widgets_dict)

    # Check that there are 4 items within the photo_rows_layout
    # 2 for rows, 2 for stretch
    assert fdc_project.file_linker.photo_rows_layout.count() == 4


def test_select_photos_independently_duplicate(fdc_project: FieldDataCapture, monkeypatch: pytest.MonkeyPatch):
    # Arrange
    # Specify test photos and their expected widget settings
    photo_file = Path("test/data/photos/exif_data.jpg")
    fdc_project.open_file_linker()

    # Act 1
    # Apply monkey patch for QFileDialog.getOpenFileNames
    monkeypatch.setattr(QFileDialog, "getOpenFileNames", lambda *args, **kwargs: [[photo_file]])
    fdc_project.file_linker.select_photos_button.click()
    # Act 2 - Select the same photo again
    fdc_project.file_linker.select_photos_button.click()

    # Assert
    # Only one photo row widget set should exist as the the user selected the same photo twice
    # Check that the widgets have been saved according to the single filepath
    assert len(fdc_project.file_linker.photos_to_widgets) == 1
    # Check that there is 1 photo row layout and 1 stretch within the photo_rows_layout
    assert fdc_project.file_linker.photo_rows_layout.count() == 2


def test_select_photos_bad_file(fdc_project: FieldDataCapture, monkeypatch: pytest.MonkeyPatch):
    # Arrange
    # These photos already exist in the project
    photo_files = list(fdc_project.photos_dir.glob("*[!.placeholder]"))
    # This photo file does not exist
    photo_files.append(Path("plugin/test/data/photos/not_a_file.jpeg"))
    fdc_project.open_file_linker()

    # Act
    # Apply monkey patch for QFileDialog.getOpenFileNames
    monkeypatch.setattr(QFileDialog, "getOpenFileNames", lambda *args, **kwargs: [photo_files])
    fdc_project.file_linker.select_photos_button.click()

    # Assert
    # Check that no photo widgets were created
    assert len(fdc_project.file_linker.photos_to_widgets) == 0
    assert fdc_project.file_linker.photo_rows_layout.count() == 0


def test_combobox_locality_stylesheet(fdc_project: FieldDataCapture, monkeypatch: pytest.MonkeyPatch):
    # Arrange
    # Select good test photos
    photo_files = [
        Path("test/data/photos/exif_data.jpg"),
        Path("test/data/photos/no_exif_data.jpg"),
    ]
    fdc_project.open_file_linker()

    # Act 1
    # Apply monkey patch for QFileDialog.getOpenFileNames
    monkeypatch.setattr(QFileDialog, "getOpenFileNames", lambda *args, **kwargs: [photo_files])
    fdc_project.file_linker.select_photos_button.click()

    # Assert 1
    # Check that the comboboxes have the correct style sheet on the default value
    for photo in photo_files:
        combobox_locality = fdc_project.file_linker.photos_to_widgets[photo]["QComboBox_locality"]
        assert combobox_locality.currentText() == "Select Locality Point"
        assert combobox_locality.currentData() is None
        assert combobox_locality.styleSheet() == "QComboBox:editable{color: red;}"

    # Act 2
    # Select a different item in the comboboxes
    for photo in photo_files:
        combobox_locality = fdc_project.file_linker.photos_to_widgets[photo]["QComboBox_locality"]
        combobox_locality.setCurrentIndex(1)

    # Assert 2
    # Check that the comboboxes have the correct style sheet on the new value
    for photo in photo_files:
        combobox_locality = fdc_project.file_linker.photos_to_widgets[photo]["QComboBox_locality"]
        assert combobox_locality.currentText() == "test_point_001 | 2023-10-31 16:24:14"
        assert combobox_locality.currentData() == "{abc43098-fe9b-4da0-b008-7518694466bb}"
        assert combobox_locality.styleSheet() == ""


def test_import_selection(
    fdc_project: FieldDataCapture,
    photo_test_files: list[Path],
    monkeypatch: pytest.MonkeyPatch,
):
    # Arrange
    # Selection options for photo_files, the caption describes what changes when imported
    photo_options = [
        {
            "QComboBox_locality": "{abc43098-fe9b-4da0-b008-7518694466bb}",
            "QComboBox_sub_photo_dir": fdc_project.photos_dir,
            "QTextEdit_caption": "Photo is copied to root",
        },
        {
            "QComboBox_locality": "{b5bf63bb-0811-4074-99bc-422a78aa5b52}",
            "QComboBox_sub_photo_dir": fdc_project.photos_dir / "sub_photos_dir_C",
            "QTextEdit_caption": "Photo is copied to sub-directory A",
        },
        {
            "QComboBox_locality": "{abc43098-fe9b-4da0-b008-7518694466bb}",
            "QComboBox_sub_photo_dir": fdc_project.photos_dir / "sub_photos_dir_A",
            "QTextEdit_caption": "Photo is not moved",
        },
        {
            "QComboBox_locality": "{b5bf63bb-0811-4074-99bc-422a78aa5b52}",
            "QComboBox_sub_photo_dir": fdc_project.photos_dir / "sub_photos_dir_A" / "sub_photos_dir_B",
            "QTextEdit_caption": "Photo is moved from root to sub-directory B",
        },
    ]
    photos_to_options = dict(zip(photo_test_files, photo_options))

    fdc_project.open_file_linker()
    # Apply monkey patch for QFileDialog.getOpenFileNames
    monkeypatch.setattr(QFileDialog, "getOpenFileNames", lambda *args, **kwargs: [photo_test_files])
    fdc_project.file_linker.select_photos_button.click()

    # Act
    # Modify input data like a user
    for photo_file, options in photos_to_options.items():

        # Populate values in appropriate widgets
        for widget_name, new_value in options.items():
            widget = fdc_project.file_linker.photos_to_widgets[photo_file][widget_name]
            if widget_name.startswith("QComboBox_"):
                set_combobox_index_by_data(widget, new_value)
            elif widget_name.startswith("QTextEdit_"):
                widget.setText(new_value)

    fdc_project.file_linker.import_selection_button.click()

    # Assert
    photo_layer = QgsProject.instance().mapLayersByName("photo")[0]
    # Check that the layer has been saved
    assert not photo_layer.isModified()
    # Check that the FileLinker closed
    assert fdc_project.file_linker is None
    # Check that the features have correct attributes and the files have been copied/moved in the project
    # Only check the last 4 photo features because they should be the newest ones
    new_features = list(photo_layer.getFeatures())[-4:]
    for (photo_file, options), feature in zip(photos_to_options.items(), new_features):
        assert feature.attribute("locality_fuid") == options["QComboBox_locality"]
        new_photo_file = options["QComboBox_sub_photo_dir"] / photo_file.name
        assert feature.attribute("photo_file") == str(new_photo_file.relative_to(fdc_project.photos_dir))
        assert new_photo_file.exists()
        assert feature.attribute("caption") == options["QTextEdit_caption"]


def test_import_selection_some(fdc_project: FieldDataCapture, monkeypatch: pytest.MonkeyPatch):
    # Arrange
    # Select good test photos
    photo_files = [
        Path("test/data/photos/exif_data.jpg"),
        Path("test/data/photos/no_exif_data.jpg"),
    ]
    fdc_project.open_file_linker()
    # Apply monkey patch for QFileDialog.getOpenFileNames
    monkeypatch.setattr(QFileDialog, "getOpenFileNames", lambda *args, **kwargs: [photo_files])
    fdc_project.file_linker.select_photos_button.click()
    photo_caption = "these are some new notes"

    # Act
    # Modify input data like a user for only the second photo
    photo = photo_files[1]
    # Select a point in the locality combobox
    combobox_locality = fdc_project.file_linker.photos_to_widgets[photo]["QComboBox_locality"]
    combobox_locality.setCurrentIndex(2)
    # Edit the text edit box
    text_edit = fdc_project.file_linker.photos_to_widgets[photo]["QTextEdit_caption"]
    text_edit.setText(photo_caption)
    fdc_project.file_linker.import_selection_button.click()

    # Assert
    photo_layer = QgsProject.instance().mapLayersByName("photo")[0]
    # Check that the layer has been saved
    assert not photo_layer.isModified()
    # Check that the FileLinker closed
    assert fdc_project.file_linker is None
    # Check that there are only 3 photo features and files
    features = list(photo_layer.getFeatures())
    assert len(features) == 3
    assert len(list(fdc_project.photos_dir.glob("*[!.placeholder]"))) == 3
    # Check that the feature has correct photo and the file has been copied into the project
    feature = features[-1]
    assert feature.attribute("photo_file") == photo.name
    assert (fdc_project.photos_dir / photo.name).exists()
    # Check that the caption were also added
    assert feature.attribute("caption") == photo_caption
