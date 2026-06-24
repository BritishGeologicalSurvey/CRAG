<!--
Copyright 2026 UKRI / British Geological Survey
Licensed under GPLv3 licence
SPDX-License-Identifier: GPL-3.0-or-later
-->
# model-and-forms plugin

> This repository contains code for a QGIS plugin to add the CRAG layers to a QGIS project and additional tools for using QGIS in the field.

Plugin documentation: http://field-data-capture.glpages.ad.nerc.ac.uk/sigma-q-user-guide/

Scripts are required to:

+ Build a geopackage containing the CRAG data model
+ Run tests on the constraints, views and triggers within the data model
+ Add the CRAG layers to an open QGIS project
+ Configure forms within QGIS for the CRAG layers
+ Configure QGIS to have minimal interface for ease of use on tablets

## Mergin Maps projects

Development of the CRAG system will follow this pattern:

> Data model updates -> QGIS/Mergin project configured by hand -> QGIS plugin implements automatic config

There is lots of exploratory work to do in terms of QGIS project configuration.
This will require multiple QGIS projects to be created.
We will share these projects via Mergin Maps so that they can be tested and feedback collected.

See the [Versions and Feedback](https://kwvmxgit.ad.nerc.ac.uk/field-data-capture/model-and-forms/-/wikis/versions-and-feedback) page on the Wiki for details.

## File Downloads

- [CRAG GPKG](https://kwvmxgit.ad.nerc.ac.uk/field-data-capture/model-and-forms/-/jobs/artifacts/main/raw/field-data-capture.gpkg?job=publish_artifacts)
- [Latest development build of plugin from `main` branch](https://kwvmxgit.ad.nerc.ac.uk/field-data-capture/model-and-forms/-/jobs/artifacts/main/raw/crag.zip?job=package_plugin)

### ER Diagram

There are 2 "primary key" columns on the data tables.  `fid` is used by QGIS/Geopackage.  We let the respective tool populate those and consider them unstable as the `fid` can change during Mergin Maps syncing process.  The `uuid` column is the unique key used to define parent-child relationships.

Note that all non-dictionary tables also have `recorded_by` and `recorded_on` columns.

- [Locality Diagram](https://kwvmxgit.ad.nerc.ac.uk/field-data-capture/model-and-forms/-/jobs/artifacts/main/raw/er-diagram-locality.png?job=publish_artifacts)
- [Lines Diagram](https://kwvmxgit.ad.nerc.ac.uk/field-data-capture/model-and-forms/-/jobs/artifacts/main/raw/er-diagram-lines.png?job=publish_artifacts)
- [Views Diagram](https://kwvmxgit.ad.nerc.ac.uk/field-data-capture/model-and-forms/-/jobs/artifacts/main/raw/er-diagram-views.png?job=publish_artifacts)


## Overall philosophy

The plugin should contain everything that is required to set up a CRAG project in QGIS.
There are a few overarching principles to bear in mind during development:

+ This is not an application, it is a GeoPackage and QGIS configuration optimised for geological CRAG.  The aim of the plugin is to automate the creation of the GeoPackage and Forms.
+ Once created, a project should function by itself, without requiring custom logic from the plugin.


## Plugin

### Installing the QGIS plugin

1. Enable the repository in QGIS via _Plugins > Manage and Install Plugins > Settings > Plugin Repositories > Add_
2. Set the Name to "CRAG"
3. Set the URL to http://field-data-capture.glpages.ad.nerc.ac.uk/model-and-forms/plugins.xml
4. Press OK
5. Search for and install `CRAG` in the _All_ tab

The plugin can then be launched from the _Plugins_ menu.  When new versions are released they will be shown in the _Upgradeable_ tab.

### Running the plugin

Once installed, the plugin is available at _Plugins > CRAG_.


## Useful links

+ [QGIS Documentation](https://docs.qgis.org/3.44/en/docs/)
+ [MerginMaps documentation](https://merginmaps.com/docs/)
