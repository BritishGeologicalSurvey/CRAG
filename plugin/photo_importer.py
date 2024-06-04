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
)
from qgis.PyQt.QtGui import (
    QPixmap,
    QTransform,
)
from qgis.PyQt.QtWidgets import (
    QComboBox,
    QDialog,
    QFileDialog,
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

from .utils import ipdb_breakpoint  # noqa


class PhotoImporter(QDialog):
    """
    QDialog for selecting which photos to import and selecting
    which locality_points the photos relate to.
    """
    photo_importer_closed = pyqtSignal()

    def __init__(self, photos_dir: Path):
        super().__init__()

        self.photos_dir = photos_dir

        # Setting the Dialog Box settings
        self.setWindowTitle("Import Photos")
        self.setMinimumSize(600, 500)
        self.setWindowFlags(
            Qt.Window | Qt.WindowCloseButtonHint
        )
        self.setup_ui_elements()
        self.connect_signals_and_slots()

        self.photos_to_widgets: dict[Path, dict[str, QWidget]] = {}
        self.photo_widget_size = 200

        # Make it modal so changes are not made whilst importing photos
        self.exec()


    def setup_ui_elements(self) -> None:
        """
        Create the elements of the Photo Importer dialog box User Interface.
        Also sets the layout for the dialog box.
        """
        self.select_photos_button = QPushButton("Select Photos")
        self.import_selection_button = QPushButton("Import Selected Photos")
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
        layout.addWidget(self.select_photos_button)
        layout.addWidget(scroll_area)
        layout.addLayout(bottom_button_layout)
        self.setLayout(layout)


    def connect_signals_and_slots(self) -> None:
        """
        Function for connecting signals and slots of buttons and input boxes.
        """
        self.select_photos_button.clicked.connect(self.select_photos)
        self.import_selection_button.clicked.connect(self.import_selection)
        self.cancel_button.clicked.connect(self.close)


    def select_photos(self) -> bool:
        """
        Get the required photos to select from the user.
        This will create the required widgets to display the photos and add them to the layout.
        Returns a boolean indicating the success of the process.
        """
        photos = self.select_photos_filedialog()
        # If no photos were selected
        if len(photos) == 0:
            return False

        already_existing_photos = {photo.name for photo in self.photos_dir.glob("*")}
        skip_photos = []
        self.photo_comboboxes = {}

        for photo in photos:
            # Don't import photos if they already exist or if they are already selected
            if photo.name in already_existing_photos or photo in self.photos_to_widgets:
                skip_photos.append(photo)
            else:
                self.add_photo_row_widgets(photo)

        # If any photos are skipped, show them in a message box
        if len(skip_photos) > 0:
            photos_str = "\n".join([str(photo) for photo in skip_photos])
            QMessageBox.warning(
                None,
                "Skipped Existing Photos",
                f"The current photos either already exist or are already selected and will be skipped:\n\n{photos_str}"
            )

        return True


    def select_photos_filedialog(self) -> list[Path]:
        """
        Get a list of photo filepaths which will be imported from a QFileDialog.
        """
        pyqt_open_dialog = QFileDialog.getOpenFileNames(
            self,
            "Import Locality Photos",
            filter="(*.png *.jpg *.jpeg *.tif)",
        )
        filepaths = [Path(filepath) for filepath in pyqt_open_dialog[0]]

        return filepaths


    def add_photo_row_widgets(self, photo: Path) -> None:
        """
        Create and add the required widgets to display the given photo path in the dialog.
        Each row in the scrollable area is a QFrame which contains a QVBoxLayout.
        Each given photo is saved to a dictionary where the keys are photo paths
        and the values are the QWidget objects which relate to it.
        """
        # Get the photo metadata for display in widgets
        with open(photo, "rb") as photo_file:
            photo_tags = exifread.process_file(photo_file)

        # Arrange layout for new widgets into rows within the row layout
        # Elements on the left of the row have a set width to match the photo size
        photo_label = QLabel(str(photo.name))
        photo_label.setFixedWidth(self.photo_widget_size)
        combobox = self.create_combobox()
        row_hbox_1 = QHBoxLayout()
        row_hbox_1.addWidget(photo_label)
        row_hbox_1.addWidget(combobox)

        photo_date_label = self.create_photo_date_widget(photo, photo_tags)
        notes_label = QLabel("Notes")
        row_hbox_2 = QHBoxLayout()
        row_hbox_2.addWidget(photo_date_label)
        row_hbox_2.addWidget(notes_label)

        photo_widget = self.create_photo_widget(photo, photo_tags)
        notes_edit = QTextEdit()
        row_hbox_3 = QHBoxLayout()
        row_hbox_3.addWidget(photo_widget)
        row_hbox_3.addWidget(notes_edit)

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

        # Save the required widgets for user input with the given photo path
        self.photos_to_widgets[photo] = {
            "QComboBox": combobox,
            "QTextEdit": notes_edit,
        }


    def create_combobox(self) -> QComboBox:
        """
        Create a QComboBox which lists the existing locality_point features by name and date_entered.
        Returns the QComboBox object.
        """
        locality_point_layer = QgsProject.instance().mapLayersByName("locality_point")[0]

        combobox = QComboBox()

        def update_stylesheet() -> None:
            """
            Configure style to show red when default value is selected
            """
            if combobox.currentData() is None:
                style = "QComboBox:editable{color: red;}"
            else:
                style = ""
            combobox.setStyleSheet(style)
        combobox.currentTextChanged.connect(update_stylesheet)

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


    def create_photo_date_widget(self, photo: Path, photo_tags: dict[str, Any]) -> QLabel:
        """
        Create the required label widget to display the photo date.
        The date is first extracted from the EXIF metadata of the photo file,
        but if that is missing then the file creation date is used instead.
        """
        date_tag = "EXIF DateTimeOriginal"
        if date_tag in photo_tags:
            exif_date = photo_tags[date_tag].values
            date_display = dt.datetime.strptime(exif_date, "%Y:%m:%d %H:%M:%S")
        else:
            date_display = dt.datetime.fromtimestamp(photo.stat().st_mtime)

        # Hide miliseconds
        date_display = date_display.replace(microsecond=0)
        photo_date_label = QLabel(str(date_display))
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


    def import_selection(self) -> None:
        """
        Import the selected photos in the dialog into the project.
        Photos which have not been assigned a locality_point will be ignored.
        This also copies the photos into the photos directory of the project.
        """
        photo_layer = QgsProject.instance().mapLayersByName("photo")[0]
        photo_layer.startEditing()

        imported_photos = 0
        for photo_path, photo_widgets in self.photos_to_widgets.items():
            locality_fuid = photo_widgets["QComboBox"].currentData()

            if locality_fuid is not None:
                imported_photos += 1
                # Copy the photo file into the project
                new_photo = self.photos_dir / photo_path.name
                new_photo.write_bytes(photo_path.read_bytes())

                # Create new feature with default values
                new_feature = QgsVectorLayerUtils.createFeature(photo_layer)

                new_attributes = {
                    "locality_fuid": locality_fuid,
                    "photo_file": str(photo_path.name),
                    "notes": photo_widgets["QTextEdit"].toPlainText(),
                }
                for attribute, value in new_attributes.items():
                    new_feature.setAttribute(attribute, value)

                photo_layer.addFeature(new_feature)

        photo_layer.commitChanges()
        self.close()
        QMessageBox.information(None, "Imported Photos", f"Imported {imported_photos} photos successfully.")


    def closeEvent(self, event=None) -> None:
        """
        Function which is run by PyQt when the dialog is closed.
        """
        self.photo_importer_closed.emit()
