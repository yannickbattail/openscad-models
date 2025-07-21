# d20 mug, upcycling nutella glass

d20 mug that uses nutella glass (200g size).

A friend challenges me to create a d20 mug with the face 20 in front of you and face 1 in front of the others when holding the mug in the right hand. Here is it.

If you pour hot beverage in the glass when it cools down it may be stuck in the mug, so put hot water in it to detach it. Print it in ABS because it is more resistant to temperature changes (in PLA it will crack after few hot beverage).

## UPDATE

- v1: initial version with block

## Customizable variables

- `nutellaGlassScale`: nutella glass scale: grow nutella glass to better fit in
- `numberOfBlock`: Number of block
- `debug`: cut the mug in quarter and display the nutella glass

## Sources

d20: https://www.thingiverse.com/thing:5419488

here: https://github.com/yannickbattail/openscad-models/tree/main/mug/ugd20.

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 2,1 --configFile ../globalConfig.yaml ./mugD20.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU
number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)

## License

[GPL](https://www.gnu.org/licenses/gpl-3.0.html)

[CC BY](https://creativecommons.org/licenses/by/4.0/)

## keywords

mug, Coffee_Mug, coffee_mugs, Mug_holder, cup, coffee_cup, cup_holder, upcycling, d20, barrel, nutella, openscad, customizable, customizer
