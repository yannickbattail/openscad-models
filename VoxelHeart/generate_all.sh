#!/bin/bash

rm -Rf ./EasiestHeart ./VoxelHeart

time ../openscad_batch/generate_profile.sh -g jpg,webp,3mf ./EasiestHeart.scad
time ../openscad_batch/generate_profile.sh -g jpg,webp,3mf  ./VoxelHeart.scad
