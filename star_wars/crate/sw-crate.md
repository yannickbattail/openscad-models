# Star wars crate box

Star wars crate box

## UPDATE

- v1: 1st design

## Customizable variables

- `part`: default "all", part to generate: full, all, top, bottom
- `thickness`: default 5, thickness of the box
- `$fn`: resolution

## Sources

Sources available [here](https://github.com/yannickbattail/openscad-models/tree/main/star_wars/crate)

## Generate

Command to generate for all the presets:

- png image
- webp animation
- 3mf 3D model
- mosaic of all the presets

```bash
npx openscad-generate generate --outFormats png,webp,3mf --mosaicFormat 2,2 --configFile sw-crate.config.json5 ./sw-crate.scad
```

More formats can be use: stl,asciistl,binstl,off,wrl,amf,3mf,pov,dxf,svg,pdf,png,gif,webp

You can use the option `--parallelJobs 7` to generate in parallel. (optimal number is your CPU cores minus 1)

You need nodejs, imagemagick, webp and of course openscad-nightly installed.

## License

license GPL

CC BY https://creativecommons.org/licenses/by/4.0/

## keywords

star_wars, crate, box, openscad, 3D model, customizable, customizer
