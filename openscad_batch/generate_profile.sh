#!/bin/bash
#set -x

# colors
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
IReset='\e[0m'            # Reset colors

POSITIONAL_ARGS=()

config_file=""
only_parameter_set=""
only_generate=""

usage() {
    echo -ne $IBlue
    echo "Usage: $0 [OPTION]... OPENSCAD_FILE" >&2
    echo "-c, --config-file configuration_file      specify another configuration file thant the default OPENSCAD_FILE.conf." >&2
    echo "-p, --only-parameter-set parameter-set    parameter-set is one the parameter-set name present in the file." >&2
    echo "-g, --generate only_generate              only_generate must be one of jpg,gif,webp,stl. bay default it will generate all." >&2
    echo "OPENSCAD_FILE                             path of the openscad file." >&2
    echo "" >&2
    echo "Requirements: command 'jq' and imagemagick for gif and mosaic generation"
    echo -ne $IReset
}

echo_info() {
    echo -ne $IGreen
    echo $@
    echo -ne $IReset
}

echo_warn() {
    echo -ne IPurple
    echo $@
    echo -ne $IReset
}

echo_error() {
    echo -ne $IRed >&2
    echo $@ >&2
    usage
    echo -ne $IReset >&2
    exit 1
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
      echo_error "unknown option: $1"
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

if ! command -v jq &> /dev/null
then
    echo_error "The command jq is not installed."
fi

if [[ $scad_file == "" ]]
then
    echo_error "openscad file $scad_file does not exist."
    exit 1
fi
if [[ ! -f $scad_file ]]
then
    echo_error "openscad file $scad_file does not exist."
fi

scad_file_name=$(basename $scad_file .scad)
scad_file_dir=$(dirname $scad_file)

if [[ $config_file == "" ]]
then
    config_file=${scad_file_dir}/${scad_file_name}.conf
    if [[ -f "$config_file" ]]
    then
        echo_info "loading config file: $config_file"
        . $config_file
    else
        echo_info "creating default config file: $config_file"
        
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
        echo_info "loading config file: $config_file"
        . $config_file
    else
        echo_error "config file: $config_file does not exist."
    fi
fi

parameter_file=${scad_file_dir}/${scad_file_name}.json
if [[ ! -f $parameter_file ]]
then
    echo_error "no parameter file: $parameter_file"
fi
echo -e "${IGreen}use parameter file: $parameter_file${On_Reset}"
parameter_sets=$( jq -r '.parameterSets | keys[]' ${parameter_file} )

jpg_dir=./${scad_file_name}/images
anim_dir=./${scad_file_name}/anim
gif_dir=./${scad_file_name}/gif
webp_dir=./${scad_file_name}/webp
stl_dir=./${scad_file_name}/stl

prepare_jpg() {
    mkdir -p $jpg_dir
    if ! command -v montage &> /dev/null
    then
        echo_error "the command 'montage' in not found, mosaics will not be generated, install imagemagick."
    fi
}

prepare_gif() {
    mkdir -p $gif_dir $anim_dir
    if ! command -v convert &> /dev/null
    then
        echo_error "the command 'convert' in not found, gif will not be generated, install imagemagick."
        exit 1
    fi
}

prepare_webp() {
    mkdir -p $webp_dir $anim_dir
    if ! command -v img2webp &> /dev/null
    then
        echo_error "the command 'img2webp' in not found, webp will not be generated, install webp."
        exit 1
    fi
}

prepare_stl() {
    mkdir -p $stl_dir
}

generate_jpg() {
    echo_info "generating images ${jpg_dir}/${parameter_set}.png ..."
    $OPENSCAD -q -o ${jpg_dir}/${parameter_set}.png --p ${parameter_file} --P ${parameter_set} -D "\$fn=${image_dollar_fn}" --imgsize ${image_size} ${scad_file}
}

generate_anim() {
    echo_info "generating animation images ${anim_dir}/${parameter_set}.png ..."
    $OPENSCAD -q -o ${anim_dir}/${parameter_set}.png --p ${parameter_file} --P ${parameter_set} -D "\$fn=${anim_dollar_fn}" -D "animation_rotation=true" --animate ${anim_nb_image} --imgsize ${anim_size} ${scad_file}  
}
clean_anim() {
    echo_info "cleanup animation images ${parameter_set} ..."
    rm ${anim_dir}/${parameter_set}*.png
}

generate_gif() {
    echo_info "building animation ${gif_dir}/${parameter_set}.gif ..."
    convert -delay ${anim_delay} -loop 0 ${anim_dir}/${parameter_set}*.png ${gif_dir}/${parameter_set}.gif
}

generate_webp() {
    echo_info "building animation ${webp_dir}/${parameter_set}.webp ..."
    img2webp -o ${webp_dir}/${parameter_set}.webp -d ${anim_delay}0 -loop 0 ${anim_dir}/${parameter_set}*.png 
}

generate_stl() {
      echo_info "generating ${stl_dir}/${parameter_set}.stl ..."
      $OPENSCAD -q -o ${stl_dir}/${parameter_set}.stl --p ${parameter_file} --P ${parameter_set} -D "\$fn=${stl_dollar_fn}" --export-format ${stl_format} ${stl_render_option} ${scad_file}
}

generate_mosaic() {
    echo_info "generating mosaic ${jpg_dir}/${scad_file_name}.jpg ..."
    montage -geometry ${image_mosaic_geometry} -tile ${image_mosaic_tile} ${jpg_dir}/*.png ${jpg_dir}/mosaic_${scad_file_name}.jpg
}

if [[ $only_generate == "jpg" ]]
then
    prepare_jpg
elif  [[ $only_generate == "gif" ]]
then
    prepare_gif
elif  [[ $only_generate == "webp" ]]
then
    prepare_webp
elif  [[ $only_generate == "stl" ]]
then
    prepare_stl
elif  [[ $only_generate == "" ]]
then
    prepare_jpg
    prepare_gif
    prepare_webp
    prepare_stl
else
  echo_error "bad usage: option -g or --generate must be one of: jpg,gif,webp,stl"
fi

generate_all() {
    if [[ $only_generate == "jpg" ]]
    then
      generate_jpg
    elif  [[ $only_generate == "gif" ]]
    then
      generate_anim
      generate_gif
      clean_anim
    elif  [[ $only_generate == "webp" ]]
    then
      generate_anim
      generate_webp
      clean_anim
    elif  [[ $only_generate == "stl" ]]
    then
      generate_stl
    elif  [[ $only_generate == "" ]]
    then
      generate_jpg
      generate_anim
      generate_gif
      generate_webp
      clean_anim
      generate_stl
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

echo_info "Done."