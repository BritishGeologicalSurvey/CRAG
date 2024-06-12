from pathlib import Path

import pytest
from qgis.core import QgsProject
from qgis.PyQt.QtGui import QPixmap
from qgis.PyQt.QtWidgets import (
    QComboBox,
    QFileDialog,
    QLabel,
    QTextEdit,
)

from plugin.field_data_capture import FieldDataCapture
from plugin.photo_importer import PhotoImporter
from plugin.utils import ipdb_breakpoint  # noqa


def test_open_photo_importer(fdc_project: FieldDataCapture):
    # Act
    fdc_project.open_photo_importer()

    # Assert
    assert isinstance(fdc_project.photo_importer, PhotoImporter)
    assert fdc_project.photos_dir == fdc_project.photo_importer.photos_dir


def test_close_photo_importer(fdc_project: FieldDataCapture):
    # Arrange
    fdc_project.open_photo_importer()

    # Act
    fdc_project.photo_importer.photo_importer_closed.emit()

    # Assert
    assert fdc_project.photo_importer is None


def test_select_photos_good(fdc_project: FieldDataCapture, monkeypatch: pytest.MonkeyPatch):
    # Arrange
    expected_combobox_items = {
        "Select Locality Point": None,
        "test_point_001 | 2023-10-31 16:24:14": "{abc43098-fe9b-4da0-b008-7518694466bb}",
        "test_point_002 | 2023-10-31 16:25:36": "{b5bf63bb-0811-4074-99bc-422a78aa5b52}",
    }

    # Copy one of the test photos into the photos directory to ensure it can still be imported
    sub_photos_dir = fdc_project.photos_dir / "sub_photos_dir"
    sub_photos_dir.mkdir(exist_ok=True)
    original_photo = Path("test/data/photos/exif_data.jpg")
    copied_photo = sub_photos_dir / original_photo.name
    copied_photo.write_bytes(original_photo.read_bytes())

    # Specify test photos and their expected widget settings
    photo_files = {
        copied_photo: {
            # Don't include the full path because it changes
            "photo_path_label": "test_project_dir/photos/sub_photos_dir/exif_data.jpg>exif_data.jpg</a>",
            "photo_date_label": "2023-11-21 14:44:07 | EXIF Metadata",
        },
        Path("test/data/photos/no_exif_data.jpg"): {
            "photo_path_label": "<a href=file:test/data/photos/no_exif_data.jpg>no_exif_data.jpg</a>",
            # Don't include the actual date becuase it changes
            "photo_date_label": " | File Modified",
        },
    }
    # Apply monkey patch for QFileDialog.getOpenFileNames
    monkeypatch.setattr(QFileDialog, "getOpenFileNames", lambda *args, **kwargs: [photo_files])
    fdc_project.open_photo_importer()

    # Act
    fdc_project.photo_importer.select_photos_button.click()

    # Assert
    # Check that the widgets have been saved according to their photo paths
    for photo, widgets_dict in fdc_project.photo_importer.photos_to_widgets.items():
        assert photo in photo_files
        assert isinstance(widgets_dict["QComboBox"], QComboBox)
        assert isinstance(widgets_dict["QTextEdit"], QTextEdit)

    # Check that each photo row contains the correct widgets with the correct settings
    for idx, (photo, expected_widget_settings) in enumerate(photo_files.items()):
        row_layout = fdc_project.photo_importer.photo_rows_layout.itemAt(idx).widget().layout()
        # Extract the widgets from the layout
        photo_path_label = row_layout.itemAt(0).layout().itemAt(0).widget()
        combobox = row_layout.itemAt(0).layout().itemAt(1).widget()
        photo_date_label = row_layout.itemAt(1).layout().itemAt(0).widget()
        photo_widget = row_layout.itemAt(2).layout().itemAt(0).widget()

        # Check widget types
        assert isinstance(photo_path_label, QLabel)
        assert isinstance(combobox, QComboBox)
        assert isinstance(photo_date_label, QLabel)
        assert isinstance(photo_widget.pixmap(), QPixmap)

        # Check widget settings
        assert expected_widget_settings["photo_path_label"] in photo_path_label.text()
        for idx, (expected_text, expected_data) in enumerate(expected_combobox_items.items()):
            assert combobox.itemText(idx) == expected_text
            assert combobox.itemData(idx) == expected_data
        # Check in rather than matches because one of them does not include the full date
        assert expected_widget_settings["photo_date_label"] in photo_date_label.text()
        assert photo_widget.pixmap().width() <= fdc_project.photo_importer.photo_widget_size
        assert photo_widget.pixmap().height() <= fdc_project.photo_importer.photo_widget_size


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
    fdc_project.open_photo_importer()

    # Act 1 - Select a single photo
    # Apply monkey patch for QFileDialog.getOpenFileNames to return the first filepath only
    monkeypatch.setattr(QFileDialog, "getOpenFileNames", lambda *args, **kwargs: [[list(photo_files.keys())[0]]])
    fdc_project.photo_importer.select_photos_button.click()

    # Act 2 - Select another single photo
    # Apply monkey patch for QFileDialog.getOpenFileNames to return the first filepath only
    monkeypatch.setattr(QFileDialog, "getOpenFileNames", lambda *args, **kwargs: [[list(photo_files.keys())[1]]])
    fdc_project.photo_importer.select_photos_button.click()

    # Assert
    # Check that the widgets have been saved according to both independently selected filepaths
    for photo, widgets_dict in fdc_project.photo_importer.photos_to_widgets.items():
        assert photo in photo_files
        assert isinstance(widgets_dict["QComboBox"], QComboBox)
        assert isinstance(widgets_dict["QTextEdit"], QTextEdit)

    # Check that there are 2 photo row layouts within the the photo_rows_layout
    assert fdc_project.photo_importer.photo_rows_layout.count() == 2


def test_select_photos_independently_duplicate(fdc_project: FieldDataCapture, monkeypatch: pytest.MonkeyPatch):
    # Arrange
    # Specify test photos and their expected widget settings
    photo_file = Path("test/data/photos/exif_data.jpg")
    fdc_project.open_photo_importer()

    # Act 1
    # Apply monkey patch for QFileDialog.getOpenFileNames
    monkeypatch.setattr(QFileDialog, "getOpenFileNames", lambda *args, **kwargs: [[photo_file]])
    fdc_project.photo_importer.select_photos_button.click()
    # Act 2 - Select the same photo again
    fdc_project.photo_importer.select_photos_button.click()

    # Assert
    # Only one photo row widget set should exist as the the user selected the same photo twice
    # Check that the widgets have been saved according to the single filepath
    assert len(fdc_project.photo_importer.photos_to_widgets) == 1
    # Check that there is 1 photo row layout within the the photo_rows_layout
    assert fdc_project.photo_importer.photo_rows_layout.count() == 1


def test_select_photos_bad_file(fdc_project: FieldDataCapture, monkeypatch: pytest.MonkeyPatch):
    # Arrange
    # These photos already exist in the project
    photo_files = list(fdc_project.photos_dir.glob("*[!.placeholder]"))
    # This photo file does not exist
    photo_files.append(Path("plugin/test/data/photos/not_a_file.jpeg"))
    fdc_project.open_photo_importer()

    # Act
    # Apply monkey patch for QFileDialog.getOpenFileNames
    monkeypatch.setattr(QFileDialog, "getOpenFileNames", lambda *args, **kwargs: [photo_files])
    fdc_project.photo_importer.select_photos_button.click()

    # Assert
    # Check that no photo widgets were created
    assert len(fdc_project.photo_importer.photos_to_widgets) == 0
    assert fdc_project.photo_importer.photo_rows_layout.count() == 0


def test_combobox_stylesheet(fdc_project: FieldDataCapture, monkeypatch: pytest.MonkeyPatch):
    # Arrange
    # Select good test photos
    photo_files = [
        Path("test/data/photos/exif_data.jpg"),
        Path("test/data/photos/no_exif_data.jpg"),
    ]
    fdc_project.open_photo_importer()

    # Act 1
    # Apply monkey patch for QFileDialog.getOpenFileNames
    monkeypatch.setattr(QFileDialog, "getOpenFileNames", lambda *args, **kwargs: [photo_files])
    fdc_project.photo_importer.select_photos_button.click()

    # Assert 1
    # Check that the comboboxes have the correct style sheet on the default value
    for photo in photo_files:
        combobox = fdc_project.photo_importer.photos_to_widgets[photo]["QComboBox"]
        assert combobox.currentText() == "Select Locality Point"
        assert combobox.currentData() is None
        assert combobox.styleSheet() == "QComboBox:editable{color: red;}"

    # Act 2
    # Select a different item in the comboboxes
    for photo in photo_files:
        combobox = fdc_project.photo_importer.photos_to_widgets[photo]["QComboBox"]
        combobox.setCurrentIndex(1)

    # Assert 2
    # Check that the comboboxes have the correct style sheet on the new value
    for photo in photo_files:
        combobox = fdc_project.photo_importer.photos_to_widgets[photo]["QComboBox"]
        assert combobox.currentText() == "test_point_001 | 2023-10-31 16:24:14"
        assert combobox.currentData() == "{abc43098-fe9b-4da0-b008-7518694466bb}"
        assert combobox.styleSheet() == ""


def test_import_selection(fdc_project: FieldDataCapture, monkeypatch: pytest.MonkeyPatch):
    # Arrange
    # Select good test photos
    photo_files = [
        Path("test/data/photos/exif_data.jpg"),
        Path("test/data/photos/no_exif_data.jpg"),
    ]
    fdc_project.open_photo_importer()
    # Apply monkey patch for QFileDialog.getOpenFileNames
    monkeypatch.setattr(QFileDialog, "getOpenFileNames", lambda *args, **kwargs: [photo_files])
    fdc_project.photo_importer.select_photos_button.click()
    photo_notes = "these are some new notes"

    # Act
    # Modify input data like a user
    for idx, photo in enumerate(photo_files):
        # Select a point in the combobox
        combobox = fdc_project.photo_importer.photos_to_widgets[photo]["QComboBox"]
        # Add 1 to index because index 0 is no selection
        combobox.setCurrentIndex(idx + 1)
        # Edit the text edit box
        text_edit = fdc_project.photo_importer.photos_to_widgets[photo]["QTextEdit"]
        text_edit.setText(photo_notes)
    fdc_project.photo_importer.import_selection_button.click()

    # Assert
    photo_layer = QgsProject.instance().mapLayersByName("photo")[0]
    # Check that the layer has been saved
    assert not photo_layer.isModified()
    # Check that the PhotoImporter closed
    assert fdc_project.photo_importer is None
    # Check that the features have correct photos and the files have been copied into the project
    # Only check the last 2 photo features because they should be the newest ones
    for photo, feature in zip(photo_files, list(photo_layer.getFeatures())[-2:]):
        assert feature.attribute("photo_file") == photo.name
        assert (fdc_project.photos_dir / photo.name).exists()
        # Check that the notes were also added
        assert feature.attribute("notes") == photo_notes


def test_import_selection_some(fdc_project: FieldDataCapture, monkeypatch: pytest.MonkeyPatch):
    # Arrange
    # Select good test photos
    photo_files = [
        Path("test/data/photos/exif_data.jpg"),
        Path("test/data/photos/no_exif_data.jpg"),
    ]
    fdc_project.open_photo_importer()
    # Apply monkey patch for QFileDialog.getOpenFileNames
    monkeypatch.setattr(QFileDialog, "getOpenFileNames", lambda *args, **kwargs: [photo_files])
    fdc_project.photo_importer.select_photos_button.click()
    photo_notes = "these are some new notes"

    # Act
    # Modify input data like a user for only the second photo
    photo = photo_files[1]
    # Select a point in the combobox
    combobox = fdc_project.photo_importer.photos_to_widgets[photo]["QComboBox"]
    combobox.setCurrentIndex(2)
    # Edit the text edit box
    text_edit = fdc_project.photo_importer.photos_to_widgets[photo]["QTextEdit"]
    text_edit.setText(photo_notes)
    fdc_project.photo_importer.import_selection_button.click()

    # Assert
    photo_layer = QgsProject.instance().mapLayersByName("photo")[0]
    # Check that the layer has been saved
    assert not photo_layer.isModified()
    # Check that the PhotoImporter closed
    assert fdc_project.photo_importer is None
    # Check that there are only 3 photo features and files
    features = list(photo_layer.getFeatures())
    assert len(features) == 3
    assert len(list(fdc_project.photos_dir.glob("*[!.placeholder]"))) == 3
    # Check that the feature has correct photo and the file has been copied into the project
    feature = features[-1]
    assert feature.attribute("photo_file") == photo.name
    assert (fdc_project.photos_dir / photo.name).exists()
    # Check that the notes were also added
    assert feature.attribute("notes") == photo_notes
