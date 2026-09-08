<!--
Copyright 2026 UKRI / British Geological Survey
Licensed under GPLv3 licence
SPDX-License-Identifier: GPL-3.0-or-later
-->

# CRAG QGIS plugin


> CRAG (Collection and Reporting of Associated Geodata) is a QGIS plugin developed by the British Geological Survey for digital field data capture and geological mapping.

⚠ The CRAG plugin has been released for external testing and publication to the _experimental_ QGIS plugin repository.
Please report any issues on the [Issue Tracker](https://github.com/BritishGeologicalSurvey/CRAG/issues). ⚠

The CRAG plugin performs three main functions:

  1) Sets up any QGIS project for geological mapping work, complete with configured styles, forms and a GeoPackage for storage
  2) Provides tools for efficient data entry/editing and for photo imports
  3) Generates reports in HTML and PDF formats

The underlying data model, feature lists, feature and line types and styling are based on decades of experience of digital geological mapping.
CRAG projects use advanced features of QGIS forms, such as Relation References and Expressions, and of GeoPackage databases, such as foreign-key references and views, to create a more expressive data model than the flat table structures normally associated with GIS data.
This ensures that collected field data are compatible with BGS data.

See the User Guide for details: https://britishgeologicalsurvey.github.io/CRAG


## Installation

You can download the latest version of the CRAG plugin as a ZIP file from the latest release assets.

[Latest Release Assets](https://github.com/BritishGeologicalSurvey/CRAG/releases/latest)

In QGIS, select _Plugins > Manage and Install Plugins > Install from ZIP_

The release assets also include an empty CRAG data GeoPackage and Entity Relationship (ER) diagrams that describe the CRAG data model.


## Overall philosophy

CRAG aims to do one thing well: to facilitate collection of geological field observation data in QGIS.
There are a few overarching principles to bear in mind during development:

+ The plugin should contain everything that is required to set up a CRAG project in QGIS.
+ Once created, a CRAG project should function by itself in any QGIS installation, without requiring custom logic from the plugin.
+ A CRAG project should function within MerginMaps system for collaborative data collection on mobile devices.


## Useful links

+ [British Geological Survey](https://www.bgs.ac.uk)
+ [QGIS Documentation](https://docs.qgis.org/3.44/en/docs/)
+ [MerginMaps documentation](https://merginmaps.com/docs/)


## Licence

CRAG is distributed under the GPL v3.0 licence. Copyright: © British Geological Survey 2026
