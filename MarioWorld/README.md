# Build your Mario world

## Customization


- `worldLineXX` : Each worldLine is a list of characters, each character is a tile. worldLine1 is the floor and worldLine12 is the top of the sky.
- `background` : add a background to the MarioWorld
- `backgroundThickness` : thickness of background (between 1 and 32, 32 is twice the size of a tile)
- `backgroundHeight` : height of background in tile (a tile is 16pixel or mm) (reduce it if you don't put tile to the top de the MarioWorld)

## Tiles

List of the tiles:

Characters
- `M`: mario

Enemies
- `g`: gumba
- `k`: koopa
- `p`: piranha_plant

Items
- `c`: coin
- `F`: flower
- `m`: mushroom
- `s`: star

Blocks
- `1`: floor1
- `2`: floor2
- `e`: empty
- `q`: question
- `?`: question
- `w`: wall

Tubes
- `T`: big_tube_top
- `U`: big_tube_bottom
- `t`: tube_top
- `u`: tube_bottom

Decor
- `f`: fence
- `B`: bush
- `C`: cloud

Debug
- `x`: tileFull
- `0`: tileHollow

## Example

See preset file `MarioWorld.json` for example, there is the full level1 of super mario.

Sources: https://github.com/yannickbattail/openscad-models/tree/main/MarioWorld
