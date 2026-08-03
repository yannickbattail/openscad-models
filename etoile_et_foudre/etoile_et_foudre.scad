/* [éclaires] */
// Nombre d'éclaire
lightning_number = 4; // [1:20]
// Largeur des éclaires
lightning_width = 4; // [2:0.5:8]
// Espacement entre les éclaires
lightning_spacing = 15; // [1:90]
// Rotation des éclaires
lightning_init_rotation = 25; // [-100: 90]

/* [base] */
//  Forme de la base
base_form = "rectangle"; // [rectangle, ellipse, aucune]
//  Épaisseur de la base (0 = pas de base)
base_thickness = 5; // [0:20]
//  Hauteur de la base
base_height = 200; // [0:5:350]
//  Largeur de la base
base_width = 120; // [0:5:350]
//  Arrondi de la base
base_round = 20; // [0:1:200]


/* [Animation] */
// rotating animation
animation_rotation = false;

/* [hidden] */
$fn = 100;

faces = [face_1, face_2, face_3, face_4, face_5, face_6];
font_params = [font_size, font_type, font_halign, font_valign, font_spacing, font_direction, font_language, font_script];

$vpt = animation_rotation ? [0, 0, 0] : [];
$vpr = animation_rotation ? [70, 0, 365 * $t] : [];
$vpd = animation_rotation ? 300 : [];

star_and_lightning();


module star_and_lightning() {
  color("orange") {
    star();
    lightnings(lightning_number, lightning_width, lightning_spacing, lightning_init_rotation);
  }
  color("blue")
    base_right(base_form, base_round, base_height, base_width, base_thickness);
  color("black")
    mirror([1,0,0])
      base_right(base_form, base_round, base_height, base_width, base_thickness);
}

module star() {
  rotate([0, 0, 90]) {
    roof(method = "straight") {
      offset(1) {
        circle(d = 40, $fn = 3);
        rotate([0, 0, 180])
          circle(d = 40, $fn = 3);
      }
    }
  }
}

module lightning(r, lightning_width) {
  roof(method = "voronoi")
  offset(1)
    polygon([[48, 6], [34, -6], [24, 6], [3, 0], [2, 2], [25, 9], [34, -2], [48, 9], [60, -2], [73, 8], [70, 12], [87, 9], [72, 0], [73, 5], [60, -5]]);
}

module lightnings(lightning_number, lightning_width, lightning_spacing, init_rotation) {
  for (i = [0:1:lightning_number - 1]) {
    rotate([0, 0, lightning_spacing * i - init_rotation])
      lightning(1, lightning_width);
    mirror([1, 0, 0])
      rotate([0, 0, lightning_spacing * i - init_rotation])
        lightning(-1, lightning_width);
  }
}

module base_right(base_form, base_round, base_height, base_width, base_thickness) {
  difference() {
    base(base_form, base_round, base_height, base_width, base_thickness);
    translate([-200,0,0])
      cube(400, center=true);
  }
}

module base(base_form, base_round, base_height, base_width, base_thickness) {
  translate([0, 0, -base_thickness]) {
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
}
