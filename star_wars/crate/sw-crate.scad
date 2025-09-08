// part to generate
part = "full"; // [full, all, top, bottom]

// thickness of the box
thickness = 1; // [1:0.2:10]

/* [resolution] */
// resolution
$fn = 100;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated ? [0, 0, 0] : $vpt;
$vpr = is_animated ? [60, 0, animation_rotation ? (365 * $t) : 45] : $vpr; // animation rotate around the object
$vpd = is_animated ? 700 : $vpd;
// epsilon for floating point precision issues
epsi = 0.01;

crate(part, thickness);

module crate(part, thickness) {
  wholeSize = 100; // size of the full crate
  depth = 6;
  width = 6;
  radius = 20;
  if (part == "full") {
    full(thickness, width, depth, radius, wholeSize);
  } else if (part == "top") {
    top(thickness, width, depth, radius, wholeSize);
  } else if (part == "bottom") {
    bottom(thickness, width, depth, radius, wholeSize);
  } else if (part == "all") {
    translate([0, 0, wholeSize])
      top(thickness, width, depth, radius, wholeSize);
    bottom(thickness, width, depth, radius, wholeSize);
  } else {
    assert(false, "Invalid part specified. Use 'top', 'bottom', or 'full'.");
  }
}
every_faces = [
  [0, 0, 0], // 1 top
  [90, 0, 0], // 2 front
  [90, 0, 90], // 3 right
  [90, 0, -90], // 4 left
  [-90, 0, 0], // 5 back
  [180, 0, 0] // 6 bottom
];

module full(thickness, width, depth, radius, wholeSize) {
  difference() {
    cube(wholeSize, center = true);
    for(i = [0:len(every_faces) - 1]) {
      rotate(every_faces[i])
        translate([0, 0, wholeSize / 2 + epsi])
          face(width, depth, radius, wholeSize);
    }
  }
}

module top(thickness, width, depth, radius, wholeSize) {
  difference() {
    full(thickness, width, depth, radius, wholeSize);
    // hollow out
    cube(wholeSize - depth * 2 - thickness * 2, center = true);
    // remove the bottom
    translate([0, 0, -wholeSize / 2])
      cube(wholeSize + epsi, center = true);
    for(i = [1:4]) {
      rotate(every_faces[i])
        translate([0, 0, wholeSize / 2 + epsi])
          translate([0, 0, -depth + epsi]) {
            linear_extrude(depth) {
              #circle(r = radius - width + epsi);
            }
          }
    }
  }
}

module bottom(thickness, width, depth, radius, wholeSize) {
  union() {
    difference() {
      full(thickness, width, depth, radius, wholeSize);
      // hollow out
      cube(wholeSize - depth * 2 - thickness * 2, center = true);
      // remove the top
      translate([0, 0, wholeSize / 2])
        cube(wholeSize + epsi, center = true);
    }
    for(i = [1:4]) {
      rotate(every_faces[i])
        translate([0, 0, wholeSize / 2 + epsi])
          translate([0, 0, -depth + epsi]) {
            linear_extrude(depth) {
              #circle(r = radius - width + epsi);
            }
          }
    }
  }
}

module face(width, depth, radius, wholeSize) {
  translate([0, 0, -depth + epsi]) {
    linear_extrude(depth) {
      for(i = [0:90:270]) {
        rotate([0, 0, i])
          translate([wholeSize / 4 - 1 + radius, 0, 0])
            square([wholeSize / 2, width], center = true);
      }
      difference() {
        circle(r = radius);
        circle(r = radius - width);
      }
    }
  }
}
