#!/bin/bash

run_in_docker() {
   docker run -it -v ./:/work openscad-tools $@
}

if [[ $1 == "thingiverse" ]]
then
  run_in_docker generate_for_thingiverse.sh BendingLibTests
  run_in_docker generate_for_thingiverse.sh BendingLibTests
else
  run_in_docker generate_profile.sh -g jpg,webp,3mf ./BendingLibTests.scad
  run_in_docker generate_profile.sh -g jpg,webp,3mf ./BendingLibTests.scad
fi
