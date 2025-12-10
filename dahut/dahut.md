# Customizable dahut

Customizable dahut, dextrogyre or levogyre

## UPDATE

- v1: 1st design

## How to print it

Material: PLA or whatever, color: dahut color

Other slicer options
- support: yes
- vase mode (Spiral): no

## Customizable variables

- `leg_shrink`: default 0.7, shrink factor for the legs
- `has_rock`: default true, has rock under the feet like a sidewalk
- `sens`: default "dextrogyre", sens, dextrogyre shorter legs on right side, levogyre shorter legs on left side

## Sources

Original [model of goat](https://www.thingiverse.com/thing:7197001)

Sources available [here](https://github.com/yannickbattail/openscad-models/tree/main/dahut/)

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --mosaicFormat 2,2 --configFile dahut.yaml ./dahut.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)

## Other interesting designs

- [Ibex wall art](https://www.thingiverse.com/thing:6368431)

## License

[GPL](https://www.gnu.org/licenses/gpl-3.0.html)

[CC BY](https://creativecommons.org/licenses/by/4.0/)

## keywords

dahut, dahu, dextrogyre, levogyre, chamois, horned goat-antelope, ibex, customizable, customizer
