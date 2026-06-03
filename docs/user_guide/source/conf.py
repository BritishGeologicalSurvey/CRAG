# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

import os
import sys

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'CRAG'
copyright = 'BGS 2026'
author = 'Colin Blackburn'
release = '0.1'

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

# The remove_formats extension is included here
# See conf.py and remove_formats.py for details
extensions = ['myst_parser',
              'remove_formats',
              'sphinx_copybutton',
              "sphinx_subfigure",]

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

html_theme = 'alabaster'
html_theme_options = {
    'fixed_sidebar': True,
}
html_sidebars = {
    "**": [
        "about.html",
        "searchfield.html",
        "navigation.html",
    ]
}

# This directory contains subdirectories to be passed through to the built site
html_static_path = ['_static']

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
    if '-M latexpdf' in argv:
        app.add_config_value('buildername', 'pdf', 'env')
    else:
        app.add_config_value('buildername', 'html', 'env')
