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
        c3po_mug();
        translate([- 10, - 200, 0]) cube(200);
    }
} else {
    c3po_mug();
}

module c3po_mug() {
    difference() {
        union() {
            c3po();
            translate([58, 0, 66])
                handle(120);
        }
        translate([0, 0, 30]) {
            scale(1.01) {
                if (debug) {
                    #nutellaGlass();
                } else {
                    nutellaGlass();
                }
            }
            translate([0, 0, 92 + 100 - 10])
                cube(200, center = true);
        }
    }
}

module c3po() {
    translate([10, 0, 0])
        rotate([0, 0, - 90])
            scale(9.8)
                import("resources/C3PO_fixed_hi-res.stl");
}
