module bend(Angle, remove_runover_part = true, _big_value = 1000) {
  angle = Angle % 360;
  _bendStart(angle, remove_runover_part, _big_value)
    children(0);
  _bentPart(angle, remove_runover_part, _big_value)
    children(0);
  _bendEnd(angle, remove_runover_part, _big_value)
    children(0);
}

module _bentPart(angle, remove_runover_part, _big_value) {
  signe = angle > 0 ? 1 : -1;
  rotate([270, -angle, 0])
    rotate_extrude(angle = angle)
      difference() {
        projection(cut = true)
          children(0);
        translate([-signe * _big_value / 2, 0])
          square(_big_value, center = true);
      }
}

module _bendStart(angle, remove_runover_part, _big_value) {
  difference() {
    children(0);
    translate([0, 0, _big_value / 2])
      cube(_big_value, center = true);
    if (remove_runover_part) {
      rotate([0, -angle / 2, 0])
        translate([0, 0, _big_value / 2])
          cube(_big_value, center = true);
    }
  }
}

module _bendEnd(angle, remove_runover_part, _big_value) {
  rotate([0, -angle, 0])
    difference() {
      children(0);
      translate([0, 0, -_big_value / 2])
        cube(_big_value, center = true);
      if (remove_runover_part) {
        rotate([0, angle / 2, 0])
          translate([0, 0, -_big_value / 2])
            cube(_big_value, center = true);
      }
    }
}
