#!/bin/bash
set -eu

# Install dependencies
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
