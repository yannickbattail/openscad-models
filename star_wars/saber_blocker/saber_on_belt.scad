
//bade size: 1 inch or 7/8 inch
blade_size = 1; // [1:1 inch, 0.875: 7/8 inch]

// tolerance space between the blade hole and blade
tolerance = 2; // [0.2:0.1:5]

// resolution
$fn = 200;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated ? [0, 0, 0] : $vpt;
$vpr = is_animated ? [60, 0, animation_rotation ? (365 * $t) : 45] : $vpr; // animation rotate around the object
$vpd = is_animated ? 200 : $vpd;

// Constant Epsilon
EPSI = 0.01;
// constant Inch in mm
INCH = 25.4;

saberSupport(blade_size, tolerance);

module saberSupport(blade_size, tolerance) {
  height=5;
  translate([0,0,height/2])
    scale([1,1,0.9])
      roof(method = "voronoi")
        base2dForm(blade_size, tolerance);
  linear_extrude(height, center=true) {
    base2dForm(blade_size, tolerance);
  }
}

module base2dForm(blade_size, tolerance) {
  bladeDiameter = blade_size * INCH;
  hole = bladeDiameter + tolerance;
  difference() {
    union() {
      translate([-hole / 2 - 5, 0])
        offset(2)
          square([8, 14], center = true);
      circle(d = hole + 10, $fn = 100);
    }
    // blade hole
    circle(d = hole);
    //strap hole
    translate([-hole / 2 - 5, 0])
      offset(1)
        square([2, 8], center = true);

  }
}
