# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

from datetime import datetime

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'CRAG'
copyright = str(datetime.now().year)
author = 'British Geological Survey'
release = '0.1'

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = ['myst_parser',
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
