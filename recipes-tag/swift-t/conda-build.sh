#!/bin/bash
set -eu

set -x
which conda
conda build -c conda-forge --skip-existing .
