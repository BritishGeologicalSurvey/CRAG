# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

from datetime import datetime
import os
import sys

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'CRAG'
copyright = str(datetime.now().year)
author = 'British Geological Survey'
release = '0.1'

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

# The remove_formats extension is included here
# See conf.py and remove_formats.py for details
extensions = ['myst_parser',
              'remove_formats',
              'sphinx_copybutton',
              "sphinx_subfigure",
              'rinoh',]

# MySt specific extensions
# colon_fence allows for ::: to be used for ```
# which adds flexibility in using MyST directives.
# attrs_inline allows for some html attributes to be inline
# deflist allows for definition lists
myst_enable_extensions = ['colon_fence',
                          'attrs_inline',
                          'deflist']
templates_path = ['_templates']
exclude_patterns = []

# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = 'sphinx_book_theme'
html_theme_options = {
    "show_toc_level": 3,
    "icon_links": [
        {
            "name": "GitHub",
            "url": "https://github.com/BritishGeologicalSurvey/CRAG",
            "icon": "fa-brands fa-github",
        },
    ]
}

# This directory contains subdirectories to be passed through to the built site
html_static_path = ['_static']

# Custom CSS file, imports BGS theme
html_css_files = ["custom.css"]

# rinoh settings
rinoh_documents = [dict(doc='index',                    # top-level file (index.md)
                        target='crag_user_guide',       # output (crag_user_guide.pdf)
                        template='user_guide.rtt')]     # document template

# Add config based on build target
# https://stackoverflow.com/questions/63099885/variable-external-links-based-on-sphinx-build-destination-eg-html-vs-pdf

sys.path.insert(0, os.path.abspath('_extensions'))


def setup(app):
    """
    Add a config variable to the the app env called buildername
    which is based on the build target. This is only respected
    when using sphinx-build explicitly and as such is designed for
    automated builds where modifications to the builds are made.

    See remove_formats.py for more details.
    """
    argv = ' '.join(sys.argv)
    if '-M rinoh' in argv:
        app.add_config_value('buildername', 'pdf', 'env')
    else:
        app.add_config_value('buildername', 'html', 'env')
