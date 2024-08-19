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


@pytest.fixture()
def photo_test_files(fdc_project: FieldDataCapture) -> list[Path]:
    """
    Add some additional photos/directories to photos folder for testing.
    Returns a list of photos which are good for importing.
    """
    # Make some sub-directories
    sub_dir_a = fdc_project.photos_dir / "sub_photos_dir_A"
    sub_dir_b = sub_dir_a / "sub_photos_dir_B"
    sub_dir_c = fdc_project.photos_dir / "sub_photos_dir_C"
    for sub_dir in [sub_dir_a, sub_dir_b, sub_dir_c]:
        sub_dir.mkdir(exist_ok=True)

    # Create copy of existing photo in project folder and put it in new sub-directory
    new_photo_a = sub_dir_a / "test_img_001.jpeg"
    new_photo_a.write_bytes((fdc_project.photos_dir / "test_point_001.jpeg").read_bytes())
    # Create copy of existing photo in project folder and put it at photo root directory
    new_photo_root = fdc_project.photos_dir / "test_img_002.jpeg"
    new_photo_root.write_bytes((fdc_project.photos_dir / "test_point_002.jpeg").read_bytes())

    photo_files = [
        # Photos outside project photos directory
        Path("test/data/photos/exif_data.jpg"),
        Path("test/data/photos/no_exif_data.jpg"),
        # Photos inside project photos directory
        new_photo_a,
        new_photo_root,
    ]
    return photo_files


def assert_widgets_dict_types(widgets_dict: dict[str, Any]) -> None:
    """
    Check that the widgets in the given dictionary have the correct type.
    """
    assert isinstance(widgets_dict["QLabel_photo_path"], QLabel)
    assert isinstance(widgets_dict["QLabel_photo_date"], QLabel)
    assert isinstance(widgets_dict["QLabel_photo_widget"].pixmap(), QPixmap)
    assert isinstance(widgets_dict["QComboBox_locality"], QComboBox)
    assert isinstance(widgets_dict["QComboBox_sub_photo_dir"], QComboBox)
    assert isinstance(widgets_dict["QTextEdit_caption"], QTextEdit)


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


def test_select_photos_good(
    fdc_project: FieldDataCapture,
    photo_test_files: list[Path],
    monkeypatch: pytest.MonkeyPatch,
):
    # Arrange
    # Specify test photos and their expected values in widgets
    photo_values = [
        {
            "QLabel_photo_path": "<a href=file:test/data/photos/exif_data.jpg>exif_data.jpg</a>",
            "QLabel_photo_date": "2023-11-21 14:44:07 | EXIF Metadata",
            "QComboBox_sub_photo_dir": "photos",
        },
        {
            "QLabel_photo_path": "<a href=file:test/data/photos/no_exif_data.jpg>no_exif_data.jpg</a>",
            # Don't include the actual date becuase it changes
            "QLabel_photo_date": " | File Modified",
            "QComboBox_sub_photo_dir": "photos",
        },
        {
            "QLabel_photo_path": "test_project_dir/photos/sub_photos_dir_A/test_img_001.jpeg>test_img_001.jpeg</a>",
            # Don't include the actual date becuase it changes
            "QLabel_photo_date": " | File Modified",
            # The parent path of the photo should be pre-selected because it is already in the projects photos dir
            "QComboBox_sub_photo_dir": "photos/sub_photos_dir_A",
        },
        {
            "QLabel_photo_path": "test_project_dir/photos/test_img_002.jpeg>test_img_002.jpeg</a>",
            # Don't include the actual date becuase it changes
            "QLabel_photo_date": " | File Modified",
            "QComboBox_sub_photo_dir": "photos",
        },
    ]
    photos_to_labels = dict(zip(photo_test_files, photo_values))

    sub_dir_a = fdc_project.photos_dir / "sub_photos_dir_A"
    expected_combobox_items = {
        "QComboBox_locality": {
            "Select Locality Point": None,
            "test_point_001 | 2023-10-31 16:24:14": "{abc43098-fe9b-4da0-b008-7518694466bb}",
            "test_point_002 | 2023-10-31 16:25:36": "{b5bf63bb-0811-4074-99bc-422a78aa5b52}",
        },
        "QComboBox_sub_photo_dir": {
            "photos": fdc_project.photos_dir.absolute(),
            "photos/sub_photos_dir_A": sub_dir_a.absolute(),
            "photos/sub_photos_dir_A/sub_photos_dir_B": (sub_dir_a / "sub_photos_dir_B").absolute(),
            "photos/sub_photos_dir_C": (fdc_project.photos_dir / "sub_photos_dir_C").absolute(),
        },
    }

    # Add a new photo feature with a NULL photo_file attribute to ensure it is not picked up or breaks the importer
    photo_layer = QgsProject.instance().mapLayersByName("photo")[0]
    photo_layer.startEditing()
    photo_feature = QgsVectorLayerUtils.createFeature(photo_layer)
    photo_layer.addFeature(photo_feature)
    photo_layer.commitChanges()

    # Apply monkey patch for QFileDialog.getOpenFileNames
    monkeypatch.setattr(QFileDialog, "getOpenFileNames", lambda *args, **kwargs: [photo_test_files])
    fdc_project.open_file_linker()

    # Act
    fdc_project.file_linker.select_photos_button.click()

    # Assert
    # Check that each photo row contains the correct widgets with the correct settings
    for photo, labels in photos_to_labels.items():
        widgets_dict = fdc_project.file_linker.photos_to_widgets[photo]
        assert_widgets_dict_types(widgets_dict)

        # Check widget values
        for widget_name, expected_value in labels.items():
            if widget_name.startswith("QComboBox_"):
                assert widgets_dict[widget_name].currentText() == expected_value
            elif widget_name.startswith("QLabel_"):
                # Check in rather than matches because some of them does not include the full date
                assert expected_value in widgets_dict[widget_name].text()

        # Check combobox items
        for combobox_name, expected_items in expected_combobox_items.items():
            assert get_combobox_items_dict(widgets_dict[combobox_name]) == expected_items

        # Check photo display size
        assert widgets_dict["QLabel_photo_widget"].pixmap().width() <= fdc_project.file_linker.photo_widget_size
        assert widgets_dict["QLabel_photo_widget"].pixmap().height() <= fdc_project.file_linker.photo_widget_size


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
