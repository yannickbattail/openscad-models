# Jedi holocron box multi material

Jedi holocron box.

## Update

- v1: 1st design

## How to print it

Material: *what you want*

Color: grey

Parts:

- `full`: support Yes, rotate 180°
- `top`: support Yes, rotate 180°
- `bottom`: support Yes, rotate 0°

## Customizable variables

- `part`: default "all", part to generate: full, all, top, bottom
- `thickness`: default 5, thickness of the box
- `$fn`: resolution

## Sources

Sources available [here](https://github.com/yannickbattail/openscad-models/tree/main/star_wars/crate)

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 2,2 --configFile sw-crate.yaml ./sw-crate.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)

## Other interesting designs

- [Star wars crate box](https://www.thingiverse.com/thing:6782529)

## License

[GPL](https://www.gnu.org/licenses/gpl-3.0.html)

[CC BY](https://creativecommons.org/licenses/by/4.0/)

## Keywords

star_wars, crate, box, openscad, 3D model, customizable, customizer
