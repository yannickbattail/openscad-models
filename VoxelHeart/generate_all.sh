#!/bin/bash

run_in_docker() {
   docker run -it -v ./:/openscad openscad-nightly-tools $@
}

if [[ $1 == "thingiverse" ]]
then
  echo "generate for thingiverse"
  run_in_docker generate_for_thingiverse.sh EasiestHeart
  run_in_docker generate_for_thingiverse.sh VoxelHeart
  run_in_docker generate_for_thingiverse.sh heartJewel
else
  run_in_docker generate_profile.sh -g jpg,webp,3mf ./EasiestHeart.scad
  run_in_docker generate_profile.sh -g jpg,webp,3mf ./VoxelHeart.scad
  run_in_docker generate_profile.sh -g jpg,webp,3mf ./heartJewel.scad
fi
