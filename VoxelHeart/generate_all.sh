#!/bin/bash

run_in_docker() {
   docker run -it -v ./:/work openscad-tools $@
}

if [[ $1 == "thingiverse" ]]
then
  echo "generate for thingiverse"
  run_in_docker generate_for_thingiverse.sh VoxelHeart
  run_in_docker generate_for_thingiverse.sh EasiestHeart
else
  run_in_docker generate_profile.sh -g jpg,webp,3mf ./VoxelHeart.scad
  run_in_docker generate_profile.sh -g jpg,webp,3mf ./EasiestHeart.scad
fi
