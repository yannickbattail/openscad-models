#!/bin/bash
#set -x

fn=50

mkdir -p ./stl/
#OPENSCAD=xvfb-run -a openscad
OPENSCAD="xvfb-run -a openscad-nightly"
parts_list="cat dino dragon fox panda heart_gem"
for part in $parts_list
do
    echo generating ./stl/${part}.stl ...
    $OPENSCAD -q -o ./stl/${part}.stl -D "part=\"$part\"" -D "\$fn=${fn}" --export-format asciistl --enable sort-stl ./dice_animal.scad
done

echo done.
