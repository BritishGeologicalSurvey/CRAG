from qgis.PyQt.QtCore import (
    Qt,
)
from qgis.PyQt.QtGui import QPixmap
from qgis.PyQt.QtWidgets import (
    QDialog,
    QLabel,
    QVBoxLayout,
)

from .utils import (  # noqa
    FieldDataCaptureProject,
    ipdb_breakpoint,
)


class AboutDialog(QDialog, FieldDataCaptureProject):
    """
    Simple PyQt dialog to display basic information about the plugin and BGS.
    """
    def __init__(self):
        super().__init__()

        self.setWindowTitle("About Field Data Capture - QGIS Plugin")
        self.setMinimumSize(350, 300)
        self.setWindowFlags(
            Qt.WindowType.Window | Qt.WindowType.WindowCloseButtonHint
        )
        self.setup_ui_elements()


    def setup_ui_elements(self) -> None:
        """
        Create the elements of the About dialog.
        """

        # Create dialog layout
        dialog_layout = QVBoxLayout()
        self.setLayout(dialog_layout)

        # Add BGS logo centered
        # Create label to store image pixmap
        image_label = QLabel()
        image_label.setAlignment(Qt.AlignmentFlag.AlignCenter)
        # Create and apply pixmap
        pixmap = QPixmap(str(self.bgs_logo_file))
        image_label.setPixmap(pixmap)

        dialog_layout.addStretch(1)
        dialog_layout.addWidget(image_label)
        dialog_layout.addStretch(2)

        # Add text box within a frame
        text_frame = self.create_bordered_frame()
        text_layout = QVBoxLayout()
        # Create text with hyperlinks
        enquiries_email = "enquiries@bgs.ac.uk"
        bgs_website = "https://www.bgs.ac.uk"
        about_text = (
            "This plugin was developed by the British Geological Survey.<br><br>"
            f"Please email <a href=mailto:{enquiries_email}>{enquiries_email}</a> for any questions "
            f"or visit our website: <a href={bgs_website}>{bgs_website}</a>"
        )
        about_text_label = QLabel(about_text)
        about_text_label.setWordWrap(True)
        about_text_label.setOpenExternalLinks(True)
        about_text_label.setAlignment(Qt.AlignmentFlag.AlignCenter)
        text_layout.addWidget(about_text_label)
        text_frame.setLayout(text_layout)

        dialog_layout.addWidget(text_frame)
        dialog_layout.addStretch(1)
