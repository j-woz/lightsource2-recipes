#!/bin/bash -norc
set -eu

LOG=conda-build.log
if [[ -f $LOG ]]
then
  mv -v --backup=numbered $LOG $LOG.bak
  echo
fi

# mkdir -pv out

(
  echo "using conda:"
  which conda
  echo

  set -x
  conda build \
        -c conda-forge \
        --dirty \
        .
) |& tee $LOG
echo
echo "conda build succeeded."
echo

LINES=( $( grep -A 1 "anaconda upload" $LOG ) )
FILE=${LINES[-1]}

(
  echo
  echo md5sum: $( md5sum $FILE )
) | tee --append $LOG

# --debug

#      --no-remove-work-dir

# --bootstrap NAME

# --keep-old-work       .
  #

# --skip-existing

# -c "bioconda/label/cf201901"

# --output # <-- This skips the build and just does a print!
