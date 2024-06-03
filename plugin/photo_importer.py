import logging
from pathlib import Path
from typing import (
    Any,
    Callable,
    Optional,
)

import exifread
from qgis.core import (
    Qgis,
    QgsEditorWidgetSetup,
    QgsFeature,
    QgsLayerTree,
    QgsLayerTreeGroup,
    QgsMapLayer,
    QgsMapLayerDependency,
    QgsProject,
    QgsRuleBasedRenderer,
    QgsSymbol,
    QgsVectorLayer,
    QgsVectorLayerUtils,
)
from qgis.gui import (
    QgisInterface,
    QgsMapTool,
)
from qgis.PyQt.QtCore import Qt
from qgis.PyQt.QtGui import (
    QColor,
    QIcon,
    QImage,
    QPixmap,
    QTransform,
)
from qgis.PyQt.QtWidgets import (
    QAction,
    QComboBox,
    QDialog,
    QFileDialog,
    QFrame,
    QGridLayout,
    QHBoxLayout,
    QLabel,
    QMenu,
    QMessageBox,
    QPushButton,
    QScrollArea,
    QVBoxLayout,
    QWidget,
)

# Initialize Qt resources from file resources.py
from .resources import *  # noqa

from .utils import ipdb_breakpoint  # noqa


class PhotoImporter(QDialog):
    """
    QDialog for selecting which photos to import and selecting
    which locality_points the photos relate to.
    """
    def __init__(self, photos_dir: Path):
        super().__init__()

        self.photos_dir = photos_dir

        # Setting the Dialog Box settings
        self.setWindowTitle("Import Photos")
        self.setMinimumSize(500, 500)
        self.setWindowFlags(
            Qt.Window | Qt.WindowCloseButtonHint
        )
        self.setup_ui_elements()
        self.connect_signals_and_slots()

        self.photos_to_widgets: dict[Path, QComboBox] = {}

        # Make it modal so changes are not made whilst importing photos
        self.exec()


    def setup_ui_elements(self) -> None:
        """
        Create the elements of the Photo Importer dialog box User Interface.
        Also sets the layout for the dialog box.
        """
        self.select_photos_button = QPushButton("Select Photos", self)
        self.import_selection_button = QPushButton("Import Selected Photos", self)

        # To make a layout scrollable, you have to wrap it in a standrd QWidget object
        self.photo_rows_layout = QVBoxLayout(self)
        layout_wrapper = QWidget(self)
        layout_wrapper.setLayout(self.photo_rows_layout)
        scroll = QScrollArea(self)
        scroll.setWidget(layout_wrapper)
        scroll.setWidgetResizable(True)

        # Arrange the main layout
        layout = QVBoxLayout()
        layout.addWidget(self.select_photos_button)
        layout.addWidget(scroll)
        layout.addWidget(self.import_selection_button)
        self.setLayout(layout)


    def connect_signals_and_slots(self) -> None:
        """
        Function for connecting signals and slots of buttons and input boxes.
        """
        self.select_photos_button.clicked.connect(self.select_photos)
        self.import_selection_button.clicked.connect(self.import_selection)


    def create_photo_widget(self, photo: Path) -> QLabel:
        label = QLabel(self)
        label.setFixedSize(200, 200)
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
        with open(photo, "rb") as photo_file:
            tags = exifread.process_file(photo_file)
        if "Image Orientation" in tags:
            orientation_code = tags["Image Orientation"].values[0]
            transform = QTransform()
            transform.rotate(orientation_to_rotation[orientation_code])
            pixmap = pixmap.transformed(transform)

        # Set the pixmap and scale it down
        label.setPixmap(pixmap.scaled(200, 200, aspectRatioMode=Qt.KeepAspectRatio))
        return label


    def create_combobox(self) -> QComboBox:
        """
        Create a QComboBox which lists the existing locality_point features by name and date_entered.
        Returns the QComboBox object.
        """
        locality_point_layer = QgsProject.instance().mapLayersByName("locality_point")[0]

        combobox = QComboBox(self)
        combobox.addItem("Select Photo", userData=None)

        for locality_feature in locality_point_layer.getFeatures():
            locality_date = locality_feature.attribute("date_entered").toPyDateTime()
            combobox.addItem(
                f"{locality_feature.attribute('name')} | {locality_date}",
                userData=locality_feature.attribute("uuid"),
            )

        return combobox


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
            photos_string_list = "\n".join([str(photo) for photo in skip_photos])
            QMessageBox.warning(
                None,
                "Skipped Existing Photos",
                f"The current photos either already exist or are already selected and will be skipped:\n\n{photos_string_list}"
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
        """
        # Create widgets
        photo_label = QLabel(str(photo.name))
        photo_label.setFixedWidth(200)
        combobox = self.create_combobox()
        photo_widget = self.create_photo_widget(photo)
        notes_label = QLabel("This will be the notes")
        self.photos_to_widgets[photo] = combobox

        # Arrange layout for new widgets
        # Top part of each photo row
        top_hbox = QHBoxLayout(self)
        top_hbox.addWidget(photo_label)
        top_hbox.addWidget(combobox)
        # Bottom part of each photo row
        bottom_hbox = QHBoxLayout(self)
        bottom_hbox.addWidget(photo_widget)
        bottom_hbox.addWidget(notes_label)

        row_layout = QVBoxLayout(self)
        row_layout.addLayout(top_hbox)
        row_layout.addLayout(bottom_hbox)
        row_frame = QFrame()
        row_frame.setFrameStyle(QFrame.Panel | QFrame.Raised)
        row_frame.setLayout(row_layout)
        self.photo_rows_layout.addWidget(row_frame)


    def import_selection(self) -> None:
        """
        Import the selected photos in the dialog into the project.
        Photos which have not been assigned a locality_point will be ignored.
        This also copies the photos into the photos directory of the project.
        """
        photo_layer = QgsProject.instance().mapLayersByName("photo")[0]
        photo_layer.startEditing()

        for photo_path, combobox in self.photos_to_widgets.items():
            locality_fuid = combobox.currentData()

            if locality_fuid is not None:
                # Copy the photo file into the project
                new_photo = self.photos_dir / photo_path.name
                new_photo.write_bytes(photo_path.read_bytes())

                # Create new feature with default values
                new_feature = QgsVectorLayerUtils.createFeature(photo_layer)

                new_attributes = {
                    "locality_fuid": locality_fuid,
                    "photo_file": str(photo_path.name),
                }
                for attribute, value in new_attributes.items():
                    new_feature.setAttribute(attribute, value)

                photo_layer.addFeature(new_feature)

        photo_layer.commitChanges()
        self.close()
