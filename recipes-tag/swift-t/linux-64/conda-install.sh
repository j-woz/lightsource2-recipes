#!/bin/zsh
set -eu

# CONDA INSTALL SH
# This is mostly for maintainer testing
# NOTE: conda install from file does not install dependencies!
#       Cf. https://docs.anaconda.com/free/anaconda/packages/install-packages
# Install dependencies
# Keep in sync with meta.yaml
# Usage: Provide -R to install R

R=""
zparseopts -D -E R=R
if (( ${#R} )) R="r"

if (( ${#*} != 1 )) {
  print "Provide PKG!"
  return 1
}
PKG=$1

ls -l $PKG
md5sum $PKG

which conda
conda env list

set -x
conda install -c conda-forge \
      ant \
      autoconf \
      gcc \
      make \
      mpich-mpicc \
      openjdk \
      python \
      swig \
      zsh \
      $R

conda install $PKG
