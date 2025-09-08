#!/bin/bash

rm -Rf ./standard_dice    && time ../openscad_batch/generate_profile.sh ./standard_dice.scad
rm -Rf ./dice_number      && time ../openscad_batch/generate_profile.sh ./dice_number.scad
rm -Rf ./dice_hollow_cube && time ../openscad_batch/generate_profile.sh ./dice_hollow_cube.scad
rm -Rf ./dice_hollow_cone && time ../openscad_batch/generate_profile.sh ./dice_hollow_cone.scad
