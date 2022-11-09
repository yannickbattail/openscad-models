#!/bin/bash
#set -x

# required image magick
# $ apt-get install imagemagick

fn=50
nb_image=20
image_size=300,300
delay=20 # delay between images en 100th of seconds

mkdir -p ./anim/
#OPENSCAD=openscad
OPENSCAD="openscad-nightly"
parts_list="cat dino dragon fox panda heart_gem"
for part in $parts_list
do
    echo generating animation images ./anim/${part}XX.png ...
    $OPENSCAD -q -o ./anim/${part}.png -D "part=\"$part\"" -D "animation_rotation=true" -D "\$fn=${fn}" --animate $nb_image --imgsize $image_size ./dice_animal.scad
    echo building animation ./anim/${part}.gif ...
    convert -delay $delay -loop 0 ./anim/${part}*.png ./anim/${part}.gif
    echo cleanup animation images $part ...
    rm ./anim/${part}*.png
done

echo done.
