part = "manche"; // [all, manche, partie1, partie2, partie3]

if (part == "all") {
  wand("manche");
  wand("partie1");
  wand("partie2");
  wand("partie3");
} else {
  wand(part);
}

module wand(part) {
  scale(20) {
    import(str("cthulhu-wand_", part, "_fixed.stl"));
  }
}
