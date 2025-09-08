#!/bin/bash

time ../openscad_batch/generate_profile.sh -g jpg -p all_support_squareMeter ./CD_solar_oven.scad
time ../openscad_batch/generate_profile.sh -g jpg -p all_debug_squareMeter ./CD_solar_oven.scad
time ../openscad_batch/generate_profile.sh -g jpg -p base ./CD_solar_oven.scad
time ../openscad_batch/generate_profile.sh -g jpg -p support_squareMeter_A1 ./CD_solar_oven.scad

for i in {A..E}
do
    for j in {1..16}
    do
         ../openscad_batch/generate_profile.sh -g stl -p support_squareMeter_${i}${j} ./CD_solar_oven.scad
    done
done
