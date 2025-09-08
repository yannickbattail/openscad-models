
/* [text] */
line0 = "line0";
line1 = "line1";
line2 = "line2";

/* [resolution] */
// resolution
$fn = 10;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[50, 30, 0]:$vpt;
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:$vpr;  // animation rotate around the object
$vpd = is_animated?400:$vpd;

award([line0, line1, line2]);

module award(lines) {
  color("white")
    translate([0, 0, -50])
      cube([100, 62, 50]);
  color("white")
    mont_rose();
  color("blue")
    utmr_text(lines);
}

module utmr_text(lines) {
  translate([50, 0, 0]) {
    rotate([90, 0, 0]) {
      linear_extrude(2) {
        translate([0, -15])
          text(lines[0], size = 13, font = "Liberation Sans:style=Bold", halign = "center");
        translate([0, -30])
          text(lines[1], size = 9, font = "Liberation Sans:style=Bold", halign = "center");
        translate([0, -44])
          text(lines[2], size = 9, font = "Liberation Sans:style=Bold", halign = "center");
      }
    }
  }
}

module mont_rose() {
  import("./mont_rose.3mf");
}
