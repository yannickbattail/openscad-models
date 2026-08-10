# Lightsaber holder

Lightsaber holder

## UPDATE

- v1: 1st design

## How to print it

Material: what you want. color what you want

Parts:
- `all`: support Yes/No
- `holder`: support Yes/No
- `saber`: support Yes/No

## Customizable variables

- `part`: default "all", part to generate: all, holder, saber
- `$fn`: resolution

## Sources

Sources available [here](https://github.com/yannickbattail/openscad-models/tree/main/star_wars/lightsaber_holder)

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --mosaicFormat 2,2 --configFile lightsaber_holder.yaml ./lightsaber_holder.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)

## Other interesting designs

- [Cthulhu lightsaber](https://www.thingiverse.com/thing:7147024)
- [blooming sith lightsaber](https://www.thingiverse.com/thing:5437311)
- [Lightsaber as selfie stick (customisable)](https://www.thingiverse.com/thing:6408914)

## License

[GPL](https://www.gnu.org/licenses/gpl-3.0.html)

[CC BY](https://creativecommons.org/licenses/by/4.0/)
