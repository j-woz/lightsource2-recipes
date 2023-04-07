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

# Edit swift-t-settings
echo $RECIPE_DIR/settings.sed
sed -i -f $RECIPE_DIR/settings.sed swift-t-settings.sh

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
