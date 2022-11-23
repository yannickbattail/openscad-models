#!/bin/bash

time ./generate_profile.sh --config-file pipe2_examples-config.sh ./pipe1_examples.scad
time ./generate_profile.sh --config-file pipe2_examples-config.sh ./pipe2_examples.scad
### example of full usage
# ./generate_profile.sh --config-file pipe2_examples-config.sh --only-parameter-set example --generate stl ./pipe2_examples.scad
### same but with short options
# ./generate_profile.sh -c pipe2_examples-config.sh -p example -g stl ./pipe2_examples.scad
