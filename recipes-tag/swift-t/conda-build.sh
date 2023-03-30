#!/bin/bash
set -eu

set -x
which conda
conda build -c "bioconda/label/cf201901" -c conda-forge \
      --skip-existing --output .
