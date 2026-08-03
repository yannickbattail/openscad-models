# Opinel Lightsaber

Lightsaber with the handle of an Opinel knife.

## Updates

- v2: fix fundationAndVirole
- v1: 1st design

## How to print it

Parts:

- fundationAndVirole: rotate 180° on the X axis (virole on bottom), and you don't need to add supports. color: silver
- opinel: add supports blocker on the 2 holes of the handle, they are useless, and it will save you some time and some filament. Color: brown (wood)
- the blade by [3dprintingworld](https://thangs.com/3dprintingworld) available
  on [thang](https://thangs.com/designer/3dprintingworld/3d-model/Collapsing%20Lightsaber-23595) or
  on [thingiverse](https://www.thingiverse.com/thing:3606120).

## Customizable variables

- `part`: part to generate: all, opinel, fundationAndVirole
- `$fn`: resolution

## Sources

Sources available [here](https://github.com/yannickbattail/openscad-models/tree/main/star_wars/opinel-lightsaber)

The [opinel](https://www.thingiverse.com/thing:2762852) handle.

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --configFile opinel-lightsaber.yaml ./opinel-lightsaber.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)

## Other interesting designs

- [Cthulhu lightsaber](https://www.thingiverse.com/thing:7147024))
- [blooming sith lightsaber](https://www.thingiverse.com/thing:5437311)
- [Lightsaber as selfie stick (customisable)](https://www.thingiverse.com/thing:6408914)

## License

[GPL](https://www.gnu.org/licenses/gpl-3.0.html)

[CC BY](https://creativecommons.org/licenses/by/4.0/)
