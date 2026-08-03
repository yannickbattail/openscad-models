# etoile_et_foudre

Emblème de filière ingénieur: étoile et foudre

## UPDATE

- v2: simplify code and use function roof()
- v1: 1st design

## How to print it

Material: whatever you want

support: No

## Customizable variables

part default "all", part to generate: all, ball, stick

- `lightning_number`: default 4, Nombre d'éclaire
- `lightning_width`: default 4, Largeur des éclaires
- `lightning_spacing`: default 15, Espacement entre les éclaires
- `lightning_init_rotation`: default 25, Rotation des éclaires
- `base_form`: default "rectangle", Forme de la base
- `base_thickness`: default 5, Épaisseur de la base (0 = pas de base)
- `base_height`: default 200, Hauteur de la base
- `base_width`: default 120, Largeur de la base
- `base_round`: default 20, Arrondi de la base

## Sources

Sources available [here](https://github.com/yannickbattail/openscad-models/tree/main/etoile_et_foudre)

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --mosaicFormat 2,2 --configFile etoile_et_foudre.yaml ./etoile_et_foudre.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)

## Other interesting designs

- [something](https://www.thingiverse.com/thing:0000000) ???

## License

[GPL](https://www.gnu.org/licenses/gpl-3.0.html)

[CC BY](https://creativecommons.org/licenses/by/4.0/)

## keywords

- Ingénieur
- Ingé
- étoile
- foudre
- faluche
- OpenSCAD
- customizable
- customizer
