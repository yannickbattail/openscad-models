#!/bin/bash

run_in_docker() {
   docker run -it \
     --user "$(id -u):$(id -g)" \
     -v ./:/openscad \
     openscad-nightly-tools $@
}

run_in_docker bash -c "./tests/tests.sh"
