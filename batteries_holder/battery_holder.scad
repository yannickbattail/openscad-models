/* [battery holder] */
// form of the base
bh_base_form = "rounded"; // [round:round, square:square, rounded:rounded square]
// diameter of the round base
bh_round_base_diameter = 24; // [21:28]
// width of the square base
bh_square_base_width = 20; // [17:24]
// height of the base
bh_height = 5.0; // [1:10]
// total height of the base
bhh_height = 10; // [3:20]

/* [batteries] */
// battery dimention  from wikipedia 10.5mm × 44.5mm

// battery radius
battery_radius = 5.25; // [4.80:0.05:6]
// battery height
battery_height = 44.5; // [43:0.05:46]
// distance between batteries (battery radius)
battery_pos = 5.05; // [4.80:0.05:6]
// show batteries and top battery holder
show_battery = true;

/* [Hidden] */
// epsilon constant
epsi = 0.001;

$fn = 100;

battery_holder();
if (show_battery) {
  translate([0, 0, battery_height + 1 + 2 * bh_height])
    rotate([180, 0, 90])
      battery_holder();
  color("blue", 0.5) {
    translate([battery_pos, battery_pos, bh_height])
      battery();
    translate([-battery_pos, battery_pos, bh_height])
      battery();
    translate([battery_pos, -battery_pos, bh_height])
      battery();
    translate([-battery_pos, -battery_pos, bh_height])
      battery();
  }
}

module battery() {
  cylinder(r = battery_radius - epsi, h = battery_height - epsi, center = false);
  translate([0, 0, battery_height])
    cylinder(r = 3.5 / 2, h = 1, center = false);
}

module battery_holder() {
  difference() {
    if (bh_base_form == "round") {
      cylinder(r = bh_round_base_diameter / 2, h = bhh_height, center = false);
    } else if (bh_base_form == "square") {
      translate([0, 0, bhh_height / 2])
        cube([bh_square_base_width, bh_square_base_width, bhh_height], center = true);
    } else if (bh_base_form == "rounded") {
      intersection() {
        translate([0, 0, bhh_height / 2])
          cube([bh_square_base_width, bh_square_base_width, bhh_height], center = true);
        cylinder(r = bh_round_base_diameter / 2, h = bhh_height, center = false);
      }
    }
    translate([battery_pos, battery_pos, 0])
      hole();
    translate([-battery_pos, battery_pos, 0])
      hole();
    translate([battery_pos, -battery_pos, 0])
      hole();
    translate([-battery_pos, -battery_pos, 0])
      hole();
    translate([battery_pos, 0, 0])
      cube([4, battery_pos + 2, bh_height + epsi], center = true);
    translate([-battery_pos, 0, 0])
      cube([4, battery_pos + 2, bh_height + epsi], center = true);
  //translate([ 0, battery_pos, bh_height]) cube([battery_pos+2,4,bh_height+epsi], center=true);
  //translate([0, -battery_pos, bh_height]) cube([battery_pos+2,4,bh_height+epsi], center=true);
  }
//cylinder(r=1.8, h=battery_height, center=false);
}

module hole() {
  translate([0, 0, bh_height / 2])
    cube([4, 4, bh_height + epsi], center = true);
  translate([0, 0, bh_height]) {
    cylinder(r = battery_radius, h = bhh_height - bh_height + epsi, center = false);
  }
}
