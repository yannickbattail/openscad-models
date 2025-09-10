# Customizable Rubber duck debugging

Duck toy for Rubber duck debugging ([explained on wikipedia](https://en.m.wikipedia.org/wiki/Rubber_duck_debugging))

Customizable with programming language written on it.

Available:

- PHP | <?php
- .NET | C#
- JAVA | ;-)
- Javascript | HTML/CSS
- CSS
- Typescript | async/await
- SQL | SELECT * FROM
- C/C++ | #include <>
- sh/bash | rm -Rf /
- OpenSCAD | cube(100);

## UPDATE

- v3: text in relief or in hole
- v2: inline stl file, for use in thingiverse customizer, add lowpoly duck
- v1: 1st design

## How to print it

Material: PLA or whatever you want

color: duck color or the language color

Parts:

- `all`: support Yes/No, rotate 180° color: yellow ???
- `ball`: support Yes/No, rotate 0° color: blue ???
- `stick`: support Yes/No, rotate 0° color: red ???

## Customizable variables

### Duck

- `lowpoly_duck`: use a low polygon number version of the duck

### Text left

- `text_string1`: text on left
- `text_out1`: text in relief or in hole
- `text_size1`: text on left size
- `text_position1`: text on left position [x,y,z]

### Text right

- `text_string2`: text on right
- `text_out2`: text in relief or in hole
- `text_size2`: text on right size
- `text_position2`: text on right position [x,y,z]

### Font

- `font_type`: *Liberation Mono:style=Regular*, The name of the font that should be used. This can also include a style parameter
- `font_spacing`: 1, Factor to increase/decrease the character spacing. The default value of 1 results in the normal spacing for the font, giving a
  value greater than 1 causes the letters to be spaced further apart.
- `font_direction`: ltr:left-to-right, rtl:right-to-left, ttb:top-to-bottom, btt:bottom-to-top Direction of the text flow.
- `font_language`: "en" The language of the text
- `font_script`: "latin" The script of the text

## Sources

Sources available [here](https://github.com/yannickbattail/openscad-models/tree/main/rubberDuckDebugging/)

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 2,2 --configFile RubberDuckDebugging.yaml ./RubberDuckDebugging.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)

## License

[GPL](https://www.gnu.org/licenses/gpl-3.0.html)

[CC BY](https://creativecommons.org/licenses/by/4.0/)

## keywords

duck, Rubber Ducky, rubber duck, Debugger, Rubber Ducky, Debugging, openscad, customizable, customizer
