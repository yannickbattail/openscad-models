#!/bin/bash

generate() {
    file=$1
    time ../openscad_batch/generate_profile.sh -g jpg,gif,stl --f3d ./${file}.scad
    
    mv ./${file}/3D/*.stl ./thingiverse/
    mv ./${file}/gif/*.gif ./thingiverse/
    mv ./${file}/images/mosaic_*.jpg ./thingiverse/
    cp ./${file}.json ./thingiverse/
    
    ../openscad_batch/one_file.sh ./${file}.scad > ./thingiverse/${file}.scad
}

mkdir -p ./thingiverse/

generate mugImage
generate mugC3po
generate mugGrogu
generate nutellaGlass
