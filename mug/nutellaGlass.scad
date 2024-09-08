// plain (template for making mug or cup) or empty (the glass),
plain = false;

// Number of block
numberOfBlock = 0; // [0:none, 3:3, 4:4, 5:5, 6:6]

// thickness of the glass
thickness=2; // [0.7:0.1:4]

/* [Animation] */
// rotating animation
animation_rotation = false;

$fn = 200;

// cut the glass in quarter
debug = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:[];
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:[]; // animation rotate around the object
$vpd = is_animated?500:[];

if (debug) {
    difference() {
        nutellaGlass(plain, numberOfBlock, thickness);
        translate([0, - 200, - 0.1]) cube(200);
    }
} else {
    nutellaGlass(plain, numberOfBlock, thickness);
}

module nutellaGlass(plain = false, nbBlock = 0, thickness = 2) {
    echo("nutellaGlass: total height 92");
    echo("nutellaGlass: max diameter 73.5");
    if (plain) {
        plainNutellaGlassWithBlock(nbBlock);
    } else {
        emptyNutellaGlass(nbBlock, thickness);
    }
}

module emptyNutellaGlass(nbBlock = 0, thickness = 2) {
    difference() {
        plainNutellaGlassWithBlock(nbBlock);
        scaleInside = (73.5-thickness*2)/73.5;
        translate([0, 0, thickness*3])
            scale(scaleInside)
                plainNutellaGlass();
    }
}

module plainNutellaGlass() {
    translate([0, 0, 25])
        difference() {
            union() {
                cylinder(d1 = 69.5, d2 = 73.5, h = 67);
                sphere(d = 69.5);
            }
            translate([0, 0, - 40 - 25])
                cube([80, 80, 80], center = true);
        }
}

module plainNutellaGlassWithBlock(nbBlock = 0) {
    blockHeight=1;
    scale1 = (73.5+blockHeight)/73.5;
    plainNutellaGlass();
    angle = 360/nbBlock;
    difference() {
        scale([scale1,scale1,1]) plainNutellaGlass();
        if (nbBlock) {
            for (i = [0:nbBlock - 1]) {
                rotate([0, 0, angle * i])
                    translate([0, 0, 0])
                        cube([80, 1, 100]);
            }
        }
    }
}
