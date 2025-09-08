use <../common/mug.scad>
use <../nutellaGlass/nutellaGlass.scad>

/* [Mug] */
// nutella glass scale: grow nutella glass to better fit in
nutellaGlassScale = 1.01; // [0.99:1.05]

// Number of block
numberOfBlock = 6; // [0:none, 3:3, 4:4, 5:5, 6:6]

/* [Animation] */
// rotating animation
animation_rotation = false;

$fn = 100;

// cut the mug in quarter and display the nutella glass
debug = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated ? [0, 0, 0] : [];
$vpr = is_animated ? [60, 0, animation_rotation ? (365 * $t) : 45] : []; // animation rotate around the object
$vpd = is_animated ? 500 : [];

if (debug) {
  difference() {
    dragonEgg_mug();
    translate([-10, -200, 0])
      cube(200);
  }
} else {
  dragonEgg_mug();
}
module dragonEgg_mug() {
  difference() {
    union() {
      dragonEgg();
      translate([50, 0, 43])
        bigHandle(86);
    }
    translate([0, 0, 5]) {
      scale(1.01) {
        if (debug) {
          #nutellaGlass(plain = true, nbBlock = numberOfBlock);
        } else {
          nutellaGlass(plain = true, nbBlock = numberOfBlock);
        }
      }
      translate([0, 0, 92 + 100 - 10])
        cube(200, center = true);
    }
  }
}

module dragonEgg() {
  scale(2)
    translate([-2, 0, -0.6]) // center the model
      import("DragonEggSolid.stl");
}
