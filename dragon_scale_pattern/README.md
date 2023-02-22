# Dragon scale pattern

Dragon scale in customisable pattern

Pattern can be
- square
- triangle_up
- triangle_down
- triangle_right
- triangle_left
- custom pattern defined in a matrix

## The custom pattern
the custom pattern is a table depict by a string of 0 and 1 with lines separated by a "|", 1=there is a scale, 0=nothing

### Examples of patterns

input string `0111|1101|1001|1111`
```
. X X X
X X . X
X . . X
X X X X
```
display (X = scale, . = nothing)

## credit

The scale is from https://www.thingiverse.com/thing:3470986 and I simplified the number of faces

## Sources

https://github.com/yannickbattail/openscad-models/tree/main/dragon_scale_pattern

## release note

- custom pattern as a string to be editable in the customizer and in thingiverse

## TODO

- offset on X and Y
