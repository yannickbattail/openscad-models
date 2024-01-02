// Height of layer 1 (white)
layer1Height = 3;
// Height of layer 2 (orange)
layer2Height = 3;
// Height of layer 3 (black)
layer3Height = 3;

/* [Animation] */
// rotating animation
animation_rotation = false;
// resolution
$fn = 50;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:[];
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:[]; // animation rotate around the object
$vpd = is_animated?500:[];

fox();

module fox() {
    color("white")
        linear_extrude(layer1Height)
            layer1();

    color("orange")
        translate([0, 0, layer1Height])
            linear_extrude(layer2Height)
                layer2();

    color("DarkSlateGray")
        translate([0, 0, layer1Height + layer2Height])
            linear_extrude(layer3Height)
                layer3();
}

module layer1() {
    circle(r = 50);
    mmirror([1, 0, 0])
    hearIn();
}

module layer2() {
    face();
    mmirror([1, 0, 0])
    hearOut();
}

module layer3() {
    mmirror([1, 0, 0])
    eye();
    mmirror([1, 0, 0])
    hearOut();
    intersection() {
        face();
        translate([0, -70, 0])
            circle(r = 50);
    }
}

module face() {
    difference() {
        color("orange")
            circle(r = 50);
        color("orange")
            mmirror([1, 0, 0])
            translate([-50, -50, 0])
                circle(r = 50);
    }
}

module hearOut() {
    difference() {
        hearIn();
        translate([-5, -8, 0])
            hearIn();
    }
}

module hearIn() {
    translate([0, 50, 0])
        intersection() {
            circle(r = 50);
            translate([50, -40, 0])
                circle(r = 50);
        }
}

module eye() {
    translate([17, 20, 0])
        rotate([0, 0, -20])
            intersection() {
                circle(r = 20);
                translate([20, -20, 0])
                    circle(r = 20);
            }
}

/*
same as mirror but duplicate children
*/
module mmirror(mat) {
    children();
    mirror(mat)
        children();
}