#!/bin/bash
set -eu
set +x

echo PREFIX $PREFIX

install -d $PREFIX/bin
install -d $PREFIX/etc
install -d $PREFIX/lib
install -d $PREFIX/scripts
install -d $PREFIX/swift-t

build_dir=dev/build

cd $build_dir
rm -fv swift-t-settings.sh
bash init-settings.sh

SETTINGS_SED=$RECIPE_DIR/settings.sed
echo ENABLE_R ${ENABLE_R:-0}
if (( ${ENABLE_R:-0} == 1 ))
then
  R_HOME=$( Rscript -e 'cat(R.home())' )
  SETTINGS_SED=$RECIPE_DIR/settings-R.sed
fi

# Edit swift-t-settings
sed -i -f $SETTINGS_SED swift-t-settings.sh

# Build it!
./build-swift-t.sh

# Setup symlinks for utilities
### BIN ###
cd $PREFIX/bin
for file in stc swift-t helpers.zsh; do
    ln -sv ../swift-t/stc/bin/$file .
done
for file in turbine; do
    ln -sv ../swift-t/turbine/bin/$file .
done

### ETC ###
cd $PREFIX/etc
for file in stc-config.sh turbine-version.txt; do
    ln -sv ../swift-t/stc/etc/$file .
done
ln -sv ../swift-t/stc/etc/help .
ln -sv ../swift-t/turbine/etc/version.txt .

### LIB ###
cd $PREFIX/lib
ln -sv ../swift-t/stc/lib/*.jar .
# A workaround for a missing library
ln -sv libmpi.so libmpi.so.20

### SCRIPTS ###
cd $PREFIX/scripts
for file in turbine-config.sh; do
    ln -sv ../swift-t/turbine/scripts/$file .
done
