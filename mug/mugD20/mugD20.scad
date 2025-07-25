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
$vpt = is_animated?[0, 0, 0]:[];
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:[]; // animation rotate around the object
$vpd = is_animated?500:[];

if (debug) {
  difference() {
    d20_mug();
    translate([-10, -200, 0]) cube(200);
  }
} else {
  d20_mug();
}

module d20_mug() {
  difference() {
    union() {
      d20();
      translate([60, 0, 40])
        bigHandle(80);
    }
    translate([0, 0, 5]) {
      scale(1.01) {
        if (debug) {
          #nutellaGlass(plain = true, nbBlock = numberOfBlock);
        } else {
          nutellaGlass(plain = true, nbBlock = numberOfBlock);
        }
      }
      // cut the top of the model
      translate([0, 0, 92 + 100])
        cube(200, center = true);
    }
    // cut the bottom of the model
    translate([0, 0, -100])
      cube(200, center = true);
  }
}

module d20() {
  translate([0, 0, 45])
    // make the face 20 in front of you and face 1 in front of the others when holding the mug in the right hand
    rotate([0, 60+180, -90])
      scale(5.4)
        import("d20.stl");
}
