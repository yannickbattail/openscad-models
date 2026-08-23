# CD solar oven

Description of CD_solar_oven sample openscad model inspired from the openscad logo.

1. Use oven gloves.
2. Wear protective glasses.
3. Cover with dark fabric when not in usage.

## Updates

- v1: 1st design

## How to print it

Material: ABS or PETG, they are more resistant to UV rays.

Parts:

- `all`: support Yes
- `base`: support No
- `support`: support Yes

## Customizable variables

- `part`: values (**all**, base, support) : part to generate
- `number_of_rows`: values (**16**) range [1:1:40] : number of rows
- `number_of_column`: values (**5**) range [1:1:40] : number of columns
- `focus_of_parabola`: values (**middle**, bottom_center, bottom_left) : positioning of the focus point
- `focus_distance`: values (**1000**) range [100:2000] : distance of the focus point
- `support_at_column`: values (**A**) : when part=support, it only show the support at column X
- `support_at_row`: values (**1**) : when part=support, it only show the support at row Y
- `base_height`: values (**2**) range [1:10] : thickness of the base
- `support_height`: values (**60**) range [35:100] : support height (from the bottom of the base)
- `show_base`: values (**true**, false) : add the base to the display

## Sources

Sources available [here](https://github.com/yannickbattail/openscad-models/tree/main/CD_solar_oven/)

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --mosaicFormat 2,2 --configFile CD_solar_oven.yaml ./CD_solar_oven.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)

## License

[GPL](https://www.gnu.org/licenses/gpl-3.0.html)

[CC BY](https://creativecommons.org/licenses/by/4.0/)
