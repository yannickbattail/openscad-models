#!/bin/bash

time ../openscad_batch/generate_profile.sh -g jpg,gif,stl ./mugImage.scad
time ../openscad_batch/generate_profile.sh -g jpg,gif,stl --f3d ./mugC3po.scad

../openscad_batch/one_file.sh ./mugImage.scad > mugImage_one_file.scad
