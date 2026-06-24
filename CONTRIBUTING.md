# Contributing to CRAG

## Roadmap

`CRAG` is currently at release status.
All main features are complete, however contributions and suggestions are welcome.

See the [issues list](https://github.com/BritishGeologicalSurvey/crag/issues) for details of future development plans.

### Overall Philosophy

The plugin in this repository should contain everything that is required to set up a CRAG project in QGIS.
There are a few overarching principles to bear in mind during development:

+ This is not an application, it is a GeoPackage and QGIS configuration optimised for geological field data capture.  The aim of the plugin is to automate the creation of the GeoPackage and Forms.
+ Once created, a project should function by itself, without requiring custom logic from the plugin.
+ The plugin should not depend on BGS infrastructure nor on Mergin Maps and the likelihood of future translation requirements should be kept in mind.

## Developer setup

[https://www.github.com/BritishGeologicalSurvey/crag](https://www.github.com/BritishGeologicalSurvey/crag) is a the source-of-truth copy of CRAG.
Pull requests and issues should be targeted at this GitHub repository.

> The development environment is Linux under WSL, using a Conda virtual environment.

### Prerequisites

+ Python 3.12+ virtual environment
+ Git
+ QGIS


### Installation for development

Install locally for development by cloning repository and running the following
in the root:

```bash
conda env create -f environment.yml
export PYTHONPATH=.
```


### Running tests

Automated tests are created using `pytest` and can be run with:

```bash
pytest -vv test/
```


### Deploying the plugin

To copy the plugin to your Linux QGIS plugins folder, run:

```bash
bin/deploy_plugin.sh
```

You may need to manually activate the plugin if it was not installed already.

If you install the QGIS Plugin Reloader plugin, you can use it to quickly reload to the newly installed version.

#### Manually deploying the plugin

If you are developing the plugin using Linux under WSL, but you need to test the plugin using QGIS under Windows,
you can manually copy the plugin to Windows. From within the repository folder and using your Windows username:

```bash
cp -rf CRAG /mnt/c/Users/windows_user/AppData/Roaming/QGIS/QGIS3/profiles/default/python/plugins/.
```


### QGIS debugging tips

It is much easier to debug and understand your application by interacting with it directly.
This is possible in QGIS via the Python console.
Even better is the IPython QGIS console plugin, which offers tab complete.
It is necessary to have Jupyter installed on the Python environment used by QGIS in order to use it.
To access the plugin class within the Python console, run:

```python
import qgis
crag = qgis.utils.plugins['crag']
```

From there, plugin attributes and methods can accessed directly e.g. `crag.add_gpkg_to_project()`


### Building documentation

The documentation is created using Sphinx.
To build the HTML documentation locally, run the following:
 
```bash
sphinx-build -M html docs/user_guide/source/ docs/user_guide/build/
```

The documentation can then be viewed at `docs/user_guide/build/html/index.html`

To build the PDF documentation locally, run the following:

```bash
sphinx-build -M rinoh docs/user_guide/source/ docs/user_guide/build/
```

The documentation can then be viewed at `docs/user_guide/build/rinoh/crag_user_guide.pdf`


## Creating a new release

Releases are created manually from the main branch via tags.
This should be done via the GitHub web interface.
The GitHub Actions CI system will automatically run linting,
tests, security scans, and build the plugin for a new release.
