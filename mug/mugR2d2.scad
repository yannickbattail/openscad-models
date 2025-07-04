use <mug.scad>
use <nutellaGlass.scad>

/* [Mug] */
// nutella glass scale: grow nutella glass to better fit in
nutellaGlassScale = 1.01; // [0.99:1.05]

// Number of block
numberOfBlock = 6; // [0:none, 3:3, 4:4, 5:5, 6:6]

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
        r2d2Mug();
        translate([- 10, - 200, 0]) cube(200);
    }
} else {
    r2d2Mug();
}

module r2d2Mug() {
    nutellaGlassPos = [0, 0, 60];
    difference() {
        union() {
            r2d2();
            translate([58, 0, 100])
                handle(120);
        }
        translate([0, 0, 65]) {
            if (debug) {
                #nutellaGlass(plain = true, nbBlock = numberOfBlock);
            } else {
                nutellaGlass(plain = true, nbBlock = numberOfBlock);
            }
        }
        translate([0, 0, 203 + 50])
            cube(200, center = true);
    }
}

module r2d2() {
    scale(nutellaGlassScale)
        translate([0, 0, 90])
            rotate([0, 0, - 90])
                scale(80)
                    import("resources/r2d2.3mf"); // https://www.thingiverse.com/thing:5413008
}
