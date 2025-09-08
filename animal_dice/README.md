# Figurine in a dice

Dices are balanced, figurine's center of gravity is put in the center of the dice.

If you want to keep the dice balance, print it with 100% of infill.

Don't forget to post a make.

## models

- dragon https://www.thingiverse.com/thing:1291987
- fox https://www.thingiverse.com/thing:1736162
- cat https://www.thingiverse.com/thing:5035825
- dino https://www.thingiverse.com/thing:913069
- panda: https://www.thingiverse.com/thing:182239
- heart gem: https://www.thingiverse.com/thing:2452845
- duck vador
- Platypus_Barbarian https://cults3d.com/en/3d-model/game/platypus-minis-so-far-mz4250

## UPDATE

- v2: generate from `animals_center_of_gravity.json` and use `openscad-generate`
- v1: 1st design

## Customizable variables

- `part`: default "all", part to generate: all, ball, stick
- `size`: default 50, size of the model
- `$fn`: resolution

## how I made them

Add you .stl to the folder `animals`

backup the file `animals_center_of_gravity.json`

Run the command

```shell
all_center_of_gravity.sh
```

It will regenerate (and override) the file `animals_center_of_gravity.json`

Replace at the beginning of the file `dice_animal.scad` the line starting with `animalNumber = ...` with the one
displayed by the command.

Open the file `animals_center_of_gravity.json` and go to your model and edit (only) the following variables to make the
model fit in the dice.

```json
    "scale": 1.29,
    "rotation": [
        0,
        0,
        -30
    ]
```

## Sources

On GitHub: [here](https://github.com/yannickbattail/openscad-models/tree/main/VoxelHeart)

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 2,2 --configFile dice_animal.yaml ./dice_animal.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU
number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)

## License

[GPL](https://www.gnu.org/licenses/gpl-3.0.html)

[CC BY](https://creativecommons.org/licenses/by/4.0/)

And licenses form the models used to create the dices.

## keywords

dice, d6 dice, game, random, openscad, customizable, customizer
