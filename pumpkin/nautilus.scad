$fn = 100;

steps = 20;

difference() {
  shell(steps);
  translate([0, 0, steps * 2])
    cube(steps * 4, center = true);
}

module shell(steps, a = 1) {
  side = 10;
  b = a > 10 ? a - 10 : 0;
  rotate([0, 0, 360 / side * a]) {
    translate([a + b, 0, 0])
      sphereShell(a);
  }
  if (a < steps)
    shell(a + 1);
}

module sphereShell(a) {
  difference() {
    sphere(a);
    sphere(a - 0.1);
    translate([0, a, 0])
      cube(a * 2, center = true);
  }
}
