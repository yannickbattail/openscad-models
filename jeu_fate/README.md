# fate

fate le jeu

## UPDATE

- v1: 1st design

## Customizable variables

- `part`: default "all", part to generate: all, ball, stick
- `size`: default 50, size of the model
- `$fn`: resolution

## Sources

[here](https://github.com/yannickbattail/openscad-models/tree/main/jeu_fate)

Icons are from [game-icons.net](https://game-icons.net/)

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 2,2 --configFile globalConfig.config.json ./figurine.scad
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 2,2 --configFile globalConfig.config.json ./fate.scad
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 3,4 --configFile globalConfig.config.json ./set_de_jeu.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)

## License

[GPL](https://www.gnu.org/licenses/gpl-3.0.html)

[CC BY](https://creativecommons.org/licenses/by/4.0/)

https://www.formware.co/onlinestlrepair

## keywords

sample, openscad, 3D model, customizable, customizer
