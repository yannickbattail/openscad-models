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

compare_images() {
  if [ $(compare -metric rmse $1 $2 null: 2>&1 | cut -d\  -f1) -eq 0 ]
  then
    echo -e "[${IGreen} OK ${IReset}] identical images $1 $2 are different"
  else
    echo -e "[${IRed} FAIL ${IReset}] images $1 $2 are different"
    exit 1
  fi
}

compare_bin_files() {
  if cmp $1 $2
  then
    echo -e "[${IGreen} OK ${IReset}] identical images $1 $2 are different"
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
    ls -A1 $1
    exit 1
  fi
}


test1() {
  echo -e "${IBlue} ###### test1 ${IReset}"
  
  echo "       generate cube1.scad"
  ../generate_profile.sh cube1.scad > /dev/null 2>&1
  echo "       generation done"
  
  compare_images ./cube1/gif/test1.gif ./cube1_expected/gif/test1.gif
  compare_images ./cube1/images/test1.png ./cube1_expected/images/test1.png
  compare_images ./cube1/gif/test1.gif ./cube1_expected/gif/test1.gif
  compare_bin_files ./cube1/webp/test1.webp ./cube1_expected/webp/test1.webp
  compare_bin_files ./cube1/stl/test1.stl ./cube1_expected/stl/test1.stl
  compare_bin_files ./cube1.conf ./cube1_expected/cube1.conf
  
  rm -Rf ./cube1/ ./cube1.conf
}

test2() {
  echo -e "${IBlue} ###### test2 animations ${IReset}"
  
  echo "       generate gif cube_anim.scad"
  ../generate_profile.sh -g gif cube_anim.scad > /dev/null 2>&1
  echo "       generate webp cube_anim.scad"
  ../generate_profile.sh -g webp cube_anim.scad > /dev/null 2>&1
  echo "       generation done"
  
  compare_bin_files ./cube_anim/webp/test1.webp ./cube_anim_expected/webp/test1.webp
  compare_bin_files ./cube_anim/gif/test1.gif ./cube_anim_expected/gif/test1.gif
  
  rm -Rf ./cube_anim/ rm -Rf ./cube_anim.conf
}

test3() {
  echo -e "${IBlue} ###### test3 only_generate ${IReset}"
  
  echo "       generate gif cube1.scad"
  ../generate_profile.sh -g gif cube1.scad > /dev/null 2>&1
  echo "       generation done"
  check_directory ./cube1/ "gif"
  check_directory ./cube1/gif/ "test1.gif"
  rm -Rf ./cube1/
  
  echo "       generate image cube1.scad"
  ../generate_profile.sh -g jpg cube1.scad > /dev/null 2>&1
  echo "       generation done"
  check_directory ./cube1/ "images"
  check_directory ./cube1/images/ 'mosaic_cube1.jpg
test1.png'
  rm -Rf ./cube1/
  
  echo "       generate webp cube1.scad"
  ../generate_profile.sh -g webp cube1.scad > /dev/null 2>&1
  echo "       generation done"
  check_directory ./cube1/ "webp"
  check_directory ./cube1/webp/ "test1.webp"
  rm -Rf ./cube1/
  
  echo "       generate stl cube1.scad"
  ../generate_profile.sh -g stl cube1.scad > /dev/null 2>&1
  echo "       generation done"
  check_directory ./cube1/ "stl"
  check_directory ./cube1/stl/ "test1.stl"
  rm -Rf ./cube1/ ./cube1.conf
}

test4() {
  echo -e "${IBlue} ###### test4 parameter-set ${IReset}"
  
  echo "       generate cube4.scad"
  ../generate_profile.sh cube4.scad > /dev/null 2>&1
  echo "       generation done"
  check_directory ./cube4/ "gif
images
stl
webp"
  check_directory ./cube4/gif/ "cube_30.gif
cube_50.gif"
  check_directory ./cube4/images/ "cube_30.png
cube_50.png
mosaic_cube4.jpg"
  check_directory ./cube4/stl/ "cube_30.stl
cube_50.stl"
  check_directory ./cube4/webp/ "cube_30.webp
cube_50.webp"
  rm -Rf ./cube4/
  
  echo "       generate parameter-set cube_50 cube4.scad"
  ../generate_profile.sh -p cube_50 cube4.scad > /dev/null 2>&1
  echo "       generation done"
  check_directory ./cube4/ "gif
images
stl
webp"
  check_directory ./cube4/gif/ "cube_50.gif"
  check_directory ./cube4/images/ "cube_50.png
mosaic_cube4.jpg"
  check_directory ./cube4/stl/ "cube_50.stl"
  check_directory ./cube4/webp/ "cube_50.webp"
  rm -Rf ./cube4/ ./cube4.conf
}

test5() {
  echo -e "${IBlue} ###### test5 option: anim_keep_images ${IReset}"
  
  echo "       generate p cube5.scad"
  ../generate_profile.sh cube5.scad > /dev/null 2>&1
  echo "       generation done"
  check_directory ./cube5/ "anim
gif
images
stl
webp"
  check_directory ./cube5/anim/ "test100000.png
test100001.png
test100002.png
test100003.png
test100004.png"
  rm -Rf ./cube5/
}

test1
test2
test3
test4
test5