#!/bin/bash

time ../openscad_batch/generate_profile.sh ./mugImage.scad

../openscad_batch/one_file.sh ./mugImage.scad > mugImage_one_file.scad
