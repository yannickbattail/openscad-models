# Figurine in a D20

## Balanced dices

Dices are balanced, figurine's center of gravity is put in the center of the dice.

If you want to keep the dice balance, print it with 100% of infill.

If you want to create another read the part: "how I made them"

Don't forget to post a make.

## UPDATE

- v2: fix faces number: was from 0 to 19 changed to 1 to 20, make the face 20 on the top
- v1: 1st design

## models

- heart : https://github.com/yannickbattail/openscad-models/tree/main/VoxelHeart
- D&D Damagetypes: https://www.thingiverse.com/thing:6847860

## How to print it

slicer options
- infill: 15% or 100% if you want to keep the dice balance
- supports: yes, tree

Tip: you can split the model in two parts and glue them, this prevent using to much infill.

## Customizable variables

- `part`: default "VoxelHeart1_hull", figurine to use: Damagetypes-Acid, Damagetypes-Bludgeoning, Damagetypes-Cold, Damagetypes-Fire, Damagetypes-Force, Damagetypes-Lightning, Damagetypes-Necrotic, Damagetypes-Piercing, Damagetypes-Poison, Damagetypes-Psychic, Damagetypes-Radiant, Damagetypes-Slashing, Damagetypes-Thunder, VoxelHeart1_hull
- `fixation_diameter`: default 4, fixation bars diameter
- `radius`: default 0.1, The diameter of the edge

## Sources

Sources available [here]([https://github.com/.../...](https://github.com/yannickbattail/openscad-models/tree/main/animal_d20))

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --mosaicFormat 2,2 --configFile animal_d20.yaml ./animal_d20.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)


## how I made them

Copy model to `animals/` folder

Install numpy-stl if needed

```shell
python3 -m venv venv
. ./venv/bin/activate
pip install numpy-stl
```

launch the "center of gravity" script with the model as parameter

```shell
python get_center_of_gravity.py animals/VoxelHeart1_hull.stl
```

Output of the script:

```text
Volume                            = 117.31810242698218
Position of the center of gravity = [3.84325029e-03 1.01203855e+00 1.12715415e+01]
```

add it in the code, in the module `animal()` duplicate an animal line 95

```openscad
    else if (animalName == "fox") {
        animalModel(file = "animals/foxLowPoly.stl", scalePercent = 1, centerOfGravity = [- 14.18385003, 4.57492739, 75.20926315]);
    }
```

change file and centerOfGravity

```openscad
    else if (animalName == "heart_gem") {
        animalModel(file = "animals/heart_gem.stl", scalePercent = 1, centerOfGravity = [3.84325029e-03, 1.01203855e+00, 1.12715415e+01]);
    }
```

in line 2 add heart_gem

```openscad
part = "fox"; // [fox, dino, dragon, cat, panda, heart_gem]
```

Open the file dice_animal.scad in openscad and choose in the customizer animal : heart_gem

Change the variable `scalePercent` so the model fit inside the dice. (Note: check every faces)

For the heart_gem, the model is upside down, so I add `rotation = [180, 0, 0]`

The final code is:

```openscad
animalModel(file = "animals/heart_gem.stl", scalePercent = 0.7, centerOfGravity = [3.84325029e-03, 1.01203855e+00, 1.12715415e+01], rotation = [180, 0, 0]);
```

Render the model to check if everything is ok.

Print it with 100% of infill to keep the dice balanced.


## Other interesting designs

- [Figurine in a dice](https://www.thingiverse.com/thing:5617642}
- [D20 mug, upcycling nutella glass](https://www.thingiverse.com/thing:7097917)

## License

[GPL](https://www.gnu.org/licenses/gpl-3.0.html)

[CC BY](https://creativecommons.org/licenses/by/4.0/)

## keywords

D20, D20 Dice, dice, openscad, customizable, customizer
