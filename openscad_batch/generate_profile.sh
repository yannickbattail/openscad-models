#!/bin/bash
#set -x

################################################################################
# License: GPL-3.0
# source and doc:
# https://github.com/yannickbattail/openscad-models/tree/main/openscad_batch
################################################################################

# Background
On_Black='\033[40m' On_Red='\033[41m' On_Green='\033[42m' On_Yellow='\033[43m' On_Blue='\033[44m' On_Purple='\033[45m' On_Cyan='\033[46m' On_White='\033[47m' 
# High Intensity
IBlack='\033[0;90m' IRed='\033[0;91m' IGreen='\033[0;92m' IYellow='\033[0;93m' IBlue='\033[0;94m' IPurple='\033[0;95m' ICyan='\033[0;96m' IWhite='\033[0;97m' 
# Bold High Intensity
BIBlack='\033[1;90m' BIRed='\033[1;91m' BIGreen='\033[1;92m' BIYellow='\033[1;93m' BIBlue='\033[1;94m' BIPurple='\033[1;95m' BICyan='\033[1;96m' BIWhite='\033[1;97m' 
# High Intensity backgrounds
On_IBlack='\033[0;100m' On_IRed='\033[0;101m' On_IGreen='\033[0;102m' On_IYellow='\033[0;103m' On_IBlue='\033[0;104m' On_IPurple='\033[0;105m' On_ICyan='\033[0;106m' On_IWhite='\033[0;107m' 
On_Reset='\e[0m'
#BRIGHT=$(tput bold) NORMAL=$(tput sgr0) BLINK=$(tput blink) REVERSE=$(tput smso) UNDERLINE=$(tput smul)


POSITIONAL_ARGS=()

config_file=""
only_parameter_set=""
only_generate=""
debug="0"
init_project="false"
use_f3d="false"

usage() {
    echo -ne "$IBlue"
    echo "Script for generating 3D files, images and animations from an openscad file and a parameter file." >&2
    echo "Usage: $0 [OPTION]... OPENSCAD_FILE" >&2
    echo "-c, --config-file configuration_file      specify another configuration file than the default \${OPENSCAD_FILE}.conf." >&2
    echo "-p, --only-parameter-set parameter-set    parameter-set is one the parameter-set name present in the file." >&2
    echo "-g, --generate only_generate              only_generate must be one or multiple separated by ',' of these values: jpg,gif,webp,stl,obj,3mf,wrl,off,amf,conf. By default it will generate jpg,gif,stl." >&2
    echo "--init                                    Initialize files for a new project" >&2
    echo "--f3d                                     use f3d for images generation" >&2
    echo "--debug what_to_debug                     debug mode: what_to_debug must be one or multiple separated by ',' of these values: CMD,OUT" >&2
    echo "OPENSCAD_FILE                             path of the openscad file." >&2
    echo "" >&2
    echo "Requirements: command 'jq', 'webp' and 'imagemagick' for gif and mosaic generation"
    echo -ne "$IReset"
}

echo_log() {
    echo -ne "$ICyan"
    echo "$@"
    echo -ne "$IReset"
}

echo_info() {
    echo -ne "$IGreen"
    echo "$@"
    echo -ne "$IReset"
}

echo_warn() {
    echo -ne "$IPurple"
    echo "$@"
    echo -ne "$IReset"
}

echo_error() {
    echo -ne "$IRed" >&2
    echo "$@" >&2
    usage
    echo -ne "$IReset" >&2
    exit 1
}

exec_check () {
  if [[ $debug == *"CMD"* ]]
  then
    echo_log "RUN COMMAND: $@"
  fi
  "$@"
  local ret=$?
  if [[ $ret != "0" ]]
  then
      echo -e "${IRed}Execution fail, return code is $ret for command: $*${IReset}" >&2
      exit $ret
  fi
}

prepare_jpg() {
    mkdir -p "$jpg_dir"
    if ! command -v montage &> /dev/null
    then
        echo_error "the command 'montage' in not found, mosaics will not be generated, install imagemagick."
    fi
}

prepare_gif() {
    mkdir -p "$gif_dir" "$anim_dir"
    if ! command -v convert &> /dev/null
    then
        echo_error "the command 'convert' in not found, gif will not be generated, install imagemagick."
        exit 1
    fi
}

prepare_webp() {
    mkdir -p "$webp_dir" "$anim_dir"
    if ! command -v img2webp &> /dev/null
    then
        echo_error "the command 'img2webp' in not found, webp will not be generated, install webp."
        exit 1
    fi
}

prepare_m3D() {
    mkdir -p "$m3D_dir"
}

generate_jpg() {
    echo_info "generating images ${jpg_dir}/${parameter_set}.png ..."
    if [[ $use_f3d == "true" ]]
    then 
        exec_check f3d ${f3d_debug} --resolution ${image_size} ${f3d_colors} -q -a -t --axis=false --grid=false --filename=false ${f3d_material} ${f3d_hdri} --output "${jpg_dir}/${parameter_set}.png" "${m3D_dir}/${parameter_set}.stl"
    else
        exec_check $OPENSCAD ${openscad_debug} -o "${jpg_dir}/${parameter_set}.png" --p "${parameter_file}" --P "${parameter_set}" -D "\$fn=${image_dollar_fn}" --imgsize "${image_size}" ${m3D_render_option} "${scad_file}"
    fi
}

generate_anim() {
    if [[ $use_f3d == "true" ]]
    then
        echo_info "generating animation images ${anim_dir}/${parameter_set}.png with f3d"
        imageEveryXDegree=$((360 / anim_nb_image))
        for i in $(seq -f "%03g" 1 $imageEveryXDegree 359);
        do
            exec_check f3d  ${f3d_debug} --resolution ${anim_size}  ${f3d_colors} -q -a -t --axis=false --grid=false --filename=false --camera-azimuth-angle=$i ${f3d_material} ${f3d_hdri} --output "${anim_dir}/${parameter_set}_${i}.png" "${m3D_dir}/${parameter_set}.stl"
            echo -n .
        done
        echo
    else
      echo_info "generating animation images ${anim_dir}/${parameter_set}.png"
        exec_check $OPENSCAD ${openscad_debug} -o "${anim_dir}/${parameter_set}.png" --p "${parameter_file}" --P "${parameter_set}" -D "\$fn=${anim_dollar_fn}" -D "animation_rotation=true" --animate "${anim_nb_image}" --imgsize "${anim_size}" ${m3D_render_option} "${scad_file}"  
    fi
}
clean_anim() {
    echo_info "cleanup animation images ${parameter_set} ..."
    if [[ $anim_keep_images != "true" ]]
    then
        rm "${anim_dir}"/"${parameter_set}"*.png
    fi
}

generate_gif() {
    echo_info "building animation ${gif_dir}/${parameter_set}.gif ..."
    exec_check convert ${imagemagick_debug} -delay ${anim_delay} -loop 0 "${anim_dir}"/"${parameter_set}"*.png "${gif_dir}/${parameter_set}.gif"
}

generate_webp() {
    echo_info "building animation ${webp_dir}/${parameter_set}.webp ..."
    exec_check img2webp ${img2webp_debug} -o "${webp_dir}/${parameter_set}.webp" -d "${anim_delay}0" -loop 0 "${anim_dir}"/"${parameter_set}"*.png
}

generate_m3D() {
    extension=$1
    echo_info "generating ${m3D_dir}/${parameter_set}.${extension} ..."
    if [[ ${extension} == "stl" ]]; then
        exec_check $OPENSCAD ${openscad_debug} -o "${m3D_dir}/${parameter_set}.${extension}" --p "${parameter_file}" --P "${parameter_set}" -D "\$fn"="${m3D_dollar_fn}" --export-format "${stl_format}" ${m3D_render_option} "${scad_file}"
    else
        exec_check $OPENSCAD ${openscad_debug} -o "${m3D_dir}/${parameter_set}.${extension}" --p "${parameter_file}" --P "${parameter_set}" -D "\$fn"="${m3D_dollar_fn}" ${m3D_render_option} "${scad_file}"
    fi
}

generate_mosaic() {
    echo_info "generating mosaic ${jpg_dir}/${scad_file_name}.jpg ..."
    exec_check montage ${imagemagick_debug} -geometry "${image_mosaic_geometry}" -tile "${image_mosaic_tile}" "${jpg_dir}/"*.png "${jpg_dir}/mosaic_${scad_file_name}.jpg"
}

generate_sample_scad() {
  if [[ -f "$scad_file" ]]
  then
    echo_error "Cannot create new project file: ${scad_file}, file already exists."
  else
    cat << EOF > "$scad_file"

// part to generate
part = "ball"; // [all, ball, stick]

// size of the model
size=50; // [10:5:100]

/* [Animation] */
// resolution
\$fn=10;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
\$vpt = is_animated?[0, 0, 0]:\$vpt;
\$vpr = is_animated?[60, 0, animation_rotation?(365 * \$t):45]:\$vpr;  // animation rotate around the object
\$vpd = is_animated?200:\$vpd;

if (part == "ball") {
    ball(size);
} else if (part == "stick") {
    stick(size);
} else {
    ball(size);
    stick(size);
}

module stick(size) {
    color("green") rotate([0, 90, 0]) cylinder(d=size/2, h=size * 1.25, center=true);
}

module ball(size) {
    difference() {
        sphere(d=size);
        cylinder(d=size/2, h=size * 1.25, center=true);
        #rotate([90, 0, 0]) cylinder(d=size/2, h=size * 1.25, center=true);
        stick(size);
    }
}
EOF
  echo_info "file $scad_file generated"
  fi
}

generate_sample_preset() {
  cat << EOF > "$parameter_file"
{
    "parameterSets": {
        "all_20": {
            "part": "all",
            "size": "20"
        },
        "ball_50": {
            "part": "ball",
            "size": "50"
        },
        "stick_50": {
            "part": "stick",
            "size": "50"
        }
    },
    "fileFormatVersion": "1"
}
EOF
  echo_info "file $parameter_file generated"
}

generate_conf() {
  cat << EOF > "$config_file"
####### configuration file for generate_profile.sh #######
## it will be sourced by generate_profile.sh

#### image generation ####
## value of the \$fn variable (3d model resolution) for image generation 
#image_dollar_fn="${image_dollar_fn}"
## image size
#image_size="${image_size}"
### tile image dimension and border. see https://legacy.imagemagick.org/Usage/montage/
#image_mosaic_geometry="${image_mosaic_geometry}"
## mosaic disposition : number of tile its composition. if it 2x2, and you have 5 images, an other mosaic will be created.
#image_mosaic_tile="${image_mosaic_tile}"

#### animation (gif or webp) generation ####
## value of the \$fn variable (3d model resolution) for animation generation 
#anim_dollar_fn="${anim_dollar_fn}"
## animation image size
#anim_size="${anim_size}"
## number of images in the animation
#anim_nb_image="${anim_nb_image}"
### delay between images en 100th of seconds
#anim_delay="${anim_delay}"
## keep of images in the animation in the folder "anim"
#anim_keep_images="true"

#### model3D  generation (stl, obj, 3mf, off, wrl or amf) ####
## value of the \$fn variable (3d model resolution) for 3D model generation 
#m3D_dollar_fn="${m3Ddollar_fn}"
## 3D rendering options
#m3D_render_option="${m3D_render_option}"
## this option is only available on openscad-nightly.
#m3D_render_option="--enable sort-stl"

## For a diffable stl, use stl_format="asciistl" and stl_render_option="--enable sort-stl"
## stl_format can be asciistl or binstl
#stl_format="asciistl"
#stl_format="binstl"

#### the openscad command ####
## use headless X server, for running the script in a machine without X server (ex: CI scripts)  
#OPENSCAD="xvfb-run -a openscad"
## use nightly build
#OPENSCAD="openscad-nightly"

EOF
  echo_info "file $config_file generated"
}

prepare_all() {
  if [[ $only_generate == *"jpg"* ]]; then
    prepare_jpg
    prepare_m3D
  fi
  if [[ $only_generate == *"gif"* ]]; then
    prepare_gif
    prepare_m3D
  fi
  if [[ $only_generate == *"webp"* ]]; then
    prepare_webp
    prepare_m3D
  fi
  if [[ $only_generate == *"stl"* ]]; then
    prepare_m3D
  fi
  if [[ $only_generate == *"obj"* ]]; then
    prepare_m3D
  fi
  if [[ $only_generate == *"3mf"* ]]; then
    prepare_m3D
  fi
  if [[ $only_generate == *"wrl"* ]]; then
    prepare_m3D
  fi
  if [[ $only_generate == *"off"* ]]; then
    prepare_m3D
  fi
  if [[ $only_generate == *"amf"* ]]; then
    prepare_m3D
  fi
  if [[ $only_generate == *"conf"* ]]; then
    touch "$config_file"
  fi
  if [[ $only_generate == "" ]]; then
    prepare_jpg
    prepare_gif
#     prepare_webp
    prepare_m3D
  fi
}

generate_all_scad() {
    if  [[ $only_generate == "" || $only_generate == *"gif"* || $only_generate == *"webp"* ]]
    then
      generate_anim
    fi
    if [[ $only_generate == *"jpg"* ]]
    then
      generate_jpg
    fi
    if  [[ $only_generate == *"gif"* ]]
    then
      generate_gif
    fi
    if  [[ $only_generate == *"webp"* ]]
    then
      generate_webp
    fi
    if  [[ $only_generate == *"stl"* ]]
    then
      generate_m3D stl
    fi
    if  [[ $only_generate == *"obj"* ]]
    then
      generate_m3D obj
    fi
    if  [[ $only_generate == *"3mf"* ]]
    then
      generate_m3D 3mf
    fi
    if  [[ $only_generate == *"wrl"* ]]
    then
      generate_m3D wrl
    fi
    if  [[ $only_generate == *"off"* ]]
    then
      generate_m3D off
    fi
    if  [[ $only_generate == *"amf"* ]]
    then
      generate_m3D amf
    fi
    if  [[ $only_generate == *"conf"* ]]
    then
      generate_conf
    fi
    if  [[ $only_generate == "" ]]
    then
#       generate_webp
      generate_m3D stl
#       generate_m3D obj
#       generate_m3D 3mf
#       generate_m3D wrl
#       generate_m3D off
#       generate_m3D amf
      generate_jpg
      generate_gif
    fi
    if  [[  $only_generate == "" || $only_generate == *"gif"* || $only_generate == *"webp"* ]]
    then
      clean_anim
    fi
}

generate_all_f3d() {
    if  [[ $only_generate == *"stl"* ||  $only_generate == *"jpg"* || $only_generate == *"gif"* || $only_generate == *"webp"* ]]
    then
      generate_m3D stl
    fi
    if  [[ $only_generate == *"obj"* ]]
    then
      generate_m3D obj
    fi
    if  [[ $only_generate == *"3mf"* ]]
    then
      generate_m3D 3mf
    fi
    if  [[ $only_generate == *"wrl"* ]]
    then
      generate_m3D wrl
    fi
    if  [[ $only_generate == *"off"* ]]
    then
      generate_m3D off
    fi
    if  [[ $only_generate == *"amf"* ]]
    then
      generate_m3D amf
    fi
    if  [[ $only_generate == "" || $only_generate == *"gif"* || $only_generate == *"webp"* ]]
    then
      generate_anim
    fi
    if [[ $only_generate == *"jpg"* ]]
    then
      generate_jpg
    fi
    if  [[ $only_generate == *"gif"* ]]
    then
      generate_gif
    fi
    if  [[ $only_generate == *"webp"* ]]
    then
      generate_webp
    fi
    if  [[ $only_generate == *"conf"* ]]
    then
      generate_conf
    fi
    if  [[ $only_generate == "" ]]
    then
#       generate_webp
      generate_m3D stl
#       generate_m3D obj
#       generate_m3D 3mf
#       generate_m3D wrl
#       generate_m3D off
#       generate_m3D amf
      generate_jpg
      generate_gif
    fi
    if  [[  $only_generate == "" || $only_generate == *"gif"* || $only_generate == *"webp"* ]]
    then
      clean_anim
    fi
}

generate_all() {
    if [[ $use_f3d == "true" ]]
    then
        generate_all_f3d
    else
        generate_all_scad
    fi
}

generate_project() {
  scad_file_name=$(basename "$scad_file" .scad)
  scad_file_dir=$(dirname "$scad_file")
  generate_sample_scad
  parameter_file=${scad_file_dir}/${scad_file_name}.json
  generate_sample_preset
  config_file=${scad_file_dir}/${scad_file_name}.conf
  generate_conf
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
    --init)
      init_project="true"
      shift # past argument
      ;;
    --f3d)
      use_f3d="true"
      shift # past argument
      ;;
    --debug)
      debug="$2"
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
image_mosaic_geometry="256x256+2+2"
image_mosaic_tile="2x2"

anim_dollar_fn="50"
anim_size="512,512"
anim_nb_image="20"
anim_delay="20"
anim_keep_images="false"

m3D_dollar_fn="50"
stl_format="asciistl"
m3D_render_option=""

f3d_colors="--bg-color 0.9,0.8,1 --color 0.3,0.3,1"
f3d_material="--roughness=0.5 --metallic=1"
#f3d_hdri="--hdri-skybox --hdri-ambient --hdri-file=./tests/sky.jpg" # -u
f3d_hdri=""

OPENSCAD="openscad"

### end configuration

scad_file=$1

if ! command -v jq &> /dev/null
then
    echo_error "The command jq is not installed."
fi

if [[ $use_f3d == "true" ]] && ! command -v f3d &> /dev/null
then
    echo_error "The command f3d is not installed."
fi

if [[ $init_project == "true" ]]
then
  generate_project
  echo_info "Done."
  exit 0
fi

if [[ $scad_file == "" ]]
then
    echo_error "no openscad file specified."
    exit 1
fi
if [[ ! -f $scad_file ]]
then
    echo_error "openscad file $scad_file does not exist."
fi

scad_file_name=$(basename "$scad_file" .scad)
scad_file_dir=$(dirname "$scad_file")


if [[ $config_file != "" ]]
then
    if [[ ! -f "$config_file" ]]
    then
        echo_error "config file: $config_file does not exist."
    fi
fi

if [[ $config_file == "" ]]
then
    config_file=${scad_file_dir}/${scad_file_name}.conf
fi

if [[ -f "$HOME/.config/generate_profile.conf" ]]
then
    echo_info "loading user config file: $HOME/.config/generate_profile.conf"
    source "$HOME/.config/generate_profile.conf"
else
    echo_info "no user config file: $HOME/.config/generate_profile.conf"
fi

if [[ -f "$config_file" ]]
then
    echo_info "loading config file: $config_file"
    source "$config_file"
else
    echo_info "no config file loaded"
fi

parameter_file=${scad_file_dir}/${scad_file_name}.json
if [[ ! -f $parameter_file ]]
then
    echo_error "no parameter file: $parameter_file"
fi
echo -e "${IGreen}use parameter file: $parameter_file${IReset}"
parameter_sets=$( jq -r '.parameterSets | keys[]' "${parameter_file}" )

openscad_debug="-q"
f3d_debug="--verbose=error"
imagemagick_debug=""
img2webp_debug=""
if [[ $debug == *"OUT"* ]]
then
    openscad_debug=""
    f3d_debug="--verbose=info" # {debug, info, warning, error, quiet}
    imagemagick_debug="-verbose"
    img2webp_debug="-v"
fi

jpg_dir=./${scad_file_name}/images
anim_dir=./${scad_file_name}/anim
gif_dir=./${scad_file_name}/gif
webp_dir=./${scad_file_name}/webp
m3D_dir=./${scad_file_name}/3D

prepare_all

for parameter_set in $parameter_sets ; do
    if [[ $only_parameter_set == "" ]]
    then
        generate_all
    elif  [[ $only_parameter_set == "$parameter_set" ]]
    then
        generate_all
    fi
done

if [[ $only_generate == *"jpg"* ]]
then
    generate_mosaic
elif  [[ $only_generate == "" ]]
then
    generate_mosaic
fi

if [[ $anim_keep_images != "true" ]]
then
    rm -Rf "$anim_dir"
fi
echo_info "Done."
