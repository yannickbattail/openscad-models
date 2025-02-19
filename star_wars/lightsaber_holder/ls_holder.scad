// part to generate
part = "holder"; // [all, holder, saber]

// size of the model
size = 50; // [10:5:100]

/* [Animation] */
// resolution
$fn = 50;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 200]:$vpt;
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:$vpr;  // animation rotate around the object
$vpd = is_animated?1000:$vpd;

if (part == "holder") {
    holder();
} else if (part == "saber") {
    saber_profile();
} else {
    saber_profile();
}

module saber_profile() {
    a = [
            [20, 0],
            [34.5, 8],
            [34.5, 17],
            [33, 0],
            [33, 34],
            [29, 0],
            [29, 4],
            [30, 0],
            [30, 13],
            [29, 0],
            [29, 4],
            [30, 0],
            [30, 13],
            [29, 0],
            [29, 4],
            [30, 0],
            [30, 13],
            [29, 0],
            [29, 4],
            [30, 0],
            [30, 13],
            [29, 0],
            [29, 4],
            [34, 33],
            [34, 25],
            [29, 4],
            [29, 35],
            [34, 15],
            [34, 14],
            [29.5, 0],
            [29.5, 6],
            [34, 45]
        ];
    b = [[0, 0], [10, 0], [17.25, 8], [17.25, 25], [16.5, 25], [15, 59], [14.5, 59], [14.5, 63], [15, 63], [15, 76], [
        14.5, 76], [14.5, 80], [15, 80], [15, 93], [14.5, 93], [14.5, 97], [15, 97], [15, 110], [14.5, 110], [14.5, 114]
        , [15, 114], [15, 127], [14.5, 127], [14.5, 131], [17, 164], [17, 189], [14.5, 193], [14.5, 228], [17, 243], [17
            , 257], [14.75, 257], [14.75, 263], [17, 263], [17, 308], [0, 308]];
    difference() {
        rotate_extrude()
            polygon(b);

        translate([15, -250 / 2, 100])
            cube(250);
        translate([-250 - 15, -250 / 2, 100])
            cube(250);

        translate([-50, 25, 332 - 50])
            rotate([55, 0, 0])
                cube(100);

        //battery charger
        translate([0, 0, 178])
            rotate([90, 0, 0])
                cylinder(d = 10, h = 35);

        // blade
        translate([0, 0, 10])
            #cylinder(d = 25.4, h = 1100);
    }

    //battery charger
    translate([0, 0, 178])
        rotate([90, 0, 0]) {
            difference() {
                cylinder(d = 10, h = 16);
                cylinder(d = 5.5, h = 18);
            }
            cylinder(d = 1, h = 16);
        }
    //button
    translate([0, 0, 163])
        rotate([90, 0, 0]) {
            cylinder(d = 14, h = 16);
            translate([0, 0, 16])
                cylinder(d1 = 14, d2 = 10.5, h = 1.5);
        }
}

module holder() {
    cube();
}
