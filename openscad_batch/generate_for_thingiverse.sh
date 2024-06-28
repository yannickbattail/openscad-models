#!/bin/bash

generate_for_thingiverse() {
  mkdir -p ./thingiverse/
  file=$1
  generate_profile.sh -g jpg,gif,stl ./${file}.scad

  mv ./${file}/3D/*.stl ./thingiverse/
  mv ./${file}/gif/*.gif ./thingiverse/
  mv ./${file}/images/mosaic_*.jpg ./thingiverse/
  cp ./${file}.json ./thingiverse/

  one_file.sh ./${file}.scad > ./thingiverse/${file}.scad
}

for f in "$@"
do
  generate_for_thingiverse $f
done
