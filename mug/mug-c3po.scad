use <mug.scad>
use <nutellaGlass.scad>

/* [Mug] */
// height of the mug
mugHeight = 80; // [70:120]
// external radius of the mug
mugDiameter = 80; // [75:100]
// mug thickness (Width of the wall)
mugThickness = 4;
// make a mug compatible with nutella glass
withNutellaGlass = true;

/* [Image] */
// image display angle
imageAngle = 90; // [10:360]
// image rotation angle
imageRotation = 45; // [0:360]
// relief multipier (by default relief is between 0 and 1)
reliefMultipier = 2;
// image data from imageToMatrix.html 
inlineImage = []; //
// show only image or mug (for debug purpose and faster preview)
partialModel = "all"; // [all, image_only, mug_only]

part="cat"; // [cat, cat_fur, cat_profile, cat_face, red_panda, werefox, mountain, moon, jedi_sith, solo_carbonite, yoda]

/* [Animation] */
// rotating animation
animation_rotation = false;

$fn = 100;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:[];
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:[]; // animation rotate around the object
$vpd = is_animated?500:[];

difference() {
    c3po_mug();
    // translate([-10,0,0]) cube(200);
}

module c3po_mug() {
    difference() {
        union() {
            c3po();
            translate([mugDiameter / 2 * 1.4, 0, 60])
                handle(mugHeight);
        }
        translate([0, 0, mugThickness]) {
            #scale(1.01) nutellaGlass();
            translate([0,0,92+100-10])
                cube(200, center=true);
        }
    }
}
module c3po() {
    translate([10,0,0])
        rotate([0,0,-90])
            scale(9.8)
                import("C3PO_fixed_hi-res.stl");
}
