// color of the emblem
emblemColor = "red"; // [#7F1617:red, green:green]
// thickness of the emblem
emblemThikness = 2; // [1:10]
// thickness of the emblem (0 = none)
baseThikness = 5; // [0:10]
// thickness of the emblem
baseRounding = 10; // [1:20]
// 3D model or 2D model
model3d = true;

/* [Animation] */
// resolution
$fn = 200;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated ? [0, 0, 0] : $vpt;
$vpr = is_animated ? [60, 0, animation_rotation ? (365 * $t) : 45] : $vpr; // animation rotate around the object
$vpd = is_animated ? 400 : $vpd;

if (model3d) {
  Medical_emblem(emblemColor, emblemThikness, baseThikness, baseRounding);
} else {
  Medical_emblem2d(emblemColor, baseRounding);
}

module Medical_emblem(emblemColor, emblemThikness, baseThikness, baseRounding) {
  color(emblemColor)
    linear_extrude(emblemThikness) {
      Medical_emblem_baseForms();
      //Medical_emblem_polygon();
      Medical_emblem_circle();
    }
  color("white")
    translate([0, 0, -baseThikness])
      linear_extrude(baseThikness) {
        base(baseRounding);
      }
}

module Medical_emblem2d(emblemColor, baseRounding) {
  color(emblemColor) {
    Medical_emblem_baseForms();
    //Medical_emblem_polygon();
    Medical_emblem_circle();
  }
}

module Medical_emblem_baseForms() {
  color("#7F1617") {
    union() {
      translate([-15, -10])
        square([21, 52]);
      translate([-40, -10])
        square([45, 24]);
      translate([-5, -10])
        square([45, 12]);
      translate([5, -35])
        square([12, 36]);
      translate([5, -35])
        polygon([
          [0, 0],
          [12, 0],
          [0, -8]
        ]);

      translate([15, 10])
        square([12, 12]);
      translate([-23, -31])
        square([12, 12]);
      translate([3, -3])
        rotate([0, 0, -42])
          square([3, 50], center = true);
    }
  }
}

module Medical_emblem_circle() {
  color("#7F1617") {
    difference() {
      circle(50);
      circle(46);
    }
  }
}

module Medical_emblem_polygon() {
  color("green") {
    mirror([0, 1]) {
      polygon(points = [
        [17, 10],
        [40, 10],
        [40, -2],
        [9.52047, -2],
        [16.7237, -10],
        [27, -10],
        [27, -22],
        [15, -22],
        [15, -12.5691],
        [6, -2.57355],
        [6, -42],
        [-15, -42],
        [-15, -14],
        [-40, -14],
        [-40, 10],
        [-5.32128, 10],
        [-13.4249, 19],
        [-23, 19],
        [-23, 31],
        [-11, 31],
        [-11, 20.7903],
        [-1.28438, 10],
        [5, 10],
        [5, 43],
        [17, 35]
      ]);
    }
  }
}

module base(baseRounding) {
  offset(baseRounding)
    offset(-baseRounding)
      square(50 * 2 + 10, center = true);
}
