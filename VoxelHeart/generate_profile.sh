#!/bin/bash
#set -x

scad_file=./VoxelHeart.scad

image_dollar_fn=10
image_size=1024,1024

anim_dollar_fn=8
anim_size=512,512
anim_nb_image=20
anim_delay=20 # delay between images en 100th of seconds

stl_dollar_fn=8
stl_format=asciistl
#stl_format=binstl
stl_render_option=
#stl_render_option="--enable sort-stl" 

OPENSCAD="xvfb-run -a openscad"
#OPENSCAD="xvfb-run -a openscad-nightly"

scad_file_name=$(basename $scad_file .scad)
scad_file_dir=$(dirname $scad_file)
parameter_file=${scad_file_dir}/${scad_file_name}.json
echo $parameter_file
if [ ! -f $parameter_file ]; then
    echo "no parameter file: $parameter_file" >&2
    exit 1
fi
parameter_sets=$( jq -r '.parameterSets | keys[]' ${parameter_file} )

mkdir -p ./images/ ./anim/ ./stl/
for parameter_set in $parameter_sets ; do
  
    echo generating images ./images/${parameter_set}.png ...
    $OPENSCAD -q -o ./images/${parameter_set}.png --p ${parameter_file} --P ${parameter_set} -D "\$fn=${image_dollar_fn}" --imgsize ${image_size} ${scad_file}
    
    echo generating animation images ./anim/${parameter_set}.png ...
    $OPENSCAD -q -o ./anim/${parameter_set}.png --p ${parameter_file} --P ${parameter_set} -D "\$fn=${anim_dollar_fn}" -D "animation_rotation=true" --animate ${anim_nb_image} --imgsize ${anim_size} ${scad_file}
    echo building animation ./anim/${parameter_set}.gif ...
    convert -delay ${anim_delay} -loop 0 ./anim/${parameter_set}*.png ./anim/${parameter_set}.gif
    echo cleanup animation images ${parameter_set} ...
    rm ./anim/${parameter_set}*.png
    
    echo generating ./stl/${parameter_set}.stl ...
    $OPENSCAD -q -o ./stl/${parameter_set}.stl --p ${parameter_file} --P ${parameter_set} -D "\$fn=${stl_dollar_fn}" --export-format ${stl_format} ${stl_render_option} ${scad_file}
    
done

echo generating mosaic ./images/dice_animals.jpg
montage -geometry 256x256+2+2 -tile 2x2 ./images/*.png ./images/dice_animals.jpg

echo done.
