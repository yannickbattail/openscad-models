# generate_profile.sh

## Usage
Usage: `generate_profile.sh [OPTION]... OPENSCAD_FILE`

Options:
- `-c`, `--config-file` `configuration_file`      specify another configuration file thant the default OPENSCAD_FILE.conf.
- `-p`, `--only-parameter-set` `parameter-set`    parameter-set is one the parameter-set name present in the file.
- `-g`, `--generate` `only_generate`              only_generate must be one of jpg,gif,webp,stl,conf. bay default it will generate all.

## Requirements

```bash
sudo apt install jq imagemagick webp
```

## Folder structure

## Configuration

```
####### configuration file for ../generate_profile.sh #######
## it will be sourced by ../generate_profile.sh

#image_dollar_fn="50"
#image_size="1024,1024"
### for image_mosaic_geometry see https://legacy.imagemagick.org/Usage/montage/
#image_mosaic_geometry="256x256+2+2"
#image_mosaic_tile="2x2"

#anim_dollar_fn="50"
#anim_size="512,512"
#anim_nb_image="20"
### delay between images en 100th of seconds
#anim_delay="20"
#anim_keep_images="true"

#stl_dollar_fn="50"
#stl_format="asciistl"
#stl_format="binstl"
#stl_render_option=""
### this option is only available on openscad-nightly
#stl_render_option="--enable sort-stl"

#OPENSCAD="xvfb-run -a openscad"
#OPENSCAD="xvfb-run -a openscad-nightly"
```

## Changelog

- check commands fails and exit
- generate config file only when `-g conf`

## TODO

- `only_generate` option can have multiple values ex: "git,webp"
