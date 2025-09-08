// Part to generate
part = "tile"; // [tile, paving]

// Tile thickness
height = 1; // [0.5:0.5:10]

// Round the angles
rounding = 0.3; // [0:0.1:0.4]

// Shrink a little the tile
tolerence = 0.05; // [0:0.01:0.45]

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Resolution] */
// resolution/quality
$fn = 100;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated ? [0, 0, 0] : [];
$vpr = is_animated ? [60, 0, animation_rotation ? (365 * $t) : 45] : []; // animation rotate around the object
$vpd = is_animated ? 120 : [];


if (part == "paving") {
  paving(height, rounding, tolerence);
} else {
  roundedCatTile3D(height, rounding, tolerence);
}

module roundedCatTile3D(height, rounding, tolerence) {
  linear_extrude(height)
    roundedCatTile2D(rounding, tolerence);
}

module roundedCatTile2D(rounding, tolerence) {
  offset(rounding - tolerence)
    offset(-rounding)
      catTile2d();
}

module catTile2d() {
  poly = [
    [0, -2],
    [1, -1],
    [3, -1],
    [4, -2], // back
    [4, 2],
    [3, 3],
    [4, 4],
    [5, 3],
    [5, -3], // tail
    [6, -4],
    [3, -7], // ass
    [0, -7],
    [0, -6],
    [2, -6], // back leg
    [2, -5],
    [-1, -5], // belly
    [-3, -7],
    [-5, -5],
    [-3, -3], // front leg
    [-4, -2],
    [-4, 2],
    [-3, 1],
    [-1, 1],
    [0, 2] // head
  ];
  polygon(poly);
}

module paving(height, rounding, tolerence) {
  color("blue")
    roundedCatTile3D(height, rounding, tolerence);
  color("red")
    turn()
      roundedCatTile3D(height, rounding, tolerence);
  translate([2, -12, 0]) {
    color("green")
      roundedCatTile3D(height, rounding, tolerence);
    color("yellow")
      turn()
        roundedCatTile3D(height, rounding, tolerence);
  }
  translate([10, 0, 0]) {
    color("darkblue")
      roundedCatTile3D(height, rounding, tolerence);
    color("darkred")
      turn()
        roundedCatTile3D(height, rounding, tolerence);
    translate([2, -12, 0]) {
      color("darkgreen")
        roundedCatTile3D(height, rounding, tolerence);
      color("orange")
        turn()
          roundedCatTile3D(height, rounding, tolerence);
    }
  }
}

module turn() {
  rotate([0, 0, 180]) {
    children();
  }
}
