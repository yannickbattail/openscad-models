#!/bin/bash

time ../openscad_batch/generate_profile.sh -g jpg,webp,3mf ./mugImage.scad
time ../openscad_batch/generate_profile.sh -g jpg,webp,3mf ./mugC3po.scad

../openscad_batch/one_file.sh ./mugImage.scad > mugImage_one_file.scad
