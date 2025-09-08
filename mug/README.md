# your image on a mug with nutella glass

Download and open [imageToMatrix.html](imageToMatrix.html)

Select your image

copy the code and replace

```
image = [ 
...
... 
];
```

in file `mugImage_in_one_file.scad` or in file `images/cat.scad`

sources: https://github.com/yannickbattail/openscad-models/tree/main/mug

mountain https://www.thingiverse.com/thing:5673235

# C3PO mug, upcycling nutella glass

C3PO mug that uses nutella glass (200g size).

## UPDATE

- v2: add block
- v1: initial version

## customizable variables

- `nutellaGlassScale`: nutella glass scale: grow nutella glass to better fit in
- `numberOfBlock`: Number of block
- `debug`: cut the mug in quarter and display the nutella glass

## nutella glass

It uses a nutella 200g.

If you pour hot beverage in the glass when it cools down it may be stuck in the mug, so put hot water in it to detach it

## Sources

C3PO head: https://www.thingiverse.com/thing:1447941

here: https://github.com/yannickbattail/openscad-models/tree/main/mug

licence GPL

## keywords

mug, Coffee_Mug, coffee_mugs, Mug_holder, cup, coffee_cup, cup_holder, upcycling, star_wars, starwars, c3po, droid,
nutella

# R2D2 mug, upcycling nutella glass

R2D2 mug that uses nutella glass (200g size).

## UPDATE

- v2: add block
- v1: initial version

## customizable variables

- `nutellaGlassScale`: nutella glass scale: grow nutella glass to better fit in
- `numberOfBlock`: Number of block
- `debug`: cut the mug in quarter and display the nutella glass

## nutella glass

It uses a nutella 200g.

If you pour hot beverage in the glass when it cools down it may be stuck in the mug, so put hot water in it to detach it

## Sources

R2D2 head: https://www.thingiverse.com/thing:5413008

here: https://github.com/yannickbattail/openscad-models/tree/main/mug

licence GPL

## keywords

mug, Coffee_Mug, coffee_mugs, Mug_holder, cup, coffee_cup, cup_holder, upcycling, star_wars, starwars, R2D2, droid,
nutella

# Grogu (baby yoda) mug, upcycling nutella glass

Grogu (baby yoda) mug that uses nutella glass (200g size).

## UPDATE

- v2: add block
- v1: initial version

## customizable variables

- `nutellaGlassScale`: nutella glass scale: grow nutella glass to better fit in
- `numberOfBlock`: Number of block
- `debug`: cut the mug in quarter and display the nutella glass

## nutella glass template

It uses a nutella 200g.

If you pour hot beverage in the glass when it cools down it may be stuck in the mug, so put hot water in it to detach it

## Sources

Grogu (baby yoda) head: https://www.thingiverse.com/thing:5411741

here: https://github.com/yannickbattail/openscad-models/tree/main/mug

licence GPL

## keywords

mug, Coffee_Mug, coffee_mugs, Mug_holder, cup, coffee_cup, cup_holder, upcycling, star_wars, starwars, baby yoda, grogu,
nutella

# Tonneau mug, upcycling nutella glass

Tonneau mug that uses nutella glass (200g size).

## UPDATE

- v1: initial version with block

## customizable variables

- `nutellaGlassScale`: nutella glass scale: grow nutella glass to better fit in
- `numberOfBlock`: Number of block
- `debug`: cut the mug in quarter and display the nutella glass

## nutella glass

It uses a nutella 200g.

If you pour hot beverage in the glass when it cools down it may be stuck in the mug, so put hot water in it to detach it

## Sources

tonneau: https://www.thingiverse.com/thing:703127

here: https://github.com/yannickbattail/openscad-models/tree/main/mug

licence GPL

## keywords

mug, Coffee_Mug, coffee_mugs, Mug_holder, cup, coffee_cup, cup_holder, upcycling, tonneau, barrel, nutella

# nutella glass

Template of nutella glass (200g size).

If you want to make a cup, mug, glass compatible with nutella glass.

see example of use:

- [C3PO mug](https://www.thingiverse.com/thing:6296440)
- [pumpkin mug](https://www.thingiverse.com/thing:6274402)
- [your image on a mug](https://www.thingiverse.com/thing:5560224)

## UPDATE

- ...

## customizable variables

- `nutellaGlassScale`: nutella glass scale: grow nutella glass to better fit in
- `debug`: cut the glass in quarter

## Sources

here: https://github.com/yannickbattail/openscad-models/tree/main/mug

licence GPL

## keywords

mug, Coffee_Mug, coffee_mugs, Mug_holder, cup, coffee_cup, cup_holder, glass, upcycling, nutella

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 2,2 --configFile globalConfig.yaml ./mugImage.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU
number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)
