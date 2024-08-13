#!/bin/bash

run_in_docker() {
   docker run -it -v ./:/work openscad-tools $@
}

if [[ $1 == "thingiverse" ]]
then
#  run_in_docker generate_for_thingiverse.sh mugImage
#  run_in_docker generate_for_thingiverse.sh mugC3po
#  run_in_docker generate_for_thingiverse.sh mugR2d2
#  run_in_docker generate_for_thingiverse.sh mugGrogu
  run_in_docker generate_for_thingiverse.sh nutellaGlass
else
#  run_in_docker generate_profile.sh -g jpg,webp,3mf ./mugImage.scad
#  run_in_docker generate_profile.sh -g jpg,webp,3mf ./mugC3po.scad
#  run_in_docker generate_profile.sh -g jpg,webp,3mf ./mugR2d2.scad
#  run_in_docker generate_profile.sh -g jpg,webp,3mf ./mugGrogu.scad
  run_in_docker generate_profile.sh -g jpg,webp,3mf ./nutellaGlass.scad
fi
