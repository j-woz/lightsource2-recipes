#!/bin/bash
set -eux

which conda

conda install -c conda-forge gcc
# conda install -c conda-forge openjdk=11
# conda install -c conda-forge openmpi

conda install -c conda-forge /home/woz/Public/sfw/Anaconda/conda-bld/linux-64/swift-t-1.6.0-py39_1.tar.bz2
