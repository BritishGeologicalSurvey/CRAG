import logging
import sqlite3
from pathlib import Path
from typing import Any

from PyQt5.QtCore import pyqtRemoveInputHook

from .create_gpkg_from_sql import WORKDIR


class FieldDataCaptureProject:
    """
    Base/Mixin class for basic attributes of the project file structure.
    This class includes a base __init__ method which can be overwritten/ignored if a self.project_dir
    attribute is defined using other means.
    """
    project_dir: Path
    gpkg_filename = Path("field-data-capture.gpkg")
    report_filename = Path("field-report.html")
    css_filename = Path("style.css")
    # Using locally downloaded woff2 of Google's Material Symbols Outlined font
    # See: https://fonts.google.com/icons
    # Licence: https://www.apache.org/licenses/LICENSE-2.0.html
    font_filename = Path("MaterialSymbolsOutlined[FILL,GRAD,opsz,wght].woff2")

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

    @property
    def icons_dir(self) -> Path:
        """
        Get the icons directory path from the plugin folder.
        """
        return WORKDIR / "icons"

    @property
    def report_file(self) -> Path:
        """
        Get the field report file path from the current project.
        """
        return self.project_dir / self.report_filename


    @property
    def css_src_file(self) -> Path:
        """
        Get the ccs file path from the plugin folder.
        """
        return WORKDIR / "css" / self.css_filename


    @property
    def css_dest_dir(self) -> Path:
        """
        Get the ccs directory from the current project.
        """
        return self.project_dir / "css"


    @property
    def font_src_file(self) -> Path:
        """
        Get the font file path from the plugin folder.
        """
        return WORKDIR / "fonts" / self.font_filename


    @property
    def font_dest_dir(self) -> Path:
        """
        Get the ccs directory from the current project.
        """
        return self.project_dir / "fonts"


    @property
    def templates_dir(self) -> Path:
        """
        Get the Jinja2 template directory path from the plugin folder.
        """
        return WORKDIR / "templates"



def get_table_rows(db_file: Path, sql: str) -> list[dict[str, Any]]:
    """
    Get the rows from the given database file using the given SQL query.
    The rows are created using a dictionary row factory.
    """
    def dict_factory(cursor, row):
        """
        See https://docs.python.org/3/library/sqlite3.html#sqlite3-howto-row-factory
        """
        fields = [column[0] for column in cursor.description]
        return {key: value for key, value in zip(fields, row)}

    rows = []
    with sqlite3.connect(db_file) as conn:
        conn.enable_load_extension(True)
        conn.execute("SELECT load_extension('mod_spatialite');")
        conn.row_factory = dict_factory
        cursor = conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
    conn.close()

    return rows


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
