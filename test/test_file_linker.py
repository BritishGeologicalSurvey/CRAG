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
    QLabel,
    QMessageBox,
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
WIDGET_NAMES_TO_ATTRIBUTES_NAMES = {
    "photo": {
        "QComboBox_locality": "locality_fuid",
        "QTextEdit_notes": "caption",
    },
}


def get_file_modified_datetime(filepath: Path) -> dt.datetime:
    """
    Get the file modified string timestamp from the given filepath, as it would be displayed in the FileLinker.
    """
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
    sub_dir_a = fdc_project.photos_dir / "sub_dir_A"
    sub_dir_b = sub_dir_a / "sub_dir_B"
    for sub_dir in [sub_dir_a, sub_dir_b]:
        sub_dir.mkdir()

    # Create copies of existing photos in various directories in project_dir/photos/
    new_photo_a = sub_dir_a / "exif_data.jpg"
    new_photo_a.write_bytes(Path("test/data/photos/exif_data.jpg").read_bytes())
    new_photo_b = sub_dir_b / "no_exif_data.jpg"
    new_photo_b.write_bytes(Path("test/data/photos/no_exif_data.jpg").read_bytes())
    new_photo_c = sub_dir_a / "test_img_001.jpeg"
    new_photo_c.write_bytes((fdc_project.photos_dir / "test_point_001.jpeg").read_bytes())

    unlinked_files = {
        "photo": {
            new_photo_a:
                {"QLabel_file_date": "2023-11-21 14:44:07 | EXIF Metadata"},
            new_photo_b:
                {"QLabel_file_date": f"{get_file_modified_datetime(new_photo_b)} | File Modified"},
            new_photo_c:
                {"QLabel_file_date": f"{get_file_modified_datetime(new_photo_c)} | File Modified"},
        },
    }

    # Add QComboBox_locality to all widget dictionaries
    for files_to_widgets in unlinked_files.values():
        for filepath, widget_dict in files_to_widgets.items():
            widget_dict["QComboBox_locality"] = EXPECTED_COMBOBOX_ITEMS["QComboBox_locality"]
            # Dynamically add expected filepath label for all files
            widget_dict["QLabel_filepath"] = f"<a href=file://{filepath}>{filepath.name}</a>"

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


def test_open_file_linker_good(
    fdc_project: FieldDataCapture,
    unlinked_test_files: UnlinkedTestFiles,
):
    # Act
    result = fdc_project.open_file_linker()

    # Assert
    assert result
    assert isinstance(fdc_project.file_linker, FileLinker)
    assert fdc_project.photos_dir == fdc_project.file_linker.photos_dir


def test_open_file_linker_bad(fdc_project: FieldDataCapture):
    # Act
    result = fdc_project.open_file_linker()

    # Assert
    assert not result
    assert fdc_project.file_linker is None
    parent_dir = fdc_project.photos_dir.relative_to(fdc_project.project_dir.parent)
    QMessageBox.warning.assert_called_once_with(
        None,
        "No Unlinked Files Found",
        f"Could not find any unlinked files in the folder:\n\n{parent_dir}",
    )


def test_close_file_linker(
    fdc_project: FieldDataCapture,
    unlinked_test_files: UnlinkedTestFiles,
):
    # Arrange
    fdc_project.open_file_linker()

    # Act
    fdc_project.file_linker.cancel_button.click()

    # Assert
    assert fdc_project.file_linker is None


def test_select_files(
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
    for layer_name, expected_files_to_widgets in unlinked_test_files.items():
        for filepath, expected_widgets_dict in expected_files_to_widgets.items():
            actual_widgets_dict = fdc_project.file_linker.layers_to_files_to_widgets[layer_name][filepath]

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


def test_combobox_locality_stylesheet(
    fdc_project: FieldDataCapture,
    unlinked_test_files: UnlinkedTestFiles,
):
    # Act 1
    fdc_project.open_file_linker()

    # Assert 1
    # Check that the comboboxes have the correct style sheet on the default value
    for layer_name, files_to_widgets in unlinked_test_files.items():
        for filepath in files_to_widgets:
            actual_widgets_dict = fdc_project.file_linker.layers_to_files_to_widgets[layer_name][filepath]
            combobox_locality = actual_widgets_dict["QComboBox_locality"]
            assert combobox_locality.currentText() == "Select Locality Point"
            assert combobox_locality.currentData() is None
            assert combobox_locality.styleSheet() == "QComboBox:editable{color: red;}"

    # Act 2
    # Select a different item in the comboboxes
    for layer_name, files_to_widgets in unlinked_test_files.items():
        for filepath in files_to_widgets:
            actual_widgets_dict = fdc_project.file_linker.layers_to_files_to_widgets[layer_name][filepath]
            combobox_locality = actual_widgets_dict["QComboBox_locality"]
            combobox_locality.setCurrentIndex(1)

    # Assert 2
    # Check that the comboboxes have the correct style sheet on the new value
    for layer_name, files_to_widgets in unlinked_test_files.items():
        for filepath in files_to_widgets:
            actual_widgets_dict = fdc_project.file_linker.layers_to_files_to_widgets[layer_name][filepath]
            combobox_locality = actual_widgets_dict["QComboBox_locality"]
            assert combobox_locality.currentText() == "test_point_001 | 2023-10-31 16:24:14"
            assert combobox_locality.currentData() == "{abc43098-fe9b-4da0-b008-7518694466bb}"
            assert combobox_locality.styleSheet() == ""


def test_link_selection(
    fdc_project: FieldDataCapture,
    unlinked_test_files: UnlinkedTestFiles,
):
    # Arrange
    layers_to_files_to_options = {
        "photo": {
            Path("sub_dir_A/test_img_001.jpeg"): {
                "QComboBox_locality": "{b5bf63bb-0811-4074-99bc-422a78aa5b52}",
                "QTextEdit_notes": "Caption for test_img_001.jpeg",
            },
            Path("sub_dir_A/exif_data.jpg"): {
                # Don't select this file, it should not be saved to the database
                "QComboBox_locality": None,
                "QTextEdit_notes": "Caption for exif_data.jpg",
            },
            Path("sub_dir_A/sub_dir_B/no_exif_data.jpg"): {
                # Don't select this file, it should not be saved to the database
                "QComboBox_locality": "{abc43098-fe9b-4da0-b008-7518694466bb}",
                "QTextEdit_notes": "Caption for no_exif_data.jpg",
            },
        }
    }
    fdc_project.open_file_linker()

    # Act
    modify_file_linker_inputs(fdc_project.file_linker, layers_to_files_to_options)
    fdc_project.file_linker.link_selection_button.click()

    # Assert
    # Check that the FileLinker closed
    assert fdc_project.file_linker is None

    for layer_name in unlinked_test_files:
        layer = QgsProject.instance().mapLayersByName(layer_name)[0]
        layer_dir = fdc_project.layers_to_dirs[layer_name]
        widgets_to_attributes = WIDGET_NAMES_TO_ATTRIBUTES_NAMES[layer_name]

        # Check that the layer has been saved
        assert not layer.isModified()

        # Check that the features have correct attributes
        # Only check the last X features where the option for locality is not None
        # because they should be the newest ones
        expected_new_features = len([
            file_options
            for file_options in layers_to_files_to_options[layer_name].values()
            if file_options["QComboBox_locality"] is not None
        ])
        new_features = iter(list(layer.getFeatures())[-expected_new_features:])

        for filepath, expected_file_options in layers_to_files_to_options[layer_name].items():
            # If the file was meant to have a selected locality, it should exist as a feature
            if expected_file_options["QComboBox_locality"] is not None:
                # Get the next new feature
                feature = next(new_features)

                file_attribute = Path(feature.attribute(fdc_project.layers_to_file_attributes[layer_name]))
                # Check that the relative path exists in the directory
                assert (layer_dir / file_attribute).exists()
                assert file_attribute == filepath

                # Check that input widget values have been saved correclty
                for widget_name, expected_value in expected_file_options.items():
                    assert feature.attribute(widgets_to_attributes[widget_name]) == expected_value


def modify_file_linker_inputs(
    file_linker: FileLinker,
    layers_to_files_to_options: dict[str, dict[Path, dict[str, str]]]
) -> None:
    """
    Modify the inputs of the given FileLinker dialog using the given dictionary of options.
    This directly modified the widgets in the dialog, like a user would.
    """
    for layer_name, files_to_widgets in file_linker.layers_to_files_to_widgets.items():
        layer_dir = file_linker.layers_to_dirs[layer_name]

        for filepath, widgets_dict in files_to_widgets.items():
            file_options = layers_to_files_to_options[layer_name][filepath.relative_to(layer_dir)]

            # For each option in the dictionary for the current file, apply it
            for widget_name, new_value in file_options.items():
                if widget_name.startswith("QComboBox_"):
                    set_combobox_index_by_data(widgets_dict[widget_name], new_value)
                elif widget_name.startswith("QTextEdit_"):
                    widgets_dict[widget_name].setText(new_value)
