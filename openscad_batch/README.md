# generate_profile.sh

Script for generating 3D files, images and animations from an openscad file and a parameter file.

## Usage

Usage: `generate_profile.sh [OPTION]... OPENSCAD_FILE`

Options:
- `-c`, `--config-file` `configuration_file`      specify another configuration file than the default *OPENSCAD_FILE*.conf.
- `-p`, `--only-parameter-set` `parameter-set`    parameter-set is one the parameter-set name present in the file.
- `-g`, `--generate` `only_generate`              only_generate must be one or multiple separated by  ',' of these values: jpg,gif,webp,stl,obj,3mf,wrl,off,amf,conf. By default it will generate jpg,gif,stl.

Important Note: if there is no parameter file (.json file) for your OPENSCAD_FILE, it will not work. See paragraph : [Code best practices](#Code best practices)

## Examples

### Basic usage

```bash
generate_profile.sh my_model.scad
```

### Generate one parameter set

```bash
generate_profile.sh -p dice_20sides my_model.scad
```

### Generate only modern format with smaller size

```bash
generate_profile.sh -g jpg,webp,3mf my_model.scad
```

### Generate files for Thingiverse

Thingiverse only support gif, not webp and stl files are more common and a preview is possible.

```bash
generate_profile.sh -g jpg,gif,stl my_model.scad
```

### Generate only the stl of one part (parameter set)

```bash
generate_profile.sh -p dice_20sides -g stl my_model.scad
```

### Generate images for all .scad files in the folder

```bash
for OPENSCAD_FILE in *.scad ; do
  generate_profile.sh -g jpg,gif $OPENSCAD_FILE
done
```

### Generate the configuration file for advanced configuration

```bash
generate_profile.sh -g conf my_model.scad
```

Edit the file `my_model.conf` amd re-run the script without the `-g conf`

## Requirements

- command 'jq'
- 'webp' for webp generation
- 'imagemagick' for gif and mosaic generation"

### How to install them

#### On ubuntu

```bash
sudo apt install jq imagemagick webp
```

## Configuration

```
####### configuration file for generate_profile.sh #######
## it will be sourced by generate_profile.sh

#### image generation ####
## value of the $fn variable (3d model resolution) for image generation 
#image_dollar_fn="50"
## image size
#image_size="1024,1024"
### tile image dimension and border. see https://legacy.imagemagick.org/Usage/montage/
#image_mosaic_geometry="256x256+2+2"
## mosaic disposition : number of tile its composition. if it 2x2, and you have 5 images, an other mosaic will be created.
#image_mosaic_tile="2x2"

#### animation (gif or webp) generation ####
## value of the $fn variable (3d model resolution) for animation generation 
#anim_dollar_fn="50"
## animation image size
#anim_size="512,512"
## number of images in the animation
#anim_nb_image="20"
### delay between images en 100th of seconds
#anim_delay="20"
## keep of images in the animation in the folder "anim"
#anim_keep_images="true"

#### model3D  generation (stl, obj, 3mf, off, wrl or amf) ####
## value of the \$fn variable (3d model resolution) for 3D model generation 
#m3D_dollar_fn="50"
## 3D rendering options
#m3D_render_option=""
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

```

## Code best practices

### Openscad code

```openscad
/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:$vpt;
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:$vpr;  // animation rotate around the object
$vpd = is_animated?800:$vpd;
```

Add this code at the end of your customisable variables.

Explanation: when the script generate animations, the variable `animation_rotation` is set to `true`,
then the value for the camera is set to `$vpr = [60, 0, 365 * $t:45]` where `$t` is the value of "time" (value between 0 and 1).
It will animate a rotate of the camera around the object.

### Parameter file (the .json file) 

Create a parameter set in the customizer in openscad.

For file `my_model.scad` it will create a parameter file `my_model.json`.

Remove every line that define the variable `$fn` and `animation_rotation`
because the script won't be able the override the value of theses variables it they are set in the .json file.

If you want to force the value of `$fn`, generate a config file (see last example), and change `image_dollar_fn`, `anim_dollar_fn`, `stl_dollar_fn`.  

## Folder structure

For a file named `cube1.scad` and one parameter-set `test1` it will generate this folder structure.

```
.
├── cube1
│   ├── 3mf
│   │   └── test1.3mf
│   ├── cube1.conf
│   ├── gif
│   │   └── test1.gif
│   ├── images
│   │   ├── mosaic_cube1.jpg
│   │   └── test1.png
│   ├── stl
│   │   └── test1.stl
│   └── webp
│       └── test1.webp
```

If you activate `anim_keep_images="true"` in the configuration file it will add a folder `anim` next to `images` that contains every frame of the animation.

## Changelog

- 2023-02-28 generate 3D format: stl,obj,3mf,wrl,off,amf
- 2023-02-28 by default (without `-g` option) generate only one type of 3D files and animation (stl and gif)
- 2023-02-23 add documentation
- 2023-02-09 add .3mf files generation

## TODO

- add an option to disable mosaic generation (with `-g` option or config file. To be decided)
- set in the configuration file the default format of 3D files and animation
- generate 2D format: svg, dfx (and pdf)
- generate 2 or more specified parameter sets
- check if `-g` option contains a possible value
