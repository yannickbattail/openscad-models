#!/bin/bash
#set -x

POSITIONAL_ARGS=()

config_file=""
only_parameter_set=""
only_generate=""

while [[ $# -gt 0 ]]; do
  case $1 in
    -c|--config-file)
      config_file="$2"
      shift # past argument
      shift # past value
      ;;
    -p|--only-parameter-set)
      only_parameter_set="$2"
      shift # past argument
      shift # past value
      ;;
    -g|--generate)
      only_generate="$2"
      shift # past argument
      shift # past value
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

scad_file=$1

image_dollar_fn="50"
image_size="1024,1024"
image_mosaic_geometry="256x256+2+2" ### https://legacy.imagemagick.org/Usage/montage/
image_mosaic_tile="2x2"

anim_dollar_fn="50"
anim_size="512,512"
anim_nb_image="20"
anim_delay="20" ### delay between images en 100th of seconds

stl_dollar_fn="50"
stl_format="asciistl"
#stl_format="binstl"
stl_render_option=""
#stl_render_option="--enable sort-stl" ### this is an option of openscad-nightly

OPENSCAD="xvfb-run -a openscad"
#OPENSCAD="xvfb-run -a openscad-nightly"

if [[ $config_file != "" ]]
then
    if [[ -f "$config_file" ]]
    then
        echo "loading config file: $config_file"
        . $config_file
    else
        echo "config file: $config_file does not exist" >&2
        exit 1
    fi
fi

scad_file_name=$(basename $scad_file .scad)
scad_file_dir=$(dirname $scad_file)
parameter_file=${scad_file_dir}/${scad_file_name}.json
echo user parameter file: $parameter_file
if [[ ! -f $parameter_file ]]
then
    echo "no parameter file: $parameter_file" >&2
    exit 1
fi
parameter_sets=$( jq -r '.parameterSets | keys[]' ${parameter_file} )

jpg_dir=./${scad_file_name}/images
gif_dir=./${scad_file_name}/gif
stl_dir=./${scad_file_name}/stl

mkdir -p $jpg_dir $gif_dir $stl_dir

generate_jpg() {
    echo generating images ${jpg_dir}/${parameter_set}.png ...
    $OPENSCAD -q -o ${jpg_dir}/${parameter_set}.png --p ${parameter_file} --P ${parameter_set} -D "\$fn=${image_dollar_fn}" --imgsize ${image_size} ${scad_file}
}

generate_gif() {
    echo generating animation images ${gif_dir}/${parameter_set}.png ...
    $OPENSCAD -q -o ${gif_dir}/${parameter_set}.png --p ${parameter_file} --P ${parameter_set} -D "\$fn=${anim_dollar_fn}" -D "animation_rotation=true" --animate ${anim_nb_image} --imgsize ${anim_size} ${scad_file}
    echo building animation ${gif_dir}/${parameter_set}.gif ...
    convert -delay ${anim_delay} -loop 0 ${gif_dir}/${parameter_set}*.png ${gif_dir}/${parameter_set}.gif
    echo cleanup animation images ${parameter_set} ...
    rm ${gif_dir}/${parameter_set}*.png
}

generate_stl() {
      echo generating ${stl_dir}/${parameter_set}.stl ...
      $OPENSCAD -q -o ${stl_dir}/${parameter_set}.stl --p ${parameter_file} --P ${parameter_set} -D "\$fn=${stl_dollar_fn}" --export-format ${stl_format} ${stl_render_option} ${scad_file}
}

generate_mosaic() {
    echo generating mosaic ${jpg_dir}/${scad_file_name}.jpg
    montage -geometry ${image_mosaic_geometry} -tile ${image_mosaic_tile} ${jpg_dir}/*.png ${jpg_dir}/mosaic_${scad_file_name}.jpg
}

generate_all() {
    if [[ $only_generate == "jpg" ]]
    then
      generate_jpg
    elif  [[ $only_generate == "gif" ]]
    then
      generate_gif
    elif  [[ $only_generate == "stl" ]]
    then
      generate_stl
    elif  [[ $only_generate == "" ]]
    then
      generate_jpg
      generate_gif
      generate_stl
    else
      echo "bad usage: option -g or --generate must be one of: jpg,gif,stl" 2>&1
      exit 1
    fi
}

for parameter_set in $parameter_sets ; do
    if [[ $only_parameter_set == "" ]]
    then
        generate_all
    elif  [[ $only_parameter_set == "$parameter_set" ]]
    then
        generate_all
    fi
done

if [[ $only_generate == "jpg" ]]
then
    generate_mosaic
elif  [[ $only_generate == "" ]]
then
        generate_mosaic
fi

echo done.
