#!/bin/bash

run_in_docker() {
   docker run -it \
     --user "$(id -u):$(id -g)" \
     -v ./:/openscad \
     openscad-nightly-tools $@
}

file=animal_d20.scad

if [[ $1 == "thingiverse" ]]
then
  echo "generate for thingiverse"
  run_in_docker generate_for_thingiverse.sh "$(basename ${file} .scad)"
else
  npx openscad-generate generate ./animal_d20.scad
#  run_in_docker generate_profile.sh -g jpg,3mf "${file}"
fi
