#!/bin/bash

run_in_docker() {
   docker run -it -v ./:/openscad openscad-nightly-tools $@
}

if [[ $1 == "thingiverse" ]]
then
  echo "generate for thingiverse"
  run_in_docker generate_for_thingiverse.sh orbWand
else
  run_in_docker generate_profile.sh -g jpg,webp,3mf ./orbWand.scad
fi
