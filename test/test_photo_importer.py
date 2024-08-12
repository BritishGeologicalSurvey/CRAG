from pathlib import Path

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
from plugin.photo_importer import PhotoImporter
from plugin.utils import (  # noqa
    get_combobox_items_dict,
    ipdb_breakpoint,
)


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
    fdc_project.photo_importer.cancel_button.click()

    # Assert
    assert fdc_project.photo_importer is None


def test_select_photos_good(fdc_project: FieldDataCapture, monkeypatch: pytest.MonkeyPatch):
    # Arrange
    expected_combobox_locality_items = {
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

    # Add a new photo feature with a NULL photo_file attribute to ensure it is not picked up or breaks the importer
    photo_layer = QgsProject.instance().mapLayersByName("photo")[0]
    photo_layer.startEditing()
    photo_feature = QgsVectorLayerUtils.createFeature(photo_layer)
    photo_layer.addFeature(photo_feature)
    photo_layer.commitChanges()

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
    # Check that each photo row contains the correct widgets with the correct settings
    for photo, expected_widget_settings in photo_files.items():
        widgets_dict = fdc_project.photo_importer.photos_to_widgets[photo]
        # Check widget types
        assert isinstance(widgets_dict["QLabel_photo_path"], QLabel)
        assert isinstance(widgets_dict["QLabel_photo_date"], QLabel)
        assert isinstance(widgets_dict["QLabel_photo_widget"].pixmap(), QPixmap)
        assert isinstance(widgets_dict["QComboBox_locality"], QComboBox)
        assert isinstance(widgets_dict["QComboBox_sub_photo_dir"], QComboBox)
        assert isinstance(widgets_dict["QTextEdit_caption"], QTextEdit)

        # Check widget settings
        assert expected_widget_settings["photo_path_label"] in widgets_dict["QLabel_photo_path"].text()
        assert get_combobox_items_dict(widgets_dict["QComboBox_locality"]) == expected_combobox_locality_items
        # Check in rather than matches because one of them does not include the full date
        assert expected_widget_settings["photo_date_label"] in widgets_dict["QLabel_photo_date"].text()
        assert widgets_dict["QLabel_photo_widget"].pixmap().width() <= fdc_project.photo_importer.photo_widget_size
        assert widgets_dict["QLabel_photo_widget"].pixmap().height() <= fdc_project.photo_importer.photo_widget_size


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
        # Check widget types
        assert isinstance(widgets_dict["QLabel_photo_path"], QLabel)
        assert isinstance(widgets_dict["QLabel_photo_date"], QLabel)
        assert isinstance(widgets_dict["QLabel_photo_widget"].pixmap(), QPixmap)
        assert isinstance(widgets_dict["QComboBox_locality"], QComboBox)
        assert isinstance(widgets_dict["QComboBox_sub_photo_dir"], QComboBox)
        assert isinstance(widgets_dict["QTextEdit_caption"], QTextEdit)

    # Check that there are 4 items within the photo_rows_layout
    # 2 for rows, 2 for stretch
    assert fdc_project.photo_importer.photo_rows_layout.count() == 4


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
    # Check that there is 1 photo row layout and 1 stretch within the photo_rows_layout
    assert fdc_project.photo_importer.photo_rows_layout.count() == 2


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


def test_combobox_locality_stylesheet(fdc_project: FieldDataCapture, monkeypatch: pytest.MonkeyPatch):
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
        combobox_locality = fdc_project.photo_importer.photos_to_widgets[photo]["QComboBox_locality"]
        assert combobox_locality.currentText() == "Select Locality Point"
        assert combobox_locality.currentData() is None
        assert combobox_locality.styleSheet() == "QComboBox:editable{color: red;}"

    # Act 2
    # Select a different item in the comboboxes
    for photo in photo_files:
        combobox_locality = fdc_project.photo_importer.photos_to_widgets[photo]["QComboBox_locality"]
        combobox_locality.setCurrentIndex(1)

    # Assert 2
    # Check that the comboboxes have the correct style sheet on the new value
    for photo in photo_files:
        combobox_locality = fdc_project.photo_importer.photos_to_widgets[photo]["QComboBox_locality"]
        assert combobox_locality.currentText() == "test_point_001 | 2023-10-31 16:24:14"
        assert combobox_locality.currentData() == "{abc43098-fe9b-4da0-b008-7518694466bb}"
        assert combobox_locality.styleSheet() == ""


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
    photo_caption = "these are some new notes"

    # Act
    # Modify input data like a user
    for idx, photo in enumerate(photo_files):
        # Select a point in the locality combobox
        combobox_locality = fdc_project.photo_importer.photos_to_widgets[photo]["QComboBox_locality"]
        # Add 1 to index because index 0 is no selection
        combobox_locality.setCurrentIndex(idx + 1)
        # Edit the text edit box
        text_edit = fdc_project.photo_importer.photos_to_widgets[photo]["QTextEdit_caption"]
        text_edit.setText(photo_caption)
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
        # Check that the caption were also added
        assert feature.attribute("caption") == photo_caption


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
    photo_caption = "these are some new notes"

    # Act
    # Modify input data like a user for only the second photo
    photo = photo_files[1]
    # Select a point in the locality combobox
    combobox_locality = fdc_project.photo_importer.photos_to_widgets[photo]["QComboBox_locality"]
    combobox_locality.setCurrentIndex(2)
    # Edit the text edit box
    text_edit = fdc_project.photo_importer.photos_to_widgets[photo]["QTextEdit_caption"]
    text_edit.setText(photo_caption)
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
    # Check that the caption were also added
    assert feature.attribute("caption") == photo_caption
