#!/bin/bash

run_in_docker() {
   docker run -it \
     --user "$(id -u):$(id -g)" \
     -v ./:/openscad \
     openscad-nightly-tools $@
}

if [[ $1 == "thingiverse" ]]
then
  echo "generate for thingiverse"
  run_in_docker generate_for_thingiverse.sh ls_holder
else
  run_in_docker generate_profile.sh -g jpg,webp,3mf ./ls_holder.scad
fi
