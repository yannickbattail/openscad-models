#!/bin/bash

rm -Rf ./standard_dice

time ../openscad_batch/generate_profile.sh ./standard_dice.scad
time ../openscad_batch/generate_profile.sh ./dice_number.scad
