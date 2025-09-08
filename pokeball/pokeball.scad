
/* [Animation] */
// Animation rotation
animation_rotation = false;

/* [Hidden] */
$vpt = animation_rotation?[4, 3, 15]:$vpt;
$vpr = animation_rotation?[60, 0, 365 * $t]:$vpr; // animation rotate around the object
$vpd = animation_rotation?500:$vpd;

$fn=100;

pokeball("red", "white", "black", "white", "white");

module pokeball(top_color, bottom_color, insides_color, button_color_out, button_color_int) {
    difference() {
        _half_spheres(top_color, bottom_color);
        _equator_hole();
    }
    _insides(insides_color);
    _button(button_color_out, button_color_int);
}

module _half_spheres(top_color, bottom_color) {
    difference() {
        color(top_color) sphere(r=10);
        translate([0,0,-5]) cube(size=[20, 20, 10], center=true);
    }
    translate([0,0,-0.1]) // workaround for the color
    difference() {
        color(bottom_color) sphere(r=10);
        translate([0,0, 5]) cube(size=[20, 20, 10], center=true);
    }
}

module _equator_hole() {
    cube(size=[20, 20, 2], center=true);
    translate([10, 0, 0]) 
        rotate([0, 90, 0]) 
            cylinder(r=4, h=3, center=true);
}

module _insides(equator_color) {
    color(equator_color)
    sphere(r=9.5);
}

module _button(color_out, color_int) {
    translate([9, 0, 0]) rotate([0, 90, 0]) {
        color(color_out) cylinder(r=3, h=1, center=true);
        color(color_int) cylinder(r=2, h=2, center=true);
    }
}

