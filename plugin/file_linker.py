import datetime as dt
from pathlib import Path
from typing import (
    Any,
    Callable,
)

import exifread
from qgis.core import (
    QgsFeature,
    QgsProject,
    QgsVectorLayer,
)
from qgis.PyQt.QtCore import (
    pyqtSignal,
    Qt,
    QSize,
    QUrl,
)
from qgis.PyQt.QtGui import (
    QPixmap,
    QTransform,
)
from qgis.PyQt.QtWidgets import (
    QComboBox,
    QDialog,
    QFrame,
    QHBoxLayout,
    QLabel,
    QMessageBox,
    QPushButton,
    QScrollArea,
    QTextEdit,
    QVBoxLayout,
    QWidget,
)

from .utils import (  # noqa
    FieldDataCaptureProject,
    create_prepopulated_feature,
    ipdb_breakpoint,
)

WidgetsDict = dict[str, QWidget]
CreateFeatureFunction = Callable[[QgsVectorLayer, Path, WidgetsDict], QgsFeature]


class FileLinker(QDialog, FieldDataCaptureProject):
    """
    QDialog for linking files to a project within the database.
    This includes selecting which locality_points the files relate to.
    """
    file_linker_closed = pyqtSignal()


    def __init__(self):
        super().__init__()

        # Setting the Dialog Box settings
        self.setWindowTitle("Link Files")
        self.setMinimumSize(600, 500)
        self.setWindowFlags(
            Qt.Window | Qt.WindowCloseButtonHint
        )
        self.setup_ui_elements()
        self.connect_signals_and_slots()

        self.skip_files: list[Path] = []
        self.layers_to_feature_functions: dict[str, CreateFeatureFunction] = {}
        self.layers_to_files_to_widgets: dict[str, dict[Path, WidgetsDict]] = {}
        self.thumbnail_size = 200
        self.add_file_panels()


    def setup_ui_elements(self) -> None:
        """
        Create the elements of the File Linker dialog box User Interface.
        Also sets the layout for the dialog box.
        """
        self.link_selection_button = QPushButton("Link Selected Files")
        self.cancel_button = QPushButton("Cancel")

        # Bottom button layout
        bottom_button_layout = QHBoxLayout()
        bottom_button_layout.addWidget(self.link_selection_button)
        bottom_button_layout.addWidget(self.cancel_button)

        # Arrange the main layout
        layout = QVBoxLayout()
        self.file_panels_layout = QVBoxLayout()
        layout.addLayout(self.file_panels_layout)
        layout.addLayout(bottom_button_layout)
        self.setLayout(layout)


    def connect_signals_and_slots(self) -> None:
        """
        Function for connecting signals and slots of buttons and input boxes.
        """
        self.link_selection_button.clicked.connect(self.link_selection)
        self.cancel_button.clicked.connect(self.close)


    def add_file_panels(self) -> None:
        """
        Add the required file panels to the dialog and populate them.
        """
        self.add_file_panel(
            layer_name="photo",
            create_layout_function=self.create_photo_row_layout,
            create_feature_function=self.create_photo_feature,
        )
        self.add_file_panel(
            layer_name="media",
            create_layout_function=self.create_media_row_layout,
            create_feature_function=self.create_media_feature,
        )

        # If any files are skipped, show them in a message box
        skip_files_num = len(self.skip_files)
        if skip_files_num > 0:
            if skip_files_num > 5:
                msg = f"{skip_files_num} files have been skipped because they could not be loaded."
            else:
                file_str = "\n".join([str(filepath) for filepath in self.skip_files])
                msg = (
                    "Some files have been skipped because they could not be loaded:"
                    f"\n\n{file_str}"
                )
            QMessageBox.warning(None, "Skipped Files", msg)


    def add_file_panel(
        self,
        layer_name: str,
        create_layout_function: Callable[[Path], tuple[QHBoxLayout | QVBoxLayout, WidgetsDict]],
        create_feature_function: CreateFeatureFunction,
    ) -> None:
        """
        Add a new file panel with a scrollable area for rows of file widgets.
        Each row in the scrollable area is a QFrame which contains a QHBoxLayout or QVBoxLayout.

        Takes 2 functions:

        'create_layout_function' is used to create the individual row layouts.
        It takes a single filepath, and returns a PyQt Layout, and a dictionary of widgets to be saved.

        'create_feature_function' is used to create a new feature for each filepath.
        It takes the layer for the feature, a single filepath, and a dictionary of widgets that were saved earlier.
        It returns a new QgsFeature.
        """
        # To make a layout scrollable, you have to wrap it in a standrd QWidget object
        file_rows_layout = QVBoxLayout()
        layout_wrapper = QWidget()
        layout_wrapper.setLayout(file_rows_layout)
        scroll_area = QScrollArea()
        scroll_area.setWidget(layout_wrapper)
        # The widget must be allowed to change size so that rows can be added later
        scroll_area.setWidgetResizable(True)

        filepaths = self.get_unlinked_files(layer_name)
        if len(filepaths) > 0:
            self.layers_to_files_to_widgets[layer_name] = {}

            for filepath in filepaths:
                try:
                    row_layout, widgets_dict = create_layout_function(filepath)
                    # Add the layer name to the dictionary so that we can find the appropriate link function later
                    widgets_dict["layer_name"] = layer_name
                    self.layers_to_files_to_widgets[layer_name][filepath] = widgets_dict

                    # Put the layout into a frame for a border
                    row_frame = QFrame()
                    row_frame.setFrameStyle(QFrame.Panel | QFrame.Raised)
                    row_frame.setLayout(row_layout)
                    file_rows_layout.addWidget(row_frame)

                except Exception:
                    self.skip_files.append(filepath)

            self.layers_to_feature_functions[layer_name] = create_feature_function
            self.file_panels_layout.addWidget(scroll_area)


    def link_selection(self) -> None:
        """
        Link the selected files in the dialog into the project's database.
        Files which have not been assigned a locality_point will be ignored.
        """
        linked_files = 0
        for layer_name, files_to_widgets in self.layers_to_files_to_widgets.items():
            layer = QgsProject.instance().mapLayersByName(layer_name)[0]
            layer.startEditing()

            for filepath, widgets_dict in files_to_widgets.items():
                if widgets_dict["QComboBox_locality"].currentData() is not None:
                    feature = self.layers_to_feature_functions[layer_name](layer, filepath, widgets_dict)
                    layer.addFeature(feature)
                    linked_files += 1

            layer.commitChanges()
        self.close()
        QMessageBox.information(None, "Linked Files", f"Linked {linked_files} files successfully.")


    def closeEvent(self, event=None) -> None:
        """
        Function which is run by PyQt when the dialog is closed.
        """
        self.file_linker_closed.emit()


    """Methods used for all file types."""


    def get_unlinked_files(self, layer_name: str) -> list[Path]:
        """
        Get the unlinked files for the given layer from the given directory.
        """
        files_dir = self.layers_to_dirs[layer_name]
        file_attribute = self.layers_to_file_attributes[layer_name]
        layer = QgsProject.instance().mapLayersByName(layer_name)[0]
        linked_files = {
            Path(feature.attribute(file_attribute))
            for feature in layer.getFeatures()
            if feature.attribute(file_attribute) is not None
        }

        unlinked_files = []
        for filepath in files_dir.rglob("*"):
            if all((
                filepath.is_file(),
                filepath.relative_to(files_dir) not in linked_files,
                filepath.name != self.placeholder_filename.name,
            )):
                unlinked_files.append(filepath)

        return unlinked_files


    def create_combobox_locality(self) -> QComboBox:
        """
        Create a QComboBox which lists the existing locality_point features by name and date_entered.
        Returns the QComboBox object.
        """
        locality_point_layer = QgsProject.instance().mapLayersByName("locality_point")[0]

        combobox = QComboBox()
        self.configure_combobox_style(combobox)

        # Add default value
        combobox.addItem("Select Locality Point", userData=None)

        for locality_feature in locality_point_layer.getFeatures():
            # Convert to Python datetime object and remove miliseconds
            locality_date = locality_feature.attribute("date_entered").toPyDateTime().replace(microsecond=0)
            combobox.addItem(
                f"{locality_feature.attribute('name')} | {locality_date}",
                userData=locality_feature.attribute("uuid"),
            )

        return combobox


    @staticmethod
    def configure_combobox_style(combobox: QComboBox) -> None:
        """
        Configure given QComboBox style to show red when default None value is selected.
        """
        def update_stylesheet() -> None:
            if combobox.currentData() is None:
                style = "QComboBox:editable{color: red;}"
            else:
                style = ""
            combobox.setStyleSheet(style)
        combobox.currentTextChanged.connect(update_stylesheet)


    def create_filepath_widget(self, filepath: Path) -> QLabel:
        """
        Create a QLabel widget to display the given filepath.
        This also makes the widget clickable,
        which will open the filepath in an OS native software.
        """
        # Create an encoded URL for the file
        file_url = bytearray(QUrl.fromLocalFile(str(filepath)).toEncoded()).decode()
        filepath_label = QLabel(f"<a href={file_url}>{filepath.name}</a>")
        filepath_label.setOpenExternalLinks(True)
        filepath_label.setFixedWidth(self.thumbnail_size)
        return filepath_label


    def create_file_date_widget(
        self,
        photo: Path,
        photo_tags: dict[str, Any] = {},
    ) -> QLabel:
        """
        Create a label widget to display the file date.
        If photo tags are given, then the date is extracted from the EXIF metadata of the file,
        otherwise the file creation date is used instead.
        """
        date_tag = "EXIF DateTimeOriginal"
        if date_tag in photo_tags:
            source = "EXIF Metadata"
            exif_date = photo_tags[date_tag].values
            date_display = dt.datetime.strptime(exif_date, "%Y:%m:%d %H:%M:%S")
        else:
            source = "File Modified"
            date_display = dt.datetime.fromtimestamp(photo.stat().st_mtime)

        # Hide miliseconds
        date_display = date_display.replace(microsecond=0)
        file_date_label = QLabel(f"{date_display} | {source}")
        # Set the width to match the width of the image widget
        file_date_label.setFixedWidth(self.thumbnail_size)
        return file_date_label


    def create_image_widget(
        self,
        image_path: Path,
        photo_tags: dict[str, Any] = {},
    ) -> QLabel:
        """
        Create a new widget to display an image from the given filepath.
        The widget is a QLabel containing a QPixmap object.
        If photo tags are given, then the image is rotated correctly.
        """
        image_size = QSize(self.thumbnail_size, self.thumbnail_size)
        # Images are displayed by create a pixmap in a QLabel object
        label = QLabel()
        label.setFixedSize(image_size)
        pixmap = QPixmap(str(image_path))

        # Get the required rotation for the image to be displayed properly
        orientation_to_rotation = {
            1: 0,
            2: 0,
            3: 180,
            4: 180,
            5: 90,
            6: 90,
            7: 270,
            8: 270,
        }
        orientation_tag = "Image Orientation"
        # If the image file has orientation metadata
        if orientation_tag in photo_tags:
            orientation_code = photo_tags[orientation_tag].values[0]
            transform = QTransform()
            transform.rotate(orientation_to_rotation[orientation_code])
            pixmap = pixmap.transformed(transform)

        # Set the pixmap and scale it down
        label.setPixmap(pixmap.scaled(image_size, aspectRatioMode=Qt.KeepAspectRatio))
        return label


    """Methods used for only photos."""


    def create_photo_row_layout(self, photo: Path) -> tuple[QHBoxLayout | QVBoxLayout, WidgetsDict]:
        """
        Create the required layout of widgets to display the given photo path in the dialog.
        Returns the layout for the new set of widgets, and a dictionary of widgets to be saved to the photo path.
        """
        # Get the photo metadata for display in widgets
        try:
            with open(photo, "rb") as photo_file:
                photo_tags = exifread.process_file(photo_file)
        except Exception:
            photo_tags = {}

        # Arrange layout for new widgets into rows within the row layout
        filepath_label = self.create_filepath_widget(photo)
        combobox_locality = self.create_combobox_locality()
        row_hbox_1 = QHBoxLayout()
        row_hbox_1.addWidget(filepath_label)
        row_hbox_1.addWidget(combobox_locality)

        file_date_label = self.create_file_date_widget(photo, photo_tags=photo_tags)
        description_label = QLabel("Caption")
        row_hbox_2 = QHBoxLayout()
        row_hbox_2.addWidget(file_date_label)
        row_hbox_2.addWidget(description_label)

        image_widget = self.create_image_widget(photo, photo_tags=photo_tags)
        notes_edit = QTextEdit()
        row_hbox_3 = QHBoxLayout()
        row_hbox_3.addWidget(image_widget)
        row_hbox_3.addWidget(notes_edit)

        # Combine the top and bottom half into a single layout to form an entire row
        row_layout = QVBoxLayout()
        row_layout.addLayout(row_hbox_1)
        row_layout.addLayout(row_hbox_2)
        row_layout.addLayout(row_hbox_3)

        widgets_dict = {
            "QLabel_filepath": filepath_label,
            "QLabel_file_date": file_date_label,
            "QLabel_image_widget": image_widget,
            "QComboBox_locality": combobox_locality,
            "QTextEdit_notes": notes_edit,
        }

        return row_layout, widgets_dict


    def create_photo_feature(
        self,
        layer: QgsVectorLayer,
        photo: Path,
        photo_widgets: WidgetsDict,
    ) -> QgsFeature:
        """
        Create a new photo feature for the given filepath.
        """
        # Get photo caption value
        photo_caption = photo_widgets["QTextEdit_notes"].toPlainText()
        if photo_caption == "":
            photo_caption = None

        new_attributes = {
            "locality_fuid": photo_widgets["QComboBox_locality"].currentData(),
            "photo_file": str(photo.relative_to(self.photos_dir)),
            "caption": photo_caption,
        }
        return create_prepopulated_feature(layer, prepopulate=new_attributes)


    """Methods used for only media."""


    def create_media_row_layout(self, media: Path) -> tuple[QHBoxLayout | QVBoxLayout, WidgetsDict]:
        """
        Create the required layout of widgets to display the given media path in the dialog.
        Returns the layout for the new set of widgets, and a dictionary of widgets to be saved to the media path.
        """
        # Arrange layout for new widgets into rows within the row layout
        filepath_label = self.create_filepath_widget(media)
        combobox_locality = self.create_combobox_locality()
        row_hbox_1 = QHBoxLayout()
        row_hbox_1.addWidget(filepath_label)
        row_hbox_1.addWidget(combobox_locality)

        file_date_label = self.create_file_date_widget(media)
        description_label = QLabel("Media Description")
        row_hbox_2 = QHBoxLayout()
        row_hbox_2.addWidget(file_date_label)
        row_hbox_2.addWidget(description_label)

        image_widget = self.create_image_widget(self.icons_dir / "open_project_folder.png")
        notes_edit = QTextEdit()
        row_hbox_3 = QHBoxLayout()
        row_hbox_3.addWidget(image_widget)
        row_hbox_3.addWidget(notes_edit)

        # Combine the top and bottom half into a single layout to form an entire row
        row_layout = QVBoxLayout()
        row_layout.addLayout(row_hbox_1)
        row_layout.addLayout(row_hbox_2)
        row_layout.addLayout(row_hbox_3)

        widgets_dict = {
            "QLabel_filepath": filepath_label,
            "QLabel_file_date": file_date_label,
            "QLabel_image_widget": image_widget,
            "QComboBox_locality": combobox_locality,
            "QTextEdit_notes": notes_edit,
        }

        return row_layout, widgets_dict


    def create_media_feature(
        self,
        layer: QgsVectorLayer,
        media: Path,
        media_widgets: WidgetsDict,
    ) -> QgsFeature:
        """
        Create a new media feature for the given filepath.
        """
        # Get media description value
        media_description = media_widgets["QTextEdit_notes"].toPlainText()
        if media_description == "":
            media_description = None

        new_attributes = {
            "locality_fuid": media_widgets["QComboBox_locality"].currentData(),
            "media_link": str(media.relative_to(self.media_dir)),
            "media_description": media_description,
            "media_type_code": "other",
        }
        return create_prepopulated_feature(layer, prepopulate=new_attributes)
