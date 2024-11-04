#!/bin/bash

run_in_docker() {
  docker run -it -v ./:/work openscad-tools $@
}

if [[ $1 == "thingiverse" ]]
then
  echo "generate for thingiverse"
  run_in_docker generate_for_thingiverse.sh dice_animal
else
  run_in_docker generate_profile.sh -g jpg,webp,3mf ./dice_animal.scad
fi
