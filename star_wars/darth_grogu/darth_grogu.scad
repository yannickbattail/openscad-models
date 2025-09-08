yoda_color = "DarkSlateGray"; // [DarkSlateGray, black, MediumSeaGreen]
horn_color = "red"; // [red, DarkKhaki]

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated ? [0, 0, 0] : $vpt;
$vpr = is_animated ? [60, 0, animation_rotation ? (365 * $t) : 45] : $vpr; // animation rotate around the object
$vpd = is_animated ? 150 : $vpd;

// name of the horns (north south est west center)
//  nw  n  ne
//  w   c   e
//   sw   se
//      s

baby_yoda(yoda_color);
horns(horn_color);

module baby_yoda(yoda_color) {
  color(yoda_color)
    translate([0.25, 2, 0]) // center z axis in the head
      rotate([0, 0, 75]) // allign hears with x axis
        import("baby_yoda.3mf");
}

module horns(horn_color) {
  // name of the horns (north south est west center)
  //  nw  n  ne
  //  w   c   e
  //   sw   se
  //      s
  horn_list = [
    //horn translation      rotation
    [
      "n",
      [0, 80, -42],
      [-45, 0, 0]
    ],
    [
      "c",
      [0, 40, -16],
      [-20, 0, 0]
    ],
    [
      "s",
      [0, -40, -16],
      [20, 0, 0]
    ],
    [
      "w",
      [-86, -20, -55],
      [0, -80, 20]
    ],
    [
      "e",
      [86, -20, -55],
      [0, 80, -20]
    ],
    [
      "nw",
      [-45, 60, -38],
      [-35, -30, 0]
    ],
    [
      "ne",
      [45, 60, -38],
      [-35, 30, 0]
    ],
    [
      "sw",
      [-45, -25, -20],
      [20, -20, -20]
    ],
    [
      "se",
      [45, -25, -18],
      [20, 20, 20]
    ],
  ];
  for(i = [0:len(horn_list) - 1]) {
    color(horn_color) {
      difference() {
        translate([0, 0, 25]) {
          scale(0.05)
            translate(horn_list[i][1])
              rotate(horn_list[i][2])
                get_horn_by_name(horn_list[i][0]);
        }
        baby_yoda();
      }
    }
  }
}

module get_horn_by_name(horn) {
  import(str("gen/darth_maul_horns_", horn, ".3mf"));
}
