#!/bin/bash
#set -x

# Background
# shellcheck disable=SC2034
On_Black='\033[40m' On_Red='\033[41m' On_Green='\033[42m' On_Yellow='\033[43m' On_Blue='\033[44m' On_Purple='\033[45m' On_Cyan='\033[46m' On_White='\033[47m'
# High Intensity
IBlack='\033[0;90m' IRed='\033[0;91m' IGreen='\033[0;92m' IYellow='\033[0;93m' IBlue='\033[0;94m' IPurple='\033[0;95m' ICyan='\033[0;96m' IWhite='\033[0;97m'
# Bold High Intensity
BIBlack='\033[1;90m' BIRed='\033[1;91m' BIGreen='\033[1;92m' BIYellow='\033[1;93m' BIBlue='\033[1;94m' BIPurple='\033[1;95m' BICyan='\033[1;96m' BIWhite='\033[1;97m'
# High Intensity backgrounds
On_IBlack='\033[0;100m' On_IRed='\033[0;101m' On_IGreen='\033[0;102m' On_IYellow='\033[0;103m' On_IBlue='\033[0;104m' On_IPurple='\033[0;105m' On_ICyan='\033[0;106m' On_IWhite='\033[0;107m'
On_Reset='\e[0m'
#BRIGHT=$(tput bold) NORMAL=$(tput sgr0) BLINK=$(tput blink) REVERSE=$(tput smso) UNDERLINE=$(tput smul)


echo_log() {
    echo -ne "$ICyan"
    echo "$@"
    echo -ne "$On_Reset"
}

echo_info() {
    echo -ne "$IGreen"
    echo "$@"
    echo -ne "$On_Reset"
}

echo_warn() {
    echo -ne "$IPurple"
    echo "$@"
    echo -ne "$On_Reset"
}

echo_error() {
    echo -ne "$IRed" >&2
    echo "$@" >&2
    usage
    echo -ne "$On_Reset" >&2
    exit 1
}

compare_images() {
  if [ $(compare -metric rmse $1 $2 null: 2>&1 | cut -d\  -f1) -eq 0 ]
  then
    echo -e "[${IGreen} OK ${IReset}] images $1 $2 are identical"
  else
    echo -e "[${IRed} FAIL ${IReset}] images $1 $2 are different"
    exit 1
  fi
}

compare_bin_files() {
  if cmp $1 $2
  then
    echo -e "[${IGreen} OK ${IReset}] images $1 $2 are identical"
  else
    echo -e "[${IRed} FAIL ${IReset}] files $1 $2 are different"
    exit 1
  fi
}

file_exists() {
  if [[ -f $1 ]]
  then
    echo -e "[${IGreen} OK ${IReset}] file $1 exists"
  else
    echo -e "[${IRed} FAIL ${IReset}] file $1 does not exist"
    exit 1
  fi
}

check_directory() {
  if [[ "$(ls -A1 $1)" == "$2" ]]
  then
    echo -e "[${IGreen} OK ${IReset}] content of directory $1 is ok"
  else
    echo -e "[${IRed} FAIL ${IReset}] content of directory $1 must be $2"
    echo "## content of $1"
    echo -ne "$IPurple"
    ls -A1 $1
    echo -ne "$IReset"
    exit 1
  fi
}

check_return_code() {
  "$@" > test.log 2>&1
  local ret=$?
  if [[ $ret != "0" ]]
  then
    echo -e "[${IRed} FAIL ${IReset}] Execution fail, return code is $ret for command $*${IReset}" >&2
    echo -ne "$IPurple"
    cat test.log
    echo -ne "$IReset"
    exit 1
  fi
}

check_return_code_fails() {
  if ! $* > test.log 2>&1
  then
    echo -e "[${IGreen} OK ${IReset}] the command fails successfully"
  else
    echo -e "[${IRed} FAIL ${IReset}] the command should fail: $*"
    echo -ne "$IPurple"
    echo poutre
    cat test.log
    echo -ne "$IReset"
    exit 1
  fi
}


test1() {
  echo -e "${IBlue} ###### test1 all ${IReset}"
  
  echo "       generate cube1.scad"
  check_return_code ../generate_profile.sh -g jpg,gif,webp,stl,obj,3mf,wrl,off,amf cube1.scad
  echo "       generation done"
  
  compare_images ./cube1/gif/test1.gif ./cube1_expected/gif/test1.gif
  compare_images ./cube1/images/test1.png ./cube1_expected/images/test1.png
  compare_images ./cube1/gif/test1.gif ./cube1_expected/gif/test1.gif
  compare_bin_files ./cube1/3D/test1.stl ./cube1_expected/3D/test1.stl
  compare_bin_files ./cube1/3D/test1.obj ./cube1_expected/3D/test1.obj
  ## find a way to compare 3mf files, because they contains a UUID different at every generation.
  #compare_bin_files ./cube1/3D/test1.3mf ./cube1_expected/3D/test1.3mf
  compare_bin_files ./cube1/3D/test1.wrl ./cube1_expected/3D/test1.wrl
  compare_bin_files ./cube1/3D/test1.off ./cube1_expected/3D/test1.off
  compare_bin_files ./cube1/3D/test1.amf ./cube1_expected/3D/test1.amf
  
  rm -Rf ./cube1/
}

test2() {
  echo -e "${IBlue} ###### test2 animations ${IReset}"
  
  echo "       generate gif cube_anim.scad"
  check_return_code ../generate_profile.sh -g gif cube_anim.scad
  echo "       generate webp cube_anim.scad"
  check_return_code ../generate_profile.sh -g webp cube_anim.scad
  echo "       generation done"
  
  compare_bin_files ./cube_anim/webp/test1.webp ./cube_anim_expected/webp/test1.webp
  compare_bin_files ./cube_anim/gif/test1.gif ./cube_anim_expected/gif/test1.gif
  
  rm -Rf ./cube_anim/ rm -Rf ./cube_anim.conf
}

test3() {
  echo -e "${IBlue} ###### test3 only_generate ${IReset}"
  
  echo "       generate gif cube1.scad"
  check_return_code ../generate_profile.sh -g gif cube1.scad
  echo "       generation done"
  check_directory ./cube1/ "3D
gif"
  check_directory ./cube1/3D/ ""
  check_directory ./cube1/gif/ "test1.gif"
  rm -Rf ./cube1/
  
  echo "       generate image cube1.scad"
  check_return_code ../generate_profile.sh -g jpg cube1.scad
  echo "       generation done"
  check_directory ./cube1/ "3D
images"
  check_directory ./cube1/3D/ ""
  check_directory ./cube1/images/ 'mosaic_cube1.jpg
test1.png'
  rm -Rf ./cube1/
  
  echo "       generate webp cube1.scad"
  check_return_code ../generate_profile.sh -g webp cube1.scad
  echo "       generation done"
  check_directory ./cube1/ "3D
webp"
  check_directory ./cube1/3D/ ""
  check_directory ./cube1/webp/ "test1.webp"
  rm -Rf ./cube1/
  
  echo "       generate stl cube1.scad"
  check_return_code ../generate_profile.sh -g stl cube1.scad
  echo "       generation done"
  check_directory ./cube1/ "3D"
  check_directory ./cube1/3D/ "test1.stl"
  rm -Rf ./cube1/
  
  echo "       generate stl cube1.scad"
  check_return_code ../generate_profile.sh -g obj cube1.scad
  echo "       generation done"
  check_directory ./cube1/ "3D"
  check_directory ./cube1/3D/ "test1.obj"
  rm -Rf ./cube1/
  
  echo "       generate stl cube1.scad"
  check_return_code ../generate_profile.sh -g 3mf cube1.scad
  echo "       generation done"
  check_directory ./cube1/ "3D"
  check_directory ./cube1/3D/ "test1.3mf"
  rm -Rf ./cube1/
  
  echo "       generate stl cube1.scad"
  check_return_code ../generate_profile.sh -g wrl cube1.scad
  echo "       generation done"
  check_directory ./cube1/ "3D"
  check_directory ./cube1/3D/ "test1.wrl"
  rm -Rf ./cube1/
  
  echo "       generate stl cube1.scad"
  check_return_code ../generate_profile.sh -g off cube1.scad
  echo "       generation done"
  check_directory ./cube1/ "3D"
  check_directory ./cube1/3D/ "test1.off"
  rm -Rf ./cube1/
  
  echo "       generate stl cube1.scad"
  check_return_code ../generate_profile.sh -g amf cube1.scad
  echo "       generation done"
  check_directory ./cube1/ "3D"
  check_directory ./cube1/3D/ "test1.amf"
  rm -Rf ./cube1/
}

test4() {
  echo -e "${IBlue} ###### test4 parameter-set ${IReset}"
  
  echo "       generate cube4.scad"
  check_return_code ../generate_profile.sh cube4.scad
  echo "       generation done"
  check_directory ./cube4/ "3D
gif
images"
  check_directory ./cube4/gif/ "cube_30.gif
cube_50.gif"
  check_directory ./cube4/images/ "cube_30.png
cube_50.png
mosaic_cube4.jpg"
  check_directory ./cube4/3D/ "cube_30.stl
cube_50.stl"
  rm -Rf ./cube4/
  
  echo "       generate parameter-set cube_50 cube4.scad"
  check_return_code ../generate_profile.sh -p cube_50 cube4.scad
  echo "       generation done"
  check_directory ./cube4/ "3D
gif
images"
  check_directory ./cube4/gif/ "cube_50.gif"
  check_directory ./cube4/images/ "cube_50.png
mosaic_cube4.jpg"
  check_directory ./cube4/3D/ "cube_50.stl"
  rm -Rf ./cube4/ ./cube4.conf
}

test5() {
  echo -e "${IBlue} ###### test5 option: anim_keep_images ${IReset}"
  
  echo "       generate p cube5.scad"
  check_return_code ../generate_profile.sh cube5.scad
  echo "       generation done"
  check_directory ./cube5/ "3D
anim
gif
images"
  check_directory ./cube5/anim/ "test100000.png
test100001.png
test100002.png
test100003.png
test100004.png"
  rm -Rf ./cube5/
}

test6() {
  echo -e "${IBlue} ###### test6 check commands return code${IReset}"
  
  echo "       generate cube6.scad"
  check_return_code_fails ../generate_profile.sh cube6.scad
  
  rm -Rf ./cube6/ ./cube6.conf
}

test7() {
  echo -e "${IBlue} ###### test7 check config file generation${IReset}"
  
  echo "       generate cube4.scad"
  check_return_code ../generate_profile.sh -g conf cube4.scad
  echo "       generate cube4.scad"
  compare_bin_files ./cube4.conf ./cube1_expected/cube1.conf
  
  rm -Rf ./cube4.conf
}

test8() {
  echo -e "${IBlue} ###### test8 only_generate multiple values ${IReset}"
  
  echo "       generate gif,jpg cube1.scad"
  check_return_code ../generate_profile.sh -g gif,jpg cube1.scad
  echo "       generation done"
  check_directory ./cube1/ "3D
gif
images"
  check_directory ./cube1/gif/ "test1.gif"
  check_directory ./cube1/images/ 'mosaic_cube1.jpg
test1.png'
  rm -Rf ./cube1/
}

test9() {
  echo -e "${IBlue} ###### test9 generate with f3d ${IReset}"
  
  echo "       generate gif,jpg cube1.scad"
  check_return_code ../generate_profile.sh -g gif,webp,jpg --f3d cube1.scad
  echo "       generation done"
  check_directory ./cube1/ "3D
gif
images
webp"
  check_directory ./cube1/gif/ "test1.gif"
  check_directory ./cube1/images/ 'mosaic_cube1.jpg
test1.png'
  rm -Rf ./cube1/
}

test10() {
  echo -e "${IBlue} ###### test10 generate init project ${IReset}"

  echo "       generate gif,jpg cube1.scad"
  check_return_code ../generate_profile.sh --init cube_new.scad
  echo "       generation done"

  compare_bin_files ./cube_new.conf ./cube_new_expected/cube_new.conf
  compare_bin_files ./cube_new.json ./cube_new_expected/cube_new.json
  compare_bin_files ./cube_new.scad ./cube_new_expected/cube_new.scad
  rm -Rf ./cube_new.*
}

test11() {
  echo -e "${IBlue} ###### test11 generate param file ${IReset}"

  echo "       generate gif,jpg cube1.scad"
  check_return_code ../generate_profile.sh -g param param_test.scad
  echo "       generation done"

  compare_bin_files ./param_test_param.json ./cube1_expected/param_test_param.json
  rm -Rf ./param_test_param.json
}

## cd in script directory
cd "$(dirname "$0")"

#test1
#test2
#test3
#test4
#test5
#test6
#test7
#test8
#test9
#test10
test11

echo -e "${IWhite}[${IGreen} OK ${IWhite}] All tests are successful!${IReset}"

rm test.log
