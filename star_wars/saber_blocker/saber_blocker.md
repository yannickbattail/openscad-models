# Light saber blocker

On some cosplay you buy on the internet you have a pocket on the belt with a hole to put your lightsaber. see the image:

![belt image](belt.jpg)

But after a few try the lightsaber enlarge the hole and goes through it.
So I create a part that you put in the poket to stop the whole light saber going through the hole.

## Update

- v1: 1st design

## How to print it

Material: *what you want*

Color: *what you want*

## customizable variables

- `d`: whole part curve (diameter)
- `h`: height of the part
- `l`:length of the part
- `thickness`: thickness of the tube
- `tolerance`: tolerance space between the tube and blade

## Sources

Sources available [here](https://github.com/yannickbattail/openscad-models/tree/main/star_wars/saber_blocker)

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 2,2 --configFile sw-crate.yaml ./sw-crate.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)

## Other interesting designs

- [Jedi holocron box multi material](https://www.thingiverse.com/thing:6782529)

## License

[GPL](https://www.gnu.org/licenses/gpl-3.0.html)

[CC BY](https://creativecommons.org/licenses/by/4.0/)

## Keywords

star_wars, crate, box, openscad, 3D model, customizable, customizer
