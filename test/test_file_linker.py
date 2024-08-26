import datetime as dt
from pathlib import Path
from typing import (
    Any,
    Callable,
)

import pytest
from qgis.core import (
    QgsFeature,
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
    "QComboBox_media_type": {
        "Select Media Type": None,
        "Image or Photograph": "image",
        "Video": "video",
        "Voice note": "voice",
        "Spreadsheet or CSV": "spreadsheet",
        "Word, PDF or Text document": "document",
        "Other file type": "other",
    },
}
WIDGET_NAMES_TO_ATTRIBUTES_NAMES = {
    "photo": {
        "QComboBox_locality": "locality_fuid",
        "QTextEdit_notes": "caption",
    },
    "media": {
        "QComboBox_locality": "locality_fuid",
        "QComboBox_media_type": "media_type_code",
        "QTextEdit_notes": "media_description",
    }
}


def get_file_modified_datetime(filepath: Path) -> dt.datetime:
    """
    Get the file modified string timestamp from the given filepath, as it would be displayed in the FileLinker.
    """
    return dt.datetime.fromtimestamp(filepath.stat().st_mtime).replace(microsecond=0)


def modify_file_linker_inputs(
    file_linker: FileLinker,
    layers_to_files_to_options: dict[str, dict[Path, dict[str, str]]]
) -> None:
    """
    Modify the inputs of the given FileLinker dialog using the given dictionary of options.
    This directly modified the widgets in the dialog, like a user would.
    """
    for layer_name, files_to_widgets in file_linker.layers_to_files_to_widgets.items():
        # If file options are given for this layer
        if layer_name in layers_to_files_to_options:
            layer_dir = file_linker.layers_to_dirs[layer_name]

            for filepath, widgets_dict in files_to_widgets.items():
                file_options = layers_to_files_to_options[layer_name][filepath.relative_to(layer_dir)]

                # For each option in the dictionary for the current file, apply it
                for widget_name, new_value in file_options.items():
                    if widget_name.startswith("QComboBox_"):
                        set_combobox_index_by_data(widgets_dict[widget_name], new_value)
                    elif widget_name.startswith("QTextEdit_"):
                        widgets_dict[widget_name].setText(new_value)


@pytest.fixture()
def unlinked_test_files(fdc_project: FieldDataCapture) -> UnlinkedTestFiles:
    """
    Add some unlinked files to project folder for testing.
    Returns a dictionary of layer names as keys, where the values are another dictionary
    which contains unlinked filepaths as keys, where the values are another dictionary
    which contains widget_dict labels as keys, and expected string values for the widgets.
    """
    # Make some sub-directories
    for layer_dir in fdc_project.layers_to_dirs.values():
        sub_dir_a = Path("sub_dir_A")
        sub_dir_b = sub_dir_a / "sub_dir_B"
        sub_dir_a_full = layer_dir / "sub_dir_A"
        sub_dir_b_full = sub_dir_a_full / "sub_dir_B"
        for sub_dir_full in [sub_dir_a_full, sub_dir_b_full]:
            sub_dir_full.mkdir()

    # Create copies of existing photos in various directories in project_dir/photos/
    new_photo_a = fdc_project.photos_dir / sub_dir_a / "exif_data.jpg"
    new_photo_a.write_bytes(Path("test/data/photos/exif_data.jpg").read_bytes())
    new_photo_b = fdc_project.photos_dir / sub_dir_b / "no_exif_data.jpg"
    new_photo_b.write_bytes(Path("test/data/photos/no_exif_data.jpg").read_bytes())
    new_photo_c = fdc_project.photos_dir / sub_dir_a / "test_img_001.jpeg"
    new_photo_c.write_bytes((fdc_project.photos_dir / "test_point_001.jpeg").read_bytes())

    # Create copies of existing media files in various directories in project_dir/media/
    new_media_a = fdc_project.media_dir / sub_dir_a / "test_csv_001.csv"
    new_media_a.write_bytes((fdc_project.media_dir / "test_point_001.csv").read_bytes())
    new_media_b = fdc_project.media_dir / sub_dir_b / "test_txt_001.txt"
    new_media_b.write_bytes((fdc_project.media_dir / "test_point_001.txt").read_bytes())

    unlinked_files = {
        "photo": {
            # Only provide date label if it is EXIF data, others are dynmcially added below
            new_photo_a: {"QLabel_file_date": "2023-11-21 14:44:07 | EXIF Metadata"},
            new_photo_b: {},
            new_photo_c: {},
        },
        "media": {
            new_media_a: {},
            new_media_b: {},
        }
    }

    # Add QComboBox_locality to all widget dictionaries
    for files_to_widgets in unlinked_files.values():
        for filepath, widgets_dict in files_to_widgets.items():
            widgets_dict["QComboBox_locality"] = EXPECTED_COMBOBOX_ITEMS["QComboBox_locality"]
            # Dynamically add expected filepath label for all files
            widgets_dict["QLabel_filepath"] = f"<a href=file://{filepath}>{filepath.name}</a>"
            if "QLabel_file_date" not in widgets_dict:
                widgets_dict["QLabel_file_date"] = f"{get_file_modified_datetime(filepath)} | File Modified"

    return unlinked_files


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
    QMessageBox.information.assert_called_with(
        None,
        "All Files Linked",
        "All of the project files are already linked.",
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


def test_get_unlinked_files(
    fdc_project: FieldDataCapture,
    unlinked_test_files: UnlinkedTestFiles,
):
    # Arrange
    fdc_project.open_file_linker()

    # Act
    for layer_name, expected_files_dict in unlinked_test_files.items():
        actual_unlinked_files = fdc_project.file_linker.get_unlinked_files(layer_name)

        # Assert
        assert set(expected_files_dict) == set(actual_unlinked_files)


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

            # Check filepath tooltip
            filepath_label = actual_widgets_dict["QLabel_filepath"]
            assert filepath_label.toolTip() == str(filepath.relative_to(fdc_project.project_dir))

            # Check photo display size
            image_widget = actual_widgets_dict["QLabel_image_widget"]
            assert image_widget.pixmap().width() <= fdc_project.file_linker.thumbnail_size
            assert image_widget.pixmap().height() <= fdc_project.file_linker.thumbnail_size


def assert_widgets_dict_types(widgets_dict: dict[str, Any]) -> None:
    """
    Check that the widgets in the given dictionary have the correct type.
    """
    assert isinstance(widgets_dict["QLabel_filepath"], QLabel)
    assert isinstance(widgets_dict["QLabel_file_date"], QLabel)
    assert isinstance(widgets_dict["QLabel_image_widget"].pixmap(), QPixmap)
    assert isinstance(widgets_dict["QComboBox_locality"], QComboBox)
    assert isinstance(widgets_dict["QTextEdit_notes"], QTextEdit)


@pytest.mark.parametrize(
    ["create_combobox", "expected_items"],
    (
        (FileLinker.create_combobox_locality, EXPECTED_COMBOBOX_ITEMS["QComboBox_locality"]),
        (FileLinker.create_combobox_media_type, EXPECTED_COMBOBOX_ITEMS["QComboBox_media_type"]),
    ),
)
def test_create_comboboxes(
    create_combobox: Callable[[], QComboBox],
    expected_items: dict[str, Any],
    fdc_project: FieldDataCapture,
):
    # Act 1
    combobox = create_combobox()

    # Assert 1
    assert get_combobox_items_dict(combobox) == expected_items
    # Check default values, the style should be red when the data is None
    assert combobox.currentData() is None
    assert combobox.styleSheet() == "QComboBox:editable{color: red;}"

    # Act 2
    # Select a different item in the combobox
    combobox.setCurrentIndex(1)

    # Assert 2
    # Check new values, the style should be default when the data is not None
    assert combobox.currentData() is not None
    assert combobox.styleSheet() == ""


def test_validate_selection(
    fdc_project: FieldDataCapture,
    unlinked_test_files: UnlinkedTestFiles,
):
    # Arrange 1
    layers_to_files_to_options = {
        "media": {
            Path("sub_dir_A/test_csv_001.csv"): {
                "QComboBox_locality": "{b5bf63bb-0811-4074-99bc-422a78aa5b52}",
                # Don't select a media type, this should fail the validation
                "QComboBox_media_type": None,
                "QTextEdit_notes": "Description for test_csv_001.csv",
            },
            Path("sub_dir_A/sub_dir_B/test_txt_001.txt"): {
                "QComboBox_locality": "{abc43098-fe9b-4da0-b008-7518694466bb}",
                # Don't select a media type, this should fail the validation
                "QComboBox_media_type": None,
                "QTextEdit_notes": "Description for test_txt_001.txt",
            },
        }
    }
    fdc_project.open_file_linker()

    # Act 1
    # Pick invalid media type
    modify_file_linker_inputs(fdc_project.file_linker, layers_to_files_to_options)
    result_1 = fdc_project.file_linker.validate_selection()

    # Assert 1
    assert not result_1
    QMessageBox.warning.assert_called_once_with(
        None,
        "Invalid Input Found",
        (
            "sub_dir_A/test_csv_001.csv\n• Please select a valid Media Type\n\n"
            "sub_dir_A/sub_dir_B/test_txt_001.txt\n• Please select a valid Media Type"
        ),
    )

    # Act 2
    # Pick valid media type
    for files_to_options in layers_to_files_to_options.values():
        for file_options in files_to_options.values():
            file_options["QComboBox_media_type"] = "other"
    modify_file_linker_inputs(fdc_project.file_linker, layers_to_files_to_options)
    result_2 = fdc_project.file_linker.validate_selection()

    # Assert 2
    assert result_2


def test_save_links(
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
                "QComboBox_locality": "{abc43098-fe9b-4da0-b008-7518694466bb}",
                "QTextEdit_notes": "Caption for no_exif_data.jpg",
            },
        },
        "media": {
            Path("sub_dir_A/test_csv_001.csv"): {
                # Don't select this file, it should not be saved to the database
                "QComboBox_locality": None,
                "QComboBox_media_type": "spreadsheet",
                "QTextEdit_notes": "Description for test_csv_001.csv",
            },
            Path("sub_dir_A/sub_dir_B/test_txt_001.txt"): {
                "QComboBox_locality": "{b5bf63bb-0811-4074-99bc-422a78aa5b52}",
                "QComboBox_media_type": "document",
                "QTextEdit_notes": "Description for test_txt_001.txt",
            },
        }
    }
    fdc_project.open_file_linker()

    # Act
    modify_file_linker_inputs(fdc_project.file_linker, layers_to_files_to_options)
    fdc_project.file_linker.save_links_button.click()

    # Assert
    # Check that the FileLinker closed
    assert fdc_project.file_linker is None

    for layer_name in unlinked_test_files:
        layer = QgsProject.instance().mapLayersByName(layer_name)[0]
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

        for expected_filepath, expected_file_options in layers_to_files_to_options[layer_name].items():
            # If the file was meant to have a selected locality, it should exist as a feature
            if expected_file_options["QComboBox_locality"] is not None:
                assert_feature_expected_options(
                    fdc_project,
                    layer_name,
                    expected_filepath,
                    expected_file_options,
                    feature=next(new_features),
                )


def assert_feature_expected_options(
    fdc: FieldDataCapture,
    layer_name: str,
    expected_filepath: Path,
    expected_file_options: dict[str, Any],
    feature: QgsFeature,
) -> None:
    # These 3 variables depend on the layer
    layer_dir = fdc.layers_to_dirs[layer_name]
    widgets_to_attributes = WIDGET_NAMES_TO_ATTRIBUTES_NAMES[layer_name]
    file_attribute_name = fdc.layers_to_file_attributes[layer_name]

    file_attribute = Path(feature.attribute(file_attribute_name))
    # Check that the relative path exists in the directory
    assert (layer_dir / file_attribute).exists()
    assert file_attribute == expected_filepath

    # Check that input widget values have been saved correclty
    for widget_name, expected_value in expected_file_options.items():
        assert feature.attribute(widgets_to_attributes[widget_name]) == expected_value
