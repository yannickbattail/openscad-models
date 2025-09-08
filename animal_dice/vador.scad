h = -41; // [-50:-40]
r = 6;
difference() {
  import("animals/Darth_Vader.stl");
  translate([0, 0, h])
    rotate([r, 0, 0])
      #cube(101, center = true);
}
