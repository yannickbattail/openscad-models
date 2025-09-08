# Darth Grogu a Sith version of Baby Yoda

Darth Grogu: a Sith version of Baby Yoda with Darth Maul horns

This is made with [Darth Maul horns](https://www.thingiverse.com/thing:3040798) and a [grumpy Grogu](https://www.thingiverse.com/thing:3988192)

## Update

- v2: use 3mf file format compatible with multiple colors, fix non-manifold original models and change generation of models animations and mosaic
- v1: 1st design

## How to print it

**⚠️Darth Maul horns are hollow and if you print him too small the horn will have issues, preview the generated gcode in your slicer. /!\ **

Material: *what you want*

Color: sith

Support: Yes

## Customizable variables

yoda_color = "#333333"; // MediumSeaGreen
horn_color = "red"; // DarkKhaki

- `yoda_color`: default "#333333", one of: DarkSlateGray, black or MediumSeaGreen
- `horn_color`: default red, one of: red or DarkKhaki

## Sources

Sources available [here](https://github.com/yannickbattail/openscad-models/tree/main/star_wars/darth_grogu)

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 3,3 --configFile horns.yaml ./horns.scad
npx openscad-generate@latest generate --outFormats png,webp,3mf --configFile darth_grogu.yaml ./darth_grogu.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)

## Other interesting designs

- [Grogu (baby yoda) mug, upcycling nutella glass](https://www.thingiverse.com/thing:6301972)
- [C3PO mug, upcycling nutella glass](https://www.thingiverse.com/thing:6296440)
- [blooming sith lightsaber](https://www.thingiverse.com/thing:5437311)
- [Jedi holocron box multi material](https://www.thingiverse.com/thing:6782529)
- [Star wars crate box](https://www.thingiverse.com/thing:7062418)

## License

[GPL](https://www.gnu.org/licenses/gpl-3.0.html)

[CC BY](https://creativecommons.org/licenses/by/4.0/)

## keywords

grogu, baby yoda, yoda, sith, darth maul, star_wars, openscad, customizable, customizer
