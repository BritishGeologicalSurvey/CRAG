import logging
from pathlib import Path

from PyQt5.QtCore import pyqtRemoveInputHook


class FieldDataCaptureProject:
    """
    Base/Mixin class for basic attributes of the project file structure.
    This class includes a base __init__ method which can be overwritten/ignored if a self.project_dir
    attribute is defined using other means.
    """
    project_dir: Path
    gpkg_filename = Path("field-data-capture.gpkg")

    def __init__(self, project_dir: Path):
        """
        Base init method which sets the self.project_dir attribute using the given Path.
        """
        self.project_dir = project_dir

    @property
    def db_file(self) -> Path:
        """
        Get the db file path from the current project.
        """
        return self.project_dir / self.gpkg_filename

    @property
    def styles_dir(self) -> Path:
        """
        Get the styles directory path from the current project.
        """
        return self.project_dir / "styles"

    @property
    def photos_dir(self) -> Path:
        """
        Get the photos directory path from the current project.
        """
        return self.project_dir / "photos"

    @property
    def media_dir(self) -> Path:
        """
        Get the media directory path from the current project.
        """
        return self.project_dir / "media"


def ipdb_breakpoint():
    """
    Drops code into IPython debugger when QGIS is run from command line.
    Otherwise returns an error.  Press 'c' to *continue* running code.
    """
    try:
        import ipdb  # noqa - don't import at top level as isn't in default QGIS install

        # Switch off unwanted IPython loggers
        for lib in ('asyncio', 'parso'):
            logging.getLogger(lib).setLevel(logging.WARNING)

        pyqtRemoveInputHook()
        ipdb.set_trace()
    except ModuleNotFoundError:
        pass
