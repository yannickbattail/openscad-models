# Figurine in a dice

## Balanced dices

Dices are balanced, figurine's center of gravity is put in the center of the dice.

If you want to keep the dice balance, print it with 100% of infill.

Sources here: https://github.com/yannickbattail/openscad-models/tree/main/animal_dice

If you want to create another read the part: "how I made them"

Don't forget to post a make.

## models

- dragon https://www.thingiverse.com/thing:1291987
- fox https://www.thingiverse.com/thing:1736162
- cat https://www.thingiverse.com/thing:5035825
- dino https://www.thingiverse.com/thing:913069
- panda: https://www.thingiverse.com/thing:182239
- heart gem: https://www.thingiverse.com/thing:2452845

## how I made them

Copy model to `animals/heart_gem.stl`

Install numpy-stl if needed

```shell
pip install numpy-stl
```

launch the "center of gravity" script with the model as parameter

```shell
python get_center_of_gravity.py animals/heart_gem.stl
```

Output of the script:

```text
Volume                            = 117.31810242698218
Position of the center of gravity = [3.84325029e-03 1.01203855e+00 1.12715415e+01]
```

add it in the code, in the module `animal()` duplicate an animal line 95

```openscad
    else if (animalName == "fox") {
animalModel(file = "animals/foxLowPoly.stl", scalePercent = 1, centerOfGravity = [ - 14.18385003, 4.57492739,
75.20926315]);
}
```

change file and centerOfGravity

```openscad
    else if (animalName == "heart_gem") {
animalModel(file = "animals/heart_gem.stl", scalePercent = 1, centerOfGravity = [3.84325029e-03, 1.01203855e+00,
1.12715415e+01]);
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
animalModel(file = "animals/heart_gem.stl", scalePercent = 0.7, centerOfGravity = [3.84325029e-03, 1.01203855e+00,
    1.12715415e+01], rotation = [180, 0, 0]);
```

> See every changes for adding this model in this
> commit [5f048454d40d1761096770d57f2074d0c837404c](https://github.com/yannickbattail/openscad-models/commit/5f048454d40d1761096770d57f2074d0c837404c)

Render the model to check if everything is ok.

Print it with 100% of infill to keep the dice balanced.
