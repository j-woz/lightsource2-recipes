#!/bin/zsh
set -eu

# MAMBA INSTALL SH
# NOTE: conda install from file does not install dependencies!
#       Cf. https://docs.anaconda.com/free/anaconda/packages/install-packages
# Install dependencies
# Keep in sync with meta.yaml
# Usage: Provide -R to install R

R=""
zparseopts -D -E R=R
if (( ${#R} )) R=( r r-rinside )

if (( ${#*} != 1 )) {
  print "Provide PKG!"
  return 1
}
PKG=$1

ls -l $PKG
md5sum $PKG

which mamba
mamba env list

DEPS=( ant
       autoconf
       gcc
       make
       mpich-mpicc
       openjdk
       python
       swig
       zsh
       $R
     )

set -x
mamba install --yes -c conda-forge $DEPS
mamba install $PKG
