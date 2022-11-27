#!/bin/bash
#set -x
. ./colors.sh
POSITIONAL_ARGS=()

config_file=""
only_parameter_set=""
only_generate=""

usage() {
    echo -ne $IBlue
    echo "Usage: $0 [OPTION]... OPENSCAD_FILE" >&2
    echo "-c, --config-file configuration_file      specify another configuration file thant the default OPENSCAD_FILE.conf." >&2
    echo "-p, --only-parameter-set parameter-set    parameter-set is one the parameter-set name present in the file." >&2
    echo "-g, --generate only_generate              only_generate must be one of jpg,gif,stl. bay default it will generate all." >&2
    echo "OPENSCAD_FILE                             path of the openscad file." >&2
    echo -ne $On_Reset
}

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
      usage
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

### default configuration

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

### end configuration

scad_file=$1

if [[ $scad_file == "" ]]
then
    echo -e "${IRed}openscad file $scad_file does not exist.${On_Reset}" >&2
    usage
    exit 1
fi

if [[ ! -f $scad_file ]]
then
    echo -e "${IRed}openscad file $scad_file does not exist.${On_Reset}" >&2
    exit 1
fi

scad_file_name=$(basename $scad_file .scad)
scad_file_dir=$(dirname $scad_file)

if [[ $config_file == "" ]]
then
    config_file=${scad_file_dir}/${scad_file_name}.conf
    if [[ -f "$config_file" ]]
    then
        echo -e "${IGreen}loading config file: $config_file${On_Reset}"
        . $config_file
    else
        echo -e "${IGreen}creating default config file: $config_file${On_Reset}"
        
cat << EOF > $config_file
####### configuration file for $0 #######
## it will be sourced by $0

#image_dollar_fn="${image_dollar_fn}"
#image_size="${image_size}"
### for image_mosaic_geometry see https://legacy.imagemagick.org/Usage/montage/
#image_mosaic_geometry="${image_mosaic_geometry}"
#image_mosaic_tile="${image_mosaic_tile}"

#anim_dollar_fn="${anim_dollar_fn}"
#anim_size="${anim_size}"
#anim_nb_image="${anim_nb_image}"
### delay between images en 100th of seconds
#anim_delay="${anim_delay}"

#stl_dollar_fn="${stl_dollar_fn}"
#stl_format="asciistl"
#stl_format="binstl"
#stl_render_option="${stl_render_option}"
### this option is only available on openscad-nightly
#stl_render_option="--enable sort-stl"

#OPENSCAD="xvfb-run -a openscad"
#OPENSCAD="xvfb-run -a openscad-nightly"

EOF

    fi
else
    if [[ -f "$config_file" ]]
    then
        echo -e "${IGreen}loading config file: $config_file${On_Reset}"
        . $config_file
    else
        echo  -e "${IRed}config file: $config_file does not exist.${On_Reset}" >&2
        exit 1
    fi
fi

parameter_file=${scad_file_dir}/${scad_file_name}.json
if [[ ! -f $parameter_file ]]
then
    echo -e "${IRed}no parameter file: $parameter_file${On_Reset}" >&2
    exit 1
fi
echo -e "${IGreen}use parameter file: $parameter_file${On_Reset}"
parameter_sets=$( jq -r '.parameterSets | keys[]' ${parameter_file} )

jpg_dir=./${scad_file_name}/images
gif_dir=./${scad_file_name}/gif
stl_dir=./${scad_file_name}/stl

mkdir -p $jpg_dir $gif_dir $stl_dir

generate_jpg() {
    echo -e "${IGreen}generating images ${jpg_dir}/${parameter_set}.png ...${On_Reset}"
    $OPENSCAD -q -o ${jpg_dir}/${parameter_set}.png --p ${parameter_file} --P ${parameter_set} -D "\$fn=${image_dollar_fn}" --imgsize ${image_size} ${scad_file}
}

generate_gif() {
    echo -e "${IGreen}generating animation images ${gif_dir}/${parameter_set}.png ...${On_Reset}"
    $OPENSCAD -q -o ${gif_dir}/${parameter_set}.png --p ${parameter_file} --P ${parameter_set} -D "\$fn=${anim_dollar_fn}" -D "animation_rotation=true" --animate ${anim_nb_image} --imgsize ${anim_size} ${scad_file}
    echo -e "${IGreen}building animation ${gif_dir}/${parameter_set}.gif ...${On_Reset}"
    convert -delay ${anim_delay} -loop 0 ${gif_dir}/${parameter_set}*.png ${gif_dir}/${parameter_set}.gif
    echo -e "${IGreen}cleanup animation images ${parameter_set} ...${On_Reset}"
    rm ${gif_dir}/${parameter_set}*.png
}

generate_stl() {
      echo -e "${IGreen}generating ${stl_dir}/${parameter_set}.stl ...${On_Reset}"
      $OPENSCAD -q -o ${stl_dir}/${parameter_set}.stl --p ${parameter_file} --P ${parameter_set} -D "\$fn=${stl_dollar_fn}" --export-format ${stl_format} ${stl_render_option} ${scad_file}
}

generate_mosaic() {
    echo -e "${IGreen}generating mosaic ${jpg_dir}/${scad_file_name}.jpg ...${On_Reset}"
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
      echo -e "${IRed}bad usage: option -g or --generate must be one of: jpg,gif,stl${On_Reset}" 2>&1
      usage
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

echo -e "${IGreen}Done.${On_Reset}"
