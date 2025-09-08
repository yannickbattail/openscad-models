#!/bin/bash
#set -x

# required image magick
# $ apt-get install imagemagick

fn=50
image_size=1024,1024

mkdir -p ./images/
#OPENSCAD=xvfb-run -a openscad
OPENSCAD="xvfb-run -a openscad-nightly"
parts_list="cat dino dragon fox panda heart_gem"
for part in $parts_list
do
    echo generating ./images/part_${part}.png ...
    $OPENSCAD -q -o ./images/part_${part}.png -D "part=\"${part}\"" -D "\$fn=${fn}" --imgsize $image_size ./dice_animal.scad
done

echo generating mosaic ./images/dice_animals.jpg
montage -geometry 256x256+2+2 -tile 3x2 ./images/*.png ./images/dice_animals.jpg

echo done.
