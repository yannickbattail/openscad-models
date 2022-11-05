// rounding of the dice
rounding = 0.69; // [0.6:0.01:0.8]
// hole size/depth
hole_size = 0.56; // [0.5:0.01:0.591]
// dice color
dice_color = "yellow"; // [yellow, red, green, blue, white, black]
// holes color
holes_color = "red"; // [yellow, red, green, blue, white, black]

/* [Animation] */
// Animation rotation
animation_rotation = false;

/* [Hidden] */
$vpt = animation_rotation?[0, 0, 0]:$vpt;
$vpr = animation_rotation?[60, 0, 365 * $t]:$vpr; // animation rotate around the object
$vpd = animation_rotation?200:$vpd;

$fn = 40;
scale(50) dice(rounding, hole_size, dice_color, holes_color);
module dice(rounding, face, dice_color, holes_color) {
    difference() {
        color(dice_color) intersection() {
            cube(1, center = true);
            sphere(rounding);
        }
        color(holes_color) {
            c = 0.22;
            rotate([0, 0, 0]) translate([0, 0, face]) {// 1
                translate([0, 0, 0]) sphere(0.1);
            }
            rotate([180, 0, 0]) translate([0, 0, face]) {// 6
                translate([c, c, 0]) sphere(0.1);
                translate([c, 0, 0]) sphere(0.1);
                translate([c, - c, 0]) sphere(0.1);
                translate([- c, c, 0]) sphere(0.1);
                translate([- c, 0, 0]) sphere(0.1);
                translate([- c, - c, 0]) sphere(0.1);
            }
            rotate([90, 0, 0]) translate([0, 0, face]) {// 2
                translate([c, c, 0]) sphere(0.1);
                translate([- c, - c, 0]) sphere(0.1);
            }
            rotate([- 90, 0, 0]) translate([0, 0, face]) {// 5
                translate([0, 0, 0]) sphere(0.1);
                translate([c, c, 0]) sphere(0.1);
                translate([- c, c, 0]) sphere(0.1);
                translate([c, - c, 0]) sphere(0.1);
                translate([- c, - c, 0]) sphere(0.1);
            }
            // remove the all #
            rotate([90, 0, 90]) translate([0, 0, face]) {// 3
                #translate([c, c, 0]) sphere(0.1);
                #translate([0, - 0, 0]) sphere(0.1);
                #translate([- c, - c, 0]) sphere(0.1);
            }
            rotate([90, 0, - 90]) translate([0, 0, face]) {// 4
                #translate([c, c, 0]) sphere(0.1);
                #translate([- c, c, 0]) sphere(0.1);
                #translate([c, - c, 0]) sphere(0.1);
                #translate([- c, - c, 0]) sphere(0.1);
            }
        }
    }
}
