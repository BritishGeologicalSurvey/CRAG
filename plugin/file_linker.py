import datetime as dt
from pathlib import Path
from typing import Any

import exifread
from qgis.core import (
    QgsProject,
    QgsVectorLayerUtils,
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
    ipdb_breakpoint,
)


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

        self.files_to_widgets: dict[Path, dict[str, QWidget]] = {}
        self.photo_widget_size = 200
        self.select_photos()


    def setup_ui_elements(self) -> None:
        """
        Create the elements of the File Linker dialog box User Interface.
        Also sets the layout for the dialog box.
        """
        self.import_selection_button = QPushButton("Link Selected Files")
        self.cancel_button = QPushButton("Cancel")

        # To make a layout scrollable, you have to wrap it in a standrd QWidget object
        self.photo_rows_layout = QVBoxLayout()
        layout_wrapper = QWidget()
        layout_wrapper.setLayout(self.photo_rows_layout)
        scroll_area = QScrollArea()
        scroll_area.setWidget(layout_wrapper)
        # The widget must be allowed to change size so that rows can be added later
        scroll_area.setWidgetResizable(True)

        # Bottom button layout
        bottom_button_layout = QHBoxLayout()
        bottom_button_layout.addWidget(self.import_selection_button)
        bottom_button_layout.addWidget(self.cancel_button)

        # Arrange the main layout
        layout = QVBoxLayout()
        layout.addWidget(scroll_area)
        layout.addLayout(bottom_button_layout)
        self.setLayout(layout)


    def connect_signals_and_slots(self) -> None:
        """
        Function for connecting signals and slots of buttons and input boxes.
        """
        self.import_selection_button.clicked.connect(self.import_selection)
        self.cancel_button.clicked.connect(self.close)


    def select_photos(self) -> bool:
        """
        Get the unlinked photos from the project_dir/photos directory.
        This will create the required widgets to display the photos and add them to the layout.
        If there is an error loading a photo file, it will be skipped.
        Returns a boolean indicating the success of the process.
        """
        photo_layer = QgsProject.instance().mapLayersByName("photo")[0]
        linked_photos = {
            Path(photo_feature.attribute("photo_file"))
            for photo_feature in photo_layer.getFeatures()
        }

        skip_photos = []
        for photo in self.photos_dir.rglob("*"):
            if all((
                photo.is_file(),
                photo.relative_to(self.photos_dir) not in linked_photos,
                photo.name != self.placeholder_filename.name,
            )):
                try:
                    self.add_photo_row_widgets(photo)
                except Exception:
                    skip_photos.append(photo)

        # If any photos are skipped, show them in a message box
        skip_photos_num = len(skip_photos)
        if skip_photos_num > 0:
            if skip_photos_num > 5:
                msg = f"{skip_photos_num} photos have been skipped because they could not be loaded."
            else:
                photos_str = "\n".join([str(photo) for photo in skip_photos])
                msg = (
                    "Some photos have been skipped because they could not be loaded:"
                    f"\n\n{photos_str}"
                )
            QMessageBox.warning(None, "Skipped Photos", msg)

        return True


    def add_photo_row_widgets(self, photo: Path) -> None:
        """
        Create and add the required widgets to display the given photo path in the dialog.
        Each row in the scrollable area is a QFrame which contains a QVBoxLayout.
        Each given photo is saved to a dictionary where the keys are photo paths
        and the values are the QWidget objects which relate to it.
        """
        # Get the photo metadata for display in widgets
        try:
            with open(photo, "rb") as photo_file:
                photo_tags = exifread.process_file(photo_file)
        except Exception:
            photo_tags = {}

        # Arrange layout for new widgets into rows within the row layout
        photo_path_label = self.create_filepath_widget(photo)
        combobox_locality = self.create_combobox_locality()
        row_hbox_1 = QHBoxLayout()
        row_hbox_1.addWidget(photo_path_label)
        row_hbox_1.addWidget(combobox_locality)

        photo_date_label = self.create_photo_date_widget(photo, photo_tags)
        caption_label = QLabel("Caption")
        row_hbox_2 = QHBoxLayout()
        row_hbox_2.addWidget(photo_date_label)
        row_hbox_2.addWidget(caption_label)

        photo_widget = self.create_photo_widget(photo, photo_tags)
        caption_edit = QTextEdit()
        row_hbox_3 = QHBoxLayout()
        row_hbox_3.addWidget(photo_widget)
        row_hbox_3.addWidget(caption_edit)

        # Combine the top and bottom half into a single layout to form an entire row
        row_layout = QVBoxLayout()
        row_layout.addLayout(row_hbox_1)
        row_layout.addLayout(row_hbox_2)
        row_layout.addLayout(row_hbox_3)

        # Put the layout into a frame for a border
        row_frame = QFrame()
        row_frame.setFrameStyle(QFrame.Panel | QFrame.Raised)
        row_frame.setLayout(row_layout)
        self.photo_rows_layout.addWidget(row_frame)

        # Save widgets with the given photo path
        self.files_to_widgets[photo] = {
            "QLabel_photo_path": photo_path_label,
            "QLabel_photo_date": photo_date_label,
            "QLabel_photo_widget": photo_widget,
            "QComboBox_locality": combobox_locality,
            "QTextEdit_caption": caption_edit,
        }


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
        filepath_label.setFixedWidth(self.photo_widget_size)
        return filepath_label


    def create_photo_date_widget(self, photo: Path, photo_tags: dict[str, Any]) -> QLabel:
        """
        Create the required label widget to display the photo date.
        The date is first extracted from the EXIF metadata of the photo file,
        but if that is missing then the file creation date is used instead.
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
        photo_date_label = QLabel(f"{date_display} | {source}")
        # Set the width to match the width of the photo widget
        photo_date_label.setFixedWidth(self.photo_widget_size)
        return photo_date_label


    def create_photo_widget(self, photo: Path, photo_tags: dict[str, Any]) -> QLabel:
        """
        Create the required photo widget for the given photo path.
        The widget is a QLabel containing a QPixmap object.
        The image is rotated correctly and scaled down.
        """
        image_size = QSize(self.photo_widget_size, self.photo_widget_size)
        # Images are displayed by create a pixmap in a QLabel object
        label = QLabel()
        label.setFixedSize(image_size)
        pixmap = QPixmap(str(photo))

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


    def import_selection(self) -> None:
        """
        Import the selected files in the dialog into the project's database.
        Files which have not been assigned a locality_point will be ignored.
        """
        photo_layer = QgsProject.instance().mapLayersByName("photo")[0]
        photo_layer.startEditing()

        imported_files = 0
        for photo_path, photo_widgets in self.files_to_widgets.items():
            locality_fuid = photo_widgets["QComboBox_locality"].currentData()

            if locality_fuid is not None:
                imported_files += 1

                # Create new feature with default values
                new_feature = QgsVectorLayerUtils.createFeature(photo_layer)

                # Get photo caption value
                photo_caption = photo_widgets["QTextEdit_caption"].toPlainText()
                if photo_caption == "":
                    photo_caption = None

                new_attributes = {
                    "locality_fuid": locality_fuid,
                    "photo_file": str(photo_path.relative_to(self.photos_dir)),
                    "caption": photo_caption,
                }
                for attribute, value in new_attributes.items():
                    new_feature.setAttribute(attribute, value)

                photo_layer.addFeature(new_feature)

        photo_layer.commitChanges()
        self.close()
        QMessageBox.information(None, "Linked Files", f"Linked {imported_files} files successfully.")


    def closeEvent(self, event=None) -> None:
        """
        Function which is run by PyQt when the dialog is closed.
        """
        self.file_linker_closed.emit()
