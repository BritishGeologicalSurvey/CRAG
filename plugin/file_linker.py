import datetime as dt
from pathlib import Path
from typing import (
    Any,
    Callable,
    Optional,
)

import exifread
from qgis.core import (
    QgsFeature,
    QgsVectorLayer,
)
from qgis.PyQt.QtCore import (
    pyqtSignal,
    Qt,
    QEvent,
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
    CollapsibleWidget,
    create_prepopulated_feature,
    get_table_rows,
    ipdb_breakpoint,
)

WidgetsDict = dict[str, QWidget]
CreateFeatureFunction = Callable[[QgsVectorLayer, Path, WidgetsDict], QgsFeature]
ValidationFunction = Callable[[WidgetsDict], tuple[bool, Optional[str]]]


class NoScrollQComboBox(QComboBox):
    """
    Sub-class of QComboBox to disable mouse wheel scrolling.  This QComboBox
    is used where users scrolling through the dialog with the mouse button can
    accidentally change the QComboBox value if the cursor is over the box.
    """
    def wheelEvent(self, e: QEvent):
        """
        Overwritten QComboBox method does nothing on mouse wheel scrolling.
        """
        pass


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
        self.layers_to_validation_functions: dict[str, Optional[ValidationFunction]] = {}
        self.layers_to_files_to_widgets: dict[str, dict[Path, WidgetsDict]] = {}
        self.thumbnail_size = 200
        self.add_file_rows()


    @property
    def file_count(self) -> int:
        """
        Return the number of files currently loaded into the FileLinker.
        """
        file_count = sum([
            len(files_to_widgets)
            for files_to_widgets in self.layers_to_files_to_widgets.values()
        ])
        return file_count


    def setup_ui_elements(self) -> None:
        """
        Create the elements of the File Linker dialog box User Interface.
        Also sets the layout for the dialog box.
        """
        # Scrollable area layout
        # To make a layout scrollable, you have to wrap it in a standrd QWidget object
        self.file_rows_layout = QVBoxLayout()
        layout_wrapper = QWidget()
        layout_wrapper.setLayout(self.file_rows_layout)
        scroll_area = QScrollArea()
        scroll_area.setWidget(layout_wrapper)
        # The widget must be allowed to change size so that rows can be added later
        scroll_area.setWidgetResizable(True)

        collapsible_widget = self.get_collapsible_placeholder_localities()

        # Bottom button layout
        self.save_links_button = QPushButton("Save Links")
        self.cancel_button = QPushButton("Cancel")
        bottom_button_layout = QHBoxLayout()
        bottom_button_layout.addWidget(self.save_links_button)
        bottom_button_layout.addWidget(self.cancel_button)

        # Arrange the main layout
        layout = QVBoxLayout()
        if collapsible_widget is not None:
            layout.addWidget(collapsible_widget)
        layout.addWidget(scroll_area)
        layout.addLayout(bottom_button_layout)
        self.setLayout(layout)


    def get_collapsible_placeholder_localities(self) -> Optional[CollapsibleWidget]:
        """
        Get a collapsible widget which will display the list of locality points which have a placeholder
        photo/image record.
        If there are none, then nothing is returned.
        """
        locality_point_names = set()
        for table, attachment_col in self.layers_to_file_attributes.items():
            for row in get_table_rows(
                self.db_file,
                f"SELECT locality_point FROM view_{table} WHERE {attachment_col} = '{self.default_attachment_str}'",
            ):
                locality_point_names.add("• " + row["locality_point"])

        no_placeholders = len(locality_point_names)
        if len(locality_point_names) > 0:
            collapsible_widget = CollapsibleWidget(
                f"⚠ There are {no_placeholders} locality point(s) with a photo/media record using the placeholder file."
                " It is recommended to update these before linking new files."
            )
            text_edit = QTextEdit()
            text_edit.setText("\n".join(sorted(locality_point_names)))
            text_edit.setReadOnly(True)
            collapsible_widget.collapsible_layout.addWidget(text_edit)
            return collapsible_widget


    def connect_signals_and_slots(self) -> None:
        """
        Function for connecting signals and slots of buttons and input boxes.
        """
        self.save_links_button.clicked.connect(self.save_links)
        self.cancel_button.clicked.connect(self.close)


    def add_file_rows(self) -> None:
        """
        Add the required file rows to the dialog and populate them.
        """
        self.add_layer_file_rows(
            layer_name="photo",
            create_layout_function=self.create_photo_row_layout,
            create_feature_function=self.create_photo_feature,
        )
        self.add_layer_file_rows(
            layer_name="media",
            create_layout_function=self.create_media_row_layout,
            create_feature_function=self.create_media_feature,
            validation_function=self.validate_media_widgets_dict,
        )

        # If there is only 1 file selected, add stretch to layout so the single row is the same size as normal
        if self.file_count == 1:
            self.file_rows_layout.addStretch()

        # If any files are skipped, show them in a message box
        skip_files_num = len(self.skip_files)
        if skip_files_num > 0:
            file_str = "\n".join([str(filepath) for filepath in self.skip_files])
            msg = (
                "Some files have been skipped because they could not be loaded:"
                f"\n\n{file_str}"
            )
            QMessageBox.warning(None, "Skipped Files", msg)


    def add_layer_file_rows(
        self,
        layer_name: str,
        create_layout_function: Callable[[Path], tuple[QHBoxLayout | QVBoxLayout, WidgetsDict]],
        create_feature_function: CreateFeatureFunction,
        validation_function: Optional[ValidationFunction] = None,
    ) -> None:
        """
        Add new file rows to the existing layout for unlinked files for the given layer.
        Takes 3 functions:

        'create_layout_function' is used to create the individual row layouts.
        It takes a single filepath, and returns a PyQt Layout, and a dictionary of widgets to be saved.

        'create_feature_function' is used to create a new feature for each filepath.
        It takes the layer for the feature, a single filepath, and a dictionary of widgets that were saved earlier.
        It returns a new QgsFeature.

        'validation_function' is used to validate the input values within the widgets of each file.
        It takes a single widgets_dict, and returns a boolean and an optional string message in the event of an error.
        """
        filepaths = self.get_unlinked_files(layer_name)
        if len(filepaths) > 0:
            self.layers_to_files_to_widgets[layer_name] = {}

            for filepath in filepaths:
                try:
                    row_layout, widgets_dict = create_layout_function(filepath)
                    self.layers_to_files_to_widgets[layer_name][filepath] = widgets_dict

                    # Put the layout into a frame for a border
                    row_frame = QFrame()
                    row_frame.setFrameStyle(QFrame.Panel | QFrame.Raised)
                    row_frame.setLayout(row_layout)
                    self.file_rows_layout.addWidget(row_frame)

                except Exception:
                    self.skip_files.append(filepath)

            self.layers_to_feature_functions[layer_name] = create_feature_function
            self.layers_to_validation_functions[layer_name] = validation_function


    def save_links(self) -> None:
        """
        If the current selection options pass the validation,
        then save the links selected in the dialog into the project's database.
        Files which have not been assigned a locality_point will be ignored.
        """
        if self.validate_selection():
            linked_files = 0
            for layer_name, files_to_widgets in self.layers_to_files_to_widgets.items():
                layer = self.get_fdc_layer(layer_name)
                layer.startEditing()

                for filepath, widgets_dict in files_to_widgets.items():
                    if widgets_dict["QComboBox_locality"].currentData() is not None:
                        feature = self.layers_to_feature_functions[layer_name](layer, filepath, widgets_dict)
                        layer.addFeature(feature)
                        linked_files += 1

                layer.commitChanges()
            self.close()
            QMessageBox.information(None, "Linked Files", f"Linked {linked_files} files successfully.")


    def validate_selection(self) -> bool:
        """
        Run the validation functions for each file selected and display any errors.
        Returns a boolean indicating the overall result of the validation.
        """
        errors = []
        for layer_name, files_to_widgets in self.layers_to_files_to_widgets.items():
            layer_dir = self.layers_to_dirs[layer_name]
            validation_function = self.layers_to_validation_functions[layer_name]
            if validation_function is not None:

                for filepath, widgets_dict in files_to_widgets.items():
                    result, message = validation_function(widgets_dict)
                    if not result:
                        errors.append(f"{filepath.relative_to(layer_dir)}\n• {message}")

        if len(errors) == 0:
            return True
        else:
            QMessageBox.warning(None, "Invalid Input Found", "\n\n".join(errors))
            return False


    def closeEvent(self, event=None) -> None:
        """
        Function which is run by PyQt when the dialog is closed.
        """
        self.file_linker_closed.emit()


    """Methods used for all file types."""


    def create_combobox_locality(self) -> QComboBox:
        """
        Create a QComboBox which lists the existing locality_point features by name and recorded_on.
        Returns the QComboBox object.
        """
        locality_point_layer = self.get_fdc_layer("locality_point")

        combobox = NoScrollQComboBox()
        self.configure_combobox_style(combobox)

        # Add default value
        combobox.addItem("Select Locality Point", userData=None)

        for feature in locality_point_layer.getFeatures():
            # Convert to Python datetime object and remove miliseconds
            locality_date = feature.attribute("recorded_on").toPyDateTime().replace(microsecond=0)
            combobox.addItem(
                f"{feature.attribute('name')} | {locality_date}",
                userData=feature.attribute("uuid"),
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
        filepath_label.setToolTip(str(filepath.relative_to(self.project_dir)))
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
        image_size: int,
        photo_tags: dict[str, Any] = {},
    ) -> QLabel:
        """
        Create a new widget to display an image from the given filepath.
        The widget is a QLabel containing a QPixmap object.
        If photo tags are given, then the image is rotated correctly.
        """
        # Images are displayed by create a pixmap in a QLabel object
        label = QLabel()
        label.setFixedHeight(image_size)
        # Always make the label part of the widget take up the same width
        # This forces the columns to retain the same width too
        label.setFixedWidth(self.thumbnail_size)
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
        image_qsize = QSize(image_size, image_size)
        label.setPixmap(pixmap.scaled(image_qsize, aspectRatioMode=Qt.KeepAspectRatio))
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

        filepath_label = self.create_filepath_widget(photo)
        file_date_label = self.create_file_date_widget(photo, photo_tags=photo_tags)
        image_widget = self.create_image_widget(photo, self.thumbnail_size, photo_tags=photo_tags)
        # Some photos (e.g. HEIC) are loaded as NULL pixmap objects, so we use a no photography icon instead
        if image_widget.pixmap().isNull():
            image_widget = self.create_image_widget(self.icons_src_dir / "no_photography.png", self.thumbnail_size)
        row_vbox_1 = QVBoxLayout()
        row_vbox_1.addWidget(filepath_label)
        row_vbox_1.addWidget(file_date_label)
        row_vbox_1.addWidget(image_widget)

        combobox_locality = self.create_combobox_locality()
        description_label = QLabel("Photo Caption")
        notes_edit = QTextEdit()
        notes_edit.setFixedHeight(self.thumbnail_size)
        row_vbox_2 = QVBoxLayout()
        row_vbox_2.addWidget(combobox_locality)
        row_vbox_2.addWidget(description_label)
        row_vbox_2.addWidget(notes_edit)

        # Combine layout columns into 1 layout
        row_layout = QHBoxLayout()
        row_layout.addLayout(row_vbox_1)
        row_layout.addLayout(row_vbox_2)

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
        image_size = self.thumbnail_size - 50
        # Arrange layout for new widgets into columns within the row layout
        filepath_label = self.create_filepath_widget(media)
        file_date_label = self.create_file_date_widget(media)
        media_label = QLabel("Media")
        image_widget = self.create_image_widget(self.icons_src_dir / "document.png", image_size)
        row_vbox_1 = QVBoxLayout()
        row_vbox_1.addWidget(filepath_label)
        row_vbox_1.addWidget(file_date_label)
        row_vbox_1.addWidget(media_label)
        row_vbox_1.addWidget(image_widget)

        combobox_locality = self.create_combobox_locality()
        combobox_media_type = self.create_combobox_media_type()
        description_label = QLabel("Media Description")
        notes_edit = QTextEdit()
        notes_edit.setFixedHeight(image_size)
        row_vbox_2 = QVBoxLayout()
        row_vbox_2.addWidget(combobox_locality)
        row_vbox_2.addWidget(combobox_media_type)
        row_vbox_2.addWidget(description_label)
        row_vbox_2.addWidget(notes_edit)

        # Combine layout columns into 1 layout
        row_layout = QHBoxLayout()
        row_layout.addLayout(row_vbox_1)
        row_layout.addLayout(row_vbox_2)

        widgets_dict = {
            "QLabel_filepath": filepath_label,
            "QLabel_file_date": file_date_label,
            "QLabel_image_widget": image_widget,
            "QComboBox_locality": combobox_locality,
            "QTextEdit_notes": notes_edit,
            "QComboBox_media_type": combobox_media_type,
        }

        return row_layout, widgets_dict


    def create_combobox_media_type(self) -> QComboBox:
        """
        Create a combobox which lists the media type codes.
        Returns the QComboBox object.
        """
        dic_media_layer = self.get_fdc_layer("dic_media")

        combobox = NoScrollQComboBox()
        FileLinker.configure_combobox_style(combobox)

        # Add default value
        combobox.addItem("Select Media Type", userData=None)

        for feature in dic_media_layer.getFeatures():
            combobox.addItem(
                feature.attribute("description"),
                userData=feature.attribute("code"),
            )

        return combobox


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
            "media_type_code": media_widgets["QComboBox_media_type"].currentData(),
        }
        return create_prepopulated_feature(layer, prepopulate=new_attributes)


    def validate_media_widgets_dict(self, widgets_dict: WidgetsDict) -> tuple[bool, Optional[str]]:
        """
        Validate that the input options of the given widgets_dict for a media file is valid.
        """
        # If a locality is selected but a media type is not
        if all((
            widgets_dict["QComboBox_locality"].currentData() is not None,
            widgets_dict["QComboBox_media_type"].currentData() is None,
        )):
            return False, "Please select a valid Media Type"
        return True, None
