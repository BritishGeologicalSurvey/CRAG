FROM continuumio/miniconda3:23.5.2-0

# Install operating system dependencies
RUN apt-get update -y && \
    apt-get install -y \
      build-essential \
      graphviz \
      graphviz-dev \
      spatialite-bin \
      libsqlite3-mod-spatialite

COPY environment.yml /environment.yml

RUN conda env create -f /environment.yml
