# nutella glass

Template of nutella glass (200g size).

If you want to make a cup, mug, glass compatible with nutella glass.

see example of use:

- [C3PO mug](https://www.thingiverse.com/thing:6296440)
- mug Grogu
- mug tonneau
- [pumpkin mug](https://www.thingiverse.com/thing:6274402)
- [your image on a mug](https://www.thingiverse.com/thing:5560224)

## UPDATE

- v2: fix inner diameter when no block is used
- v1: 1st design

## How to print it

Material: transparent filament ?

Other slicer options
- infill: 100% ? or less

## Customizable variables

- `plain`: plain (template for making mug or cup) or empty (the glass),
- `numberOfBlock`: Number of block
- `thickness`: thickness of the glass
- `debug`: cut the glass in quarter

## Sources

Sources available [here](https://github.com/yannickbattail/openscad-models/tree/main/mug/nutellaGlass)

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --mosaicFormat 2,2 --configFile nutellaGlass.yaml ./nutellaGlass.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)

## Other interesting designs

- [something](https://www.thingiverse.com/thing:0000000) ???

## License

[GPL](https://www.gnu.org/licenses/gpl-3.0.html)

[CC BY](https://creativecommons.org/licenses/by/4.0/)

## keywords

mug, Coffee_Mug, coffee_mugs, Mug_holder, cup, coffee_cup, cup_holder, glass, upcycling, nutella, openscad, customizable, customizer
