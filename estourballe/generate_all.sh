#!/bin/bash

run_in_docker() {
   docker run -it -v ./:/openscad openscad-nightly-tools $@
}

if [[ $1 == "thingiverse" ]]
then
  echo "generate for thingiverse"
  run_in_docker generate_for_thingiverse.sh estourballe
  run_in_docker generate_for_thingiverse.sh superEstourballe
  run_in_docker generate_for_thingiverse.sh hyperEstourballe
  run_in_docker generate_for_thingiverse.sh maistreEstourballe
else
  run_in_docker generate_profile.sh -g jpg,webp,3mf ./estourballe.scad
  run_in_docker generate_profile.sh -g jpg,webp,3mf ./superEstourballe.scad
  run_in_docker generate_profile.sh -g jpg,webp,3mf ./hyperEstourballe.scad
  run_in_docker generate_profile.sh -g jpg,webp,3mf ./maistreEstourballe.scad
fi
