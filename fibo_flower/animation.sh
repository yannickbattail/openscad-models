#!/bin/bash

# require image magick (for the "convert" command)
# $ apt-get install imagemagick

### configuration

# openscad file name without .scad
scad_file=fibo_flower
# number of images
nb_image=144
# delay between each image in 0.01 seconds (animation speed)
delay=3.333333333
# image size in pixel
img_size=521,512

#### fibo_flower config ###
form="petal" # cone or petal

mkdir ./anim
echo rendering images ${form} ...
openscad -q -o ./anim/${scad_file}.png -D "form=\"${form}\"" -D "animation_rotation=true" --animate ${nb_image} --imgsize ${img_size} ./${scad_file}.scad

echo generating animation ${form} ...
convert -delay ${delay} -loop 0 ./anim/${scad_file}*.png ./${scad_file}.gif

echo cleanup animation ${form} ...
rm -Rf ./anim/
mv ./${scad_file}.gif ./${scad_file}_petal.gif

#### fibo_flower config ###
form="cone" # cone or petal

mkdir ./anim
echo rendering images wriggle ${form} ...
openscad -q -o ./anim/${scad_file}.png -D "form=\"${form}\"" -D "animation_rotation=true" --animate ${nb_image} --imgsize ${img_size} ./${scad_file}.scad

echo generating animation wriggle ${form} ...
convert -delay ${delay} -loop 0 ./anim/${scad_file}*.png ./${scad_file}.gif

echo cleanup animation wriggle ${form} ...
rm -Rf ./anim/
mv ./${scad_file}.gif ./${scad_file}_wriggle_cone.gif

#### fibo_flower config ###
form="cone" # cone or petal

mkdir ./anim
echo rendering images fixed ${form} ...
openscad -q -o ./anim/${scad_file}.png -D "form=\"${form}\"" -D "cone_rotation=false" -D "animation_rotation=true" --animate ${nb_image} --imgsize ${img_size} ./${scad_file}.scad

echo generating animation fixed ${form} ...
convert -delay ${delay} -loop 0 ./anim/${scad_file}*.png ./${scad_file}.gif

echo cleanup animation fixed ${form} ...
rm -Rf ./anim/
mv ./${scad_file}.gif ./${scad_file}_fixed_cone.gif
