// part to generate
part = "manche"; // [manche, partie1, partie2, partie3]

// from fixed stl or else from obj
from_fixed_stl = false;


if (from_fixed_stl)
  import(str("cthulhu-wand_", part, "_fixed.stl"));
else
  import(str(part, ".obj"));
