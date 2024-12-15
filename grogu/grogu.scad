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
$fn = 100;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:[];
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:[]; // animation rotate around the object
$vpd = is_animated?500:[];

fox();

module fox() {
    color("PaleGreen")
        linear_extrude(layer1Height)
            layer1();

    color("DarkSlateGray")
        translate([0, 0, layer1Height])
            linear_extrude(layer2Height)
                layer2();
}

module layer1() {
    scale([1,0.8,1])
    circle(r = 50);
    mmirror([1, 0, 0])
    hearIn();
}

module layer2() {
    mmirror([1, 0, 0])
    eye();
}

module hearIn() {
    intersection() {
        translate([90, -180, 0])
            circle(r = 200);
        translate([60, 140, 0])
            circle(r = 150);
    }
}

module eye() {
    translate([15, 20, 0])
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