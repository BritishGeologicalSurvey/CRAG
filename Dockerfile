FROM continuumio/miniconda3:23.5.2-0

# Install operating system dependencies
RUN apt-get update -y \
    && apt-get install -y \
      build-essential \
      # graphviz is required to render ER diagrams
      graphviz \
      graphviz-dev \
      # spatialite provides spatial functions in SQLite database
      spatialite-bin \
      libsqlite3-mod-spatialite \
      # xvfb provides a headless X server for testing gui apps
      xvfb \
      zip \
      # libsqlite3 is required to build pygeodiff
      libsqlite3-dev \
    && apt-get clean

COPY environment.yml /environment.yml

RUN conda env create -f /environment.yml

# Fix sqlite3 dependency issue with environment
RUN rm -rf ${CONDA_PREFIX}/lib/libsqlite3*
RUN rm -rf ${CONDA_PREFIX}/include/sqlite3*
