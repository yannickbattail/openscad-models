# Cthulhu lightsaber

Cthulhu lightsaber made from the [Cthulhu wand](https://www.thingiverse.com/thing:5435250).

I can use a collapsing blade or a standard 1 inch blade.

## UPDATE

- v1: 1st design

## How to print it

Material: PLA or better
Color: Green?

Parts:
- `pommel`: support Yes, rotate 180°
- `handle`: support Yes, rotate 0°
- `foundation`: *print it only for collapsable blade,* support No, rotate 180° color: whatever

## Customizable variables

- `part`: default "all", part to generate: all, handle, pommel, foundation
- `collapsable`: default true, collapsable blade or standard 1 inch blade
- `$fn`: resolution

## Sources

Sources available [here](https://github.com/yannickbattail/openscad-models/tree/main/star_wars/cthulhu-lightsaber)

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --mosaicFormat 2,2 --configFile cthulhu-lightsaber.yaml ./cthulhu-lightsaber.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)

## Other interesting designs

- [opinel lightsaber](https://www.thingiverse.com/thing:7115218)

## License

[GPL](https://www.gnu.org/licenses/gpl-3.0.html)

[CC BY](https://creativecommons.org/licenses/by/4.0/)

## keywords

star_wars, starwars, lightsaber, cthulhu, tentacle, openscad, customizable, customizer
