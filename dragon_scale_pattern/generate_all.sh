#!/bin/bash

rm -Rf ./dragon_scale_pattern/
time ../openscad_batch/generate_profile.sh -g jpg,webp,3mf ./dragon_scale_pattern.scad
