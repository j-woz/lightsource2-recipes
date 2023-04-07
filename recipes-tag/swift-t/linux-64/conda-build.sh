#!/bin/bash
set -eu

set -x
# mkdir -pv out
which conda
conda build \
      -c conda-forge \
      --debug \
      --dirty \
      --no-remove-work-dir \
      .

# --bootstrap NAME

# --keep-old-work       .
  #

# --skip-existing

# -c "bioconda/label/cf201901"

# --output # <-- This skips the build and just does a print!
