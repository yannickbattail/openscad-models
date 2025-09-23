# CD solar oven

solar oven made with CDs.

Caution
1. Use oven gloves.
2. Wear protective glasses.
3. Cover with dark fabric when not in usage.

## UPDATE

- v1: 1st design

## How to print it

Material: PLA (PLA is not very heat-resistant), ABS, PETG may be better

Parts:
- `base`: support No
- `support`: support No

## Customizable variables

?????
- `part`: default "all", part to generate: all, ball, stick
- `size`: default 50, size of the model
- `$fn`: resolution

## Sources

Sources available [here](https://github.com/yannickbattail/openscad-models/tree/main/CD_solar_oven)

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --mosaicFormat 2,2 --configFile CD_solar_oven.yaml ./CD_solar_oven.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)

## Other interesting designs

- [JWST ceiling light](https://github.com/yannickbattail/openscad-models/tree/main/JWST_ceiling_light)

## License

[GPL](https://www.gnu.org/licenses/gpl-3.0.html)

[CC BY](https://creativecommons.org/licenses/by/4.0/)

## keywords

openscad, customizable, customizer, CD, solar, oven, solar panel
