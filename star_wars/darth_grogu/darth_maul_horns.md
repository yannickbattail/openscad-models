# Darth Maul horns

This is remix of [Darth Maul horns](https://www.thingiverse.com/thing:3040798) but horns in separated files.

```
name of the horns (north south est west center)
nw  n  ne
w   c   e
sw     se
    s
```

## Update

- v2: use 3mf file format compatible with multiple colors, fix non-manifold original models and change generation of models animations and mosaic
- v1: 1st design

## Customizable variables

- `horn_name`: name of the horns (north south est west center) [all, n, c, s, w, e, nw, ne, sw, se]
- `debug`: false

## Sources

Sources available [here](https://github.com/yannickbattail/openscad-models/tree/main/star_wars/darth_grogu)

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 3,3 --configFile darth_maul_horns.yaml ./darth_maul_horns.scad
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

sith, darth maul, horns, star_wars, openscad, customizable, customizer
