# utmr

utmr sample openscad model inspired from the openscad logo.

## UPDATE

- v1: 1st design

## How to print it

Material: PLA, ABS ??? color ???

Parts:

- `all`: support Yes/No, rotate 180° color: yellow ???
- `ball`: support Yes/No, rotate 0° color: blue ???
- `stick`: support Yes/No, rotate 0° color: red ???

## Customizable variables

- `part`: default "all", part to generate: all, ball, stick
- `size`: default 50, size of the model
- `$fn`: resolution

## Sources

here: https://github.com/.../...

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 2,2 --configFile utmr.yaml ./utmr.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)

## Other interesting designs

- [something](https://www.thingiverse.com/thing:0000000) ???

## License

[GPL](https://www.gnu.org/licenses/gpl-3.0.html)

[CC BY](https://creativecommons.org/licenses/by/4.0/)

## keywords

sample, openscad, customizable, customizer
