module mug(height, radius, thickness, hasBigHandle = true, hasHolder = true, holderAngle = 30) {
  epsi = 0.01; // epsilon
  difference() {
    union() {
      cylinder(h = height, r = radius);
      // rounded top
      translate([0, 0, height]) {
        torus(radius - thickness / 2, thickness / 2);
      }
      translate([radius * 1.2, 0, height / 2]) {
        if (hasBigHandle) {
          bigHandle(height);
        } else {
          handle(height);
        }
      }
      if (hasHolder) {
        rotate([0, 0, holderAngle])
          holder(height, radius);
      }
    }
  }
}

module holder(height, radius) {
  translate([radius - 5, 0, height - 7]) {
    rotate([0, 0, 90])
      mmirror([1, 0, 0]) {
        rotate([0, 0, 45])
          translate([0, -10, 0])
            holderPart();
      }
  }
}

module holderPart() {
  difference() {
    cube([14, 3, 14], center = true);
    rotate([0, -45, 0])
      translate([-10, 0, 0])
        cube([20, 20, 20], center = true);
    rotate([0, 0, 90-10])
      translate([-10, 0, 0])
        cube([20, 20, 20], center = true);
  }
}

module handle(height) {
  scale([0.4, 1.2, 0.65]) {
    rotate([90, 0, 0]) {
      torus(height / 2, 8);
    }
  }
}

module bigHandle(height) {
  difference() {
    scale([0.45, 1.0, 0.86]) {
      rotate([90, 0, 0]) {
        torus(height / 2, 8);
      }
    }
    translate([0, 0, -50 - height / 2])
      cube(100, center = true);
  }
}

module torus(radius, thickness) {
  rotate_extrude() {
    translate([radius, 0])
      circle(r = thickness);
  }
}

/*
same as mirror but duplicate children
*/
module mmirror(mat) {
  children();
  mirror(mat)
    children();
}
