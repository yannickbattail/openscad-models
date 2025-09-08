/* [éclaires] */
// Nombre d'éclaire
lightning_number = 5; // [1:20]
// Largeur des éclaires
lightning_width = 4; // [2:0.5:8]
// Espacement entre les éclaires
lightning_spacing = 15; // [1:90]
// Rotation des éclaires
lightning_init_rotation = 15; // [-100: 90]

/* [base] */
//  Forme de la base
base_form = "rectangle"; // [rectangle, ellipse, aucune]
//  Épaisseur de la base (0 = pas de base)
base_thickness = 5; // [0:20]
//  Hauteur de la base
base_height = 300; // [0:5:350]
//  Largeur de la base
base_width = 200; // [0:5:350]
//  Arrondi de la base
base_round = 50; // [0:1:200]
//  Couleur de la base
base_color = "blue"; // [blue:bleu, #222222:noir]

star_and_lightning();

module star_and_lightning() {
  color("orange")
    star_3d(5, point_len = 30, adjust = 0, pnt_h = 4, cent_h = 6, rnd = 1);
  color("orange")
    lightnings(lightning_number, lightning_width, lightning_spacing, lightning_init_rotation);
  color(base_color)
    base(base_form, base_round, base_height, base_width, base_thickness);
}

/*
star with raised center.

points = num points on star (should be >3. Using 3 may require addisional adjust be applied.)
point_len = len of point on star  (actual len of point will add  1/2 rnd to the length.)
adjust = +/- adjust of width of point
pnt_h = height of star at end of point
cent_h = height of star in center needs to be > pnt_h to have effect.
rnd = roundness of end of point (diameter)
*/
module star_3d(points, point_len, adjust = 0, pnt_h = 1, cent_h = 1, rnd = 0.1) {
  point_deg = 360 / points;
  point_deg_adjusted = point_deg + (-point_deg / 2) + adjust;

  for(i = [0:points - 1]) {
    rotate([0, 0, i * point_deg])
      translate([0, -point_len, 0])
        star_point(point_deg_adjusted, point_len, rnd, pnt_h, cent_h);
  }

}

module star_point(deg, leng, rnd, h1, h2) {
  hull() {
    cylinder(h1, d = rnd);
    translate([0, leng, 0])
      cylinder(h2, d = .001);
    rotate([0, 0, -deg / 2])
      translate([0, leng, 0])
        cylinder(h1, d = rnd);
    rotate([0, 0, deg / 2])
      translate([0, leng, 0])
        cylinder(h1, d = rnd);
  }
}

module arm(length, width) {
  translate([0, length / 2, 0])
    difference() {
      rotate([0, 45, 0])
        cube([width, length, width], true);
      translate([0, 0, -width])
        cube([width * 2, length, width * 2], true);
    }
}

module lightning(r, lightning_width) {
  translate([0, 0, 0])
    rotate([0, 0, r * 90])
      arm(40, lightning_width);
  translate([r * -40, -2, 0])
    rotate([0, 0, r * -20])
      arm(15, lightning_width);
  translate([r * -34, 11, 0])
    rotate([0, 0, r * 90])
      arm(40, lightning_width);
  translate([r * -74, 10, 0])
    rotate([0, 0, r * -20])
      arm(15, lightning_width);
  translate([r * -69, 23, 0])
    rotate([0, 0, r * 90])
      arm(40, lightning_width);
  rotate([0, 0, r * 270])
    translate([r * -23, -130, 0])
      star_point(36, 25, 1, 2, 4);
}

module lightnings(lightning_number, lightning_width, lightning_spacing, init_rotation) {
  for(i = [0:1:lightning_number - 1]) {
    rotate([0, 0, lightning_spacing * i - init_rotation])
      lightning(1, lightning_width);
    rotate([0, 0, -lightning_spacing * i + init_rotation])
      lightning(-1, lightning_width);
  }
}

module base(base_form, base_round, base_height, base_width, base_thickness) {
  translate([0, 0, -base_thickness])
    linear_extrude(base_thickness) {
      if (base_form == "rectangle") {
        offset(r = base_round)
          square([base_height - base_round * 2, base_width - base_round * 2], center = true);
      } else if (base_form == "ellipse") {
        resize([base_height, base_width])
          circle(d = 100);
      }
    }
}
