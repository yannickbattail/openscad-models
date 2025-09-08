#!/bin/bash

# require image magick (for the "convert" command)
# $ apt-get install imagemagick

### configuration

# openscad file name without .scad
scad_file=pipe2_examples
# number of images
nb_image=4
# delay between each image in 0.01 seconds (animation speed)
delay=20
# image size in pixel
img_size=521,512

mkdir ./anim
echo rendering images ...
openscad -q -o ./anim/${scad_file}.png -D "animation_rotation=true" --animate ${nb_image} --imgsize ${img_size} ./${scad_file}.scad

echo generating animation ...
convert -delay ${delay} -loop 0 ./anim/${scad_file}*.png ./${scad_file}.gif

echo cleanup animation ...
rm -Rf ./anim/
