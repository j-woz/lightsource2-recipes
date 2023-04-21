#!/bin/bash
set -eu

# OBSOLETE: 2023-04-20
# CONDA INSTALL DEPS
# Test to just install dependencies
# Keep in sync with meta.yaml

which conda
conda env list

set -x
conda install -c conda-forge \
      ant \
      autoconf \
      gcc \
      make \
      openjdk \
      mpich-mpicc \
      python \
      swig \
      zsh \
