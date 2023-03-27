#!/bin/bash


rm -Rf ./CD_solar_oven/ support_squareMeter_stl.zip

for i in {A..E}
do
    for j in {1..16}
    do
         ../openscad_batch/generate_profile.sh -g stl -p support_squareMeter_${i}${j} ./CD_solar_oven.scad
    done
done

../openscad_batch/generate_profile.sh -g stl -p base ./CD_solar_oven.scad

../openscad_batch/generate_profile.sh -g jpg -p all_support_squareMeter ./CD_solar_oven.scad
../openscad_batch/generate_profile.sh -g jpg -p all_debug_squareMeter ./CD_solar_oven.scad
../openscad_batch/generate_profile.sh -g jpg -p base ./CD_solar_oven.scad
../openscad_batch/generate_profile.sh -g jpg -p support_squareMeter_A1 ./CD_solar_oven.scad
../openscad_batch/generate_profile.sh -g jpg -p stl ./CD_solar_oven.scad

zip -r support_squareMeter_stl.zip ./CD_solar_oven/

rm ./CD_solar_oven/3D/support_squareMeter_*

../openscad_batch/generate_profile.sh -g stl -p support_squareMeter_A1 ./CD_solar_oven.scad
