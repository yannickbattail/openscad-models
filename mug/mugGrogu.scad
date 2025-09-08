use <mug.scad>
use <nutellaGlass.scad>

/* [Mug] */
// nutella glass scale: grow nutella glass to better fit in
nutellaGlassScale = 1.01; // [0.99:1.05]

/* [Animation] */
// rotating animation
animation_rotation = false;

$fn = 100;

// cut the mug in quarter and display the nutella glass
debug = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:[];
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:[]; // animation rotate around the object
$vpd = is_animated?500:[];

if (debug) {
    difference() {
        mugGrogu();
        translate([- 10, - 200, 0]) cube(200);
    }
} else {
    mugGrogu();
}

module mugGrogu() {
    difference() {
        union() {
            grogu();
            translate([70, 0, 46])
                handle(100);
        }
        translate([0, 0, 5]) {
            scale(1.01) {
                if (debug) {
                    #nutellaGlass();
                } else {
                    nutellaGlass();
                }
            }
        }
    }
}

module grogu() {
    translate([10, 8, 0])
        rotate([0, 0, - 93])
            scale(1.9)
                import("resources/groguHead.3mf");
}
