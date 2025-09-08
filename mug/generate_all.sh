#!/bin/bash

time ../openscad_batch/generate_profile.sh -g jpg,gif,webp,3mf ./mugImage.scad

../openscad_batch/one_file.sh ./mugImage.scad > mugImage_one_file.scad
