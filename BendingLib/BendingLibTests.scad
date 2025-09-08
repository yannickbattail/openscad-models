include <BendingLib.scad>

// part to show
part = "cat";
// [cat, pyramid_pentagon, pyramid_pentagon_anim_angle, pyramid_pentagon_anim_dist, pyramid_pentagon_anim_runover, cat_anim_angle, cat_anim_runover]
// bending angle
angle = 60; // [-360:10:360]
// remove runover part inside the bending
remove_runover_part = true;
// distance to center of rotation (translate the pyramid)
distance_to_center = 60; // [-100:100]


/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Resolution] */
// resolution/quality
$fn = 100;

/* [Hidden] */
is_animated = animation_rotation || (part != "cat" && part != "pyramid_pentagon");

if (part == "cat") {
  setViewPort();
  animation_cat();
} else if (part == "pyramid_pentagon") {
  setViewPort();
  pyramid_pentagon();
} else if (part == "pyramid_pentagon_anim_angle") {
  setViewPort();
  animation_pyramid(angle = $t * 60, descr = str("angle=", $t * 60));
} else if (part == "pyramid_pentagon_anim_dist") {
  setViewPort();
  animation_pyramid(distance_to_center = $t * 10, descr = str("distance=", $t * 10));
} else if (part == "pyramid_pentagon_anim_runover") {
  setViewPort(vpd = 50);
  animation_pyramid(remove_runover_part = $t > 0.5 ? true : false, angle = -60, descr = str("runover=", $t > 0.5 ? true : false));
} else if (part == "cat_anim_angle") {
  setViewPort();
  animation_cat(angle = $t * 60, descr = str("angle=", $t * 60));
} else if (part == "cat_anim_runover") {
  setViewPort();
  animation_cat(remove_runover_part = $t > 0.5 ? true : false, descr = str("runover=", $t > 0.5 ? true : false));
}

module setViewPort(vpt = [0, 0, 0], vpr = [60, 0, 0], vpd = 200) {
  if (is_animated) {
    $vpt = vpt;
    $vpr = animation_rotation ? [vpr[0], vpr[1], 365 * $t] : vpr; // animation rotate around the object
    $vpd = 200;
  }
}

module description(txt) {
  color("blue")
    translate([5, -5, 5])
      rotate([90, 0, 0])
        linear_extrude(1)
          text(txt, 3);
}

module animation_pyramid(angle = 60, remove_runover_part = true, distance_to_center = 0, descr = "???") {
  description(descr);
  pyramid_pentagon(angle, remove_runover_part, distance_to_center);
}

module animation_cat(angle = 60, remove_runover_part = true, descr = "???") {
  description(descr);
  cat(angle, remove_runover_part);
}

module pyramid_pentagon(angle, remove_runover_part, distance_to_center) {
  bend(angle, remove_runover_part, _big_value = 300)
    translate([distance_to_center, 0, 0])
      linear_extrude(50, scale = [0, 0], center = true)
        pentagon(r = 5);
}

module pentagon(r) {
  circle(r = r, $fn = 5);
}

module cat(angle, remove_runover_part) {
  bend(angle, remove_runover_part, _big_value = 300)
    rotate([0, 0, 180])
      translate([0, 0, -70])
        import("catLowPoly.stl");
}
