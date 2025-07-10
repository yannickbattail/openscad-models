# Tonneau mug, upcycling nutella glass

Tonneau mug that uses nutella glass (200g size).

If you pour hot beverage in the glass when it cools down it may be stuck in the mug, so put hot water in it to detach it

## UPDATE

- v1: initial version with block

## Customizable variables

- `nutellaGlassScale`: nutella glass scale: grow nutella glass to better fit in
- `numberOfBlock`: Number of block
- `debug`: cut the mug in quarter and display the nutella glass

## Sources

tonneau: https://www.thingiverse.com/thing:703127

here: https://github.com/yannickbattail/openscad-models/tree/main/mug/ugTonneau.

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 2,1 --configFile ../globalConfig.yaml ./mugTonneau.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)

## License

[GPL](https://www.gnu.org/licenses/gpl-3.0.html)

[CC BY](https://creativecommons.org/licenses/by/4.0/)

## keywords

mug, Coffee_Mug, coffee_mugs, Mug_holder, cup, coffee_cup, cup_holder, upcycling, tonneau, barrel, nutella, openscad, customizable, customizer
