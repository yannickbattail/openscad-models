# Opinel Lightsaber

Lightsaber with the handle of an Opinel knife.

## UPDATE

- v1: 1st design

## How to print it

Parts:
- fundationAndVirole: rotate 180° on the X axis (virole on bottom), and you dont need to add supports.
- opinel: add supports bloquer on the 2 holes of the handle, they are useless, and it will save you some time and some filament.
- the blade by [3dprintingworld](https://thangs.com/3dprintingworld) available
on [thang](https://thangs.com/designer/3dprintingworld/3d-model/Collapsing%20Lightsaber-23595) or
on [thingiverse](https://www.thingiverse.com/thing:3606120).



## Customizable variables

- `part`: part to generate: all, opinel, fundationAndVirole
- `$fn`: resolution

## Sources

Sources available [here](https://github.com/yannickbattail/openscad-models/tree/main/star_wars/opinel-lightsaber)

[opinel](https://www.thingiverse.com/thing:2762852)

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 2,2 --configFile opinel-lightsaber.yaml ./opinel-lightsaber.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)

## License

[GPL](https://www.gnu.org/licenses/gpl-3.0.html)

[CC BY](https://creativecommons.org/licenses/by/4.0/)

## keywords

Opinel, lightsaber, saber, sword, star_wars, openscad, customizable, customizer
