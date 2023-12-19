serrated();

module serrated() {
  intersection() {
    step = 36;
    union() {
      for(i = [0:step]) {
        rotate([i * 360 / step, 0, 0])
          translate([0, 0, -10]) {
            linear_extrude(11, scale = [0, 0]) {
              rotate([0, 0, 45])
                square(1.5, center = true);
            }
          }
      }
    }
    rotate([0, 90, 0])
      cylinder(r = 10, h = 2, $fn = step * 2);
  }
}
