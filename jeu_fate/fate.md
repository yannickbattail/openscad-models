# fate

fate le jeu

## UPDATE

- v1: 1st design

## Customizable variables

- `part`: default "all", part to generate: all, ball, stick
- `size`: default 50, size of the model
- `$fn`: resolution

## Sources

here: https://github.com/.../...

## Generate

Command to generate for all the presets:

- png image
- webp animation
- 3mf 3D model
- mosaic of all the presets

```bash
npx openscad-generate generate --outFormats png,webp,3mf --mosaicFormat 2,2 --configFile fate.config.json ./fate.scad
```

More formats can be use: stl,asciistl,binstl,off,wrl,amf,3mf,pov,dxf,svg,pdf,png,gif,webp

You can use the option `--parallelJobs 7` to generate in parallel. (optimal number is your CPU cores minus 1)

You need nodejs, imagemagick, webp and of course openscad-nightly installed.

## License

license GPL

CC BY https://creativecommons.org/licenses/by/4.0/

## keywords

sample, openscad, 3D model, customizable, customizer
