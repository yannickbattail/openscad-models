# Ahsoka's ball map

Ahsoka TV show ball map

## Update

- v1: 1st design

## How to print it

Material: *what you want*

Color: bronze

## Customizable variables

- `circlesRadius`: default 80
- `circlesDepth`: default 55
- `$fn`: resolution

## Sources

Sources available [here](https://github.com/yannickbattail/openscad-models/tree/main/ahsoka_ball_map)

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --outFormats png,webp,3mf --configFile ball_map.yaml ./ball_map.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)

## Other interesting designs

- [Jedi holocron box multi material](https://www.thingiverse.com/thing:6782529)
- [Star wars crate box](https://www.thingiverse.com/thing:7062418)

## License

license GPL

CC BY https://creativecommons.org/licenses/by/4.0/

## keywords

star_wars, Ahsoka, openscad, customizable, customizer
