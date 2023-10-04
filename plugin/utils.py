import logging

from PyQt5.QtCore import pyqtRemoveInputHook


def ipdb_breakpoint():
    """
    Drops code into IPython debugger when QGIS is run from command line.
    Otherwise returns an error.  Press 'c' to *continue* running code.
    """
    import ipdb  # noqa - don't import at top level as isn't in default QGIS install

    # Switch off unwanted IPython loggers
    for lib in ('asyncio', 'parso'):
        logging.getLogger(lib).setLevel(logging.WARNING)

    pyqtRemoveInputHook()
    ipdb.set_trace()
