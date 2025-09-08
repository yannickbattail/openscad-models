#!/bin/bash
#set -x

scad_file=$1

image_dollar_fn=50
image_size=1024,1024

anim_dollar_fn=50
anim_size=512,512
anim_nb_image=20
anim_delay=20 # delay between images en 100th of seconds

stl_dollar_fn=50
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

jpg_dir=./${scad_file_name}/images
gif_dir=./${scad_file_name}/gif
stl_dir=./${scad_file_name}/stl

mkdir -p $jpg_dir $gif_dir $stl_dir
for parameter_set in $parameter_sets ; do
    
    echo generating images ${jpg_dir}/${parameter_set}.png ...
    $OPENSCAD -q -o ${jpg_dir}/${parameter_set}.png --p ${parameter_file} --P ${parameter_set} -D "\$fn=${image_dollar_fn}" --imgsize ${image_size} ${scad_file}
    
    echo generating animation images ${gif_dir}/${parameter_set}.png ...
    $OPENSCAD -q -o ${gif_dir}/${parameter_set}.png --p ${parameter_file} --P ${parameter_set} -D "\$fn=${anim_dollar_fn}" -D "animation_rotation=true" --animate ${anim_nb_image} --imgsize ${anim_size} ${scad_file}
    echo building animation ${gif_dir}/${parameter_set}.gif ...
    convert -delay ${anim_delay} -loop 0 ${gif_dir}/${parameter_set}*.png ${gif_dir}/${parameter_set}.gif
    echo cleanup animation images ${parameter_set} ...
    rm ${gif_dir}/${parameter_set}*.png
    
    echo generating ${stl_dir}/${parameter_set}.stl ...
    $OPENSCAD -q -o ${stl_dir}/${parameter_set}.stl --p ${parameter_file} --P ${parameter_set} -D "\$fn=${stl_dollar_fn}" --export-format ${stl_format} ${stl_render_option} ${scad_file}
    
done

echo generating mosaic ${jpg_dir}/${scad_file_name}.jpg
montage -geometry 256x256+2+2 -tile 3x3 ${jpg_dir}/*.png ${jpg_dir}/${scad_file_name}.jpg

echo done.
