// part to generate
part = "full"; // [full, all, top, bottom, debug]

// thickness of the box
thickness = 2; // [1:0.2:10]

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
  } else if (part == "debug") {
    intersection() {
      top(thickness, width, depth, radius, wholeSize);
      bottom(thickness, width, depth, radius, wholeSize);
    }
  } else {
    assert(false, "Invalid part specified. Use 'top', 'bottom', 'debug', or 'full'.");
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

module full(thickness, width, depth, radius, wholeSize, withCircle = true) {
  for (i = [0:len(every_faces) - 1]) {
    rotate(every_faces[i])
      translate([0, 0, wholeSize / 2])
        if (i == 0 || i == 5)
        face(width, depth, radius, wholeSize, true);
        else
        face(width, depth, radius, wholeSize, withCircle);
  }
}

module top(thickness, width, depth, radius, wholeSize) {
  difference() {
    full(thickness, width, depth, radius, wholeSize, false);
    // hollow out
    cube(wholeSize - depth * 2 - thickness * 2 + epsi, center = true);
    // remove the bottom
    translate([0, 0, -wholeSize / 2])
      cube(wholeSize + epsi, center = true);
    sideCircles(width, depth, radius, wholeSize, false);
  }
}

module bottom(thickness, width, depth, radius, wholeSize) {
  union() {
    difference() {
      full(thickness, width, depth, radius, wholeSize);
      // hollow out
      cube(wholeSize - depth * 2 - thickness * 2 + epsi, center = true);
      // remove the top
      translate([0, 0, wholeSize / 2])
        cube(wholeSize + 2 * epsi, center = true);
    }
    sideCircles(width, depth, radius, wholeSize, true);
  }
}

module sideCircles(width, depth, radius, wholeSize, hollow = false) {
  for (i = [1:4]) {
    rotate(every_faces[i])
      sideCircle(width, depth, radius, wholeSize, hollow);
  }
}

module sideCircle(width, depth, radius, wholeSize, hollow) {
  translate([0, 0, wholeSize / 2])
    translate([0, 0, -depth - epsi]) {
      difference() {
        cylinder(r = radius - width + epsi, h = depth + 2 * epsi);
        if (hollow) {
          translate([0, 0, -epsi])
            cylinder(r = radius - width - thickness + epsi, h = depth - thickness);
        }
      }
    }
}

module face(width, depth, radius, wholeSize, withCircle) {
  difference() {
    union() {
      translate([0, 0, -depth]) {
        linear_extrude(depth) {
          face2D(width, depth, radius, wholeSize, withCircle);
        }
        translate([0, 0, -thickness / 2])
          cube([wholeSize - depth * 2, wholeSize - depth * 2, thickness], center = true);
      }
    }
    translate([0, 0, -depth - thickness]) {
      linear_extrude(depth) {
        offset(-thickness)
          face2D(width, depth, radius, wholeSize, withCircle);
      }
    }
  }
}

module face2D(width, depth, radius, wholeSize, withCircle) {
  difference() {
    square(wholeSize, center = true);
    for (i = [0:90:270]) {
      rotate([0, 0, i])
        translate([wholeSize / 4 - 1 + radius, 0, 0])
          square([wholeSize / 2, width], center = true);
    }
    difference() {
      circle(r = radius);
      if (withCircle) {
        circle(r = radius - width);
      }
    }
  }
}
