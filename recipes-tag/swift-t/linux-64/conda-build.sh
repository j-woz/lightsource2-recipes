#!/bin/zsh
set -eu

R=""
zparseopts -D -E R=R

if (( ${#R} ))
then
  cp -v meta-R.yaml meta.yaml
else
  cp -v meta-plain.yaml meta.yaml
fi

LOG=conda-build.log
if [[ -f $LOG ]]
then
  mv -v --backup=numbered $LOG $LOG.bak
  echo
fi

(
  echo "using conda:"
  which conda
  echo

  set -x
  conda build purge-all
  conda build \
        -c conda-forge \
        --dirty \
        .
) |& tee $LOG
echo
echo "conda build succeeded."
echo

UPLOAD=( $( grep -A 1 "anaconda upload" $LOG ) )
FILE=${UPLOAD[-1]}

(
  echo
  echo md5sum: $( md5sum $FILE )
) | tee --append $LOG
echo

# --debug

#      --no-remove-work-dir

# --bootstrap NAME

# --keep-old-work       .
  #

# --skip-existing

# -c "bioconda/label/cf201901"

# --output # <-- This skips the build and just does a print!
