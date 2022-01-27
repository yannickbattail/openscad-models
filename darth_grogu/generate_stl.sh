#!/bin/bash

mkdir -p ./stl/

# horns_list="horn_n horn_o horn_s horn_w horn_e horn_nw horn_ne horn_sw horn_se"
# for horn in $horns_list
# do
#     echo generating $horn ...
#     openscad -q -o ./stl/${horn}.stl -D "horn=\"$horn\"" ./horns_display.scad # &
# done

echo generating darth_grogu.stl ...
openscad -q -o ./darth_grogu.stl ./darth_grogu.scad # &

echo generating darth_grogu.png ...
openscad -q -o ./darth_grogu.png ./darth_grogu.scad # &
