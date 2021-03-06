#!/bin/sh
if [ $1 != "-c" ]; then
    git clone https://github.com/oumpy/hp_management.git
    cd hp_management
    git clone https://github.com/oumpy/oumpy.github.io.git ./output
    git submodule update -i
fi

themename="voidy-bootstrap"
cd themes
git submodule update "$themename"
cd ..
mkdir -p "theme/$themename"
cp -an "themes/$themename"/* "theme/$themename/"
