#!/bin/bash

stl_dir=horns_stl

mkdir -p $stl_dir

horns_list="n o s w e nw ne sw se"
for horn in $horns_list
do
    echo generating horn $horn ...
    openscad -q -o ./${stl_dir}/horn_${horn}.stl -D "horn=\"$horn\"" ./horns_display.scad
done
