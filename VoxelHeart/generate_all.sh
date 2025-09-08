#!/bin/bash

rm -Rf ./EasiestHeart ./VoxelHeart

time ../openscad_batch/generate_profile.sh ./EasiestHeart.scad
time ../openscad_batch/generate_profile.sh ./VoxelHeart.scad
