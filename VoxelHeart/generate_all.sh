#!/bin/bash

run_in_docker() {
   docker run -it -v ./:/openscad openscad-nightly-tools $@
}

for file in *.scad; do
  if [[ $1 == "thingiverse" ]]
  then
    echo "generate for thingiverse"
    run_in_docker generate_for_thingiverse.sh "$(basename ${file} .scad)"
  else
    run_in_docker generate_profile.sh -g jpg,webp,3mf "${file}"
  fi
done
