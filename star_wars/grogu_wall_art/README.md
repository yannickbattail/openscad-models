# Grogu wall art

Cute Grogu wall art

## UPDATE

- v4 bigger hook
- v3 grogu string: customizable hook position
- v2 grogu string: grogu with hook up and down
- v1 grogu

## How to print it

Material: *what you want*

Color: yoda green

Support: No

## customizable variables

- `bothSides`: default false;
- `thickness`: default 1, between 1 and 10 step 0.1
- `thicknessBase` default 1, between 0 and 10 step 0.1
- `hookPosition` default "both", values: both, top, bottom, none

## Sources

Sources available [here](https://github.com/yannickbattail/openscad-models/tree/main/star_wars/grogu_wall_art)

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 3,2 --configFile grogu.yaml ./grogu.scad
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

star_wars, grogu, baby_yoda, wall_art, 2D, openscad, customizable, customizer
