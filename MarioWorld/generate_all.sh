#!/bin/bash

rm -Rf ./MarioWorld/
#../openscad_batch/generate_profile.sh -g stl -p presentation ./MarioWorld.scad
../openscad_batch/generate_profile.sh -g jpg -p presentation ./MarioWorld.scad
../openscad_batch/generate_profile.sh -g jpg -p level1-part1 ./MarioWorld.scad
../openscad_batch/generate_profile.sh -g jpg -p level1-part2 ./MarioWorld.scad
../openscad_batch/generate_profile.sh -g jpg -p level1-part3 ./MarioWorld.scad
