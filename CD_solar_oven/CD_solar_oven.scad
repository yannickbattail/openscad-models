number_of_rows = 2; // [1:1:40]
number_of_column = 2; // [1:1:40]

// positioning of the focus point
focus_of_parabola = "middle"; // [middle, bottom_center, bottom_left]

// distance of the focus point
focus_distance = 1000; // [100:2000]

// thickness of the base
base_height = 2; // [1:10]

// support height (from the bottom of the base)
support_height = 60; // [35, 100]

// display CD, reflection vector, focus point and coordinates
debug = true;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [hidden] */
$fn = 100;

$vpt = animation_rotation ? [0, 0, 0] : [];
$vpr = animation_rotation ? [70, 0, 365 * $t] : [];
$vpd = animation_rotation ? 300 : [];

baseSide = 120;
baseDiameter = baseSide / (sqrt(3) / 2);
baseRadius = baseDiameter / 2;

dimentions = [positionX(number_of_column, number_of_rows), positionY(number_of_column, number_of_rows)];

solar_oven(base_height, support_height, baseDiameter);
//support_example(base_height, support_height, baseDiameter);

module solar_oven(base_height, support_height, baseDiameter) {
    focusPos = focus_position(focus_of_parabola, dimentions, focus_distance);
    for (x = [0:number_of_column - 1]) {
        if (debug) {
            color("blue")
                translate([positionX(x, 0) + 40, - 150, 0])
                    linear_extrude(2)
                        text(chr(65 + x), 50);

        }
        for (y = [0:number_of_rows - 1]) {
            xt = positionX(x, y);
            yt = positionY(x, y);
            supportRotation = support_rotation(focusPos, [xt, yt, support_height]);
            translate([xt, yt, 0]) {
                base(base_height, baseDiameter);
                support(str(chr(65 + x), ",", y + 1), supportRotation, support_height, base_height);
            }
        }
    }
    if (debug) {
        color("lightyellow")
            translate(focusPos)
                sphere(10); // display focus point
        for (y = [0:number_of_rows - 1]) {
            color("blue")
                translate([- 150, positionY(0, y) - 24, 0])
                    linear_extrude(2)
                        text(str(y + 1), 50);
        }
    }
}

module support_example(base_height, support_height, baseDiameter) {
    base(base_height, baseDiameter);
    translate([0, 0, 6])
        support("A1", [30, 30, 0], support_height, base_height);
}

function positionX(x, y) = y % 2 ? x * baseRadius * 3 + baseRadius * 1.5 : x * baseRadius * 3;
function positionY(x, y) = y * baseSide / 2;

function focus_position(focus_of_parabola, dimentions, focus_distance) =
    focus_of_parabola == "middle" ? [dimentions[0] / 2, dimentions[1] / 2, focus_distance] :
        (focus_of_parabola == "bottom_center" ? [dimentions[0] / 2, 0, focus_distance] : /*bottom_left*/[0, 0,
            focus_distance]);

function support_rotation(focusPos, support) = let(
    vct = focusPos - support,
    length = norm([vct[0], vct[1], vct[2]]), // radial distance
    theta = acos(vct[2] / length), // inclination angle
    phi = atan2(vct[1], vct[0])        // azimuthal angle
) [0, theta, phi];


module support(text, rotation, support_height, base_height) {
    difference() {
        union() {
            translate([0, 0, base_height / 2])
                cube([10, 10, base_height], center = true);
            translate([0, 0, base_height])
                cylinder(d = 16, h = support_height - 15);
            translate([0, 0, support_height + base_height])
                rotate(rotation)
                    head();
        }
        translate([- 4, - 6, 30]) {
            rotate([90, 90, 0])
                linear_extrude(2) {
                    text(text, 8);
                }
        }
    }
}

module head() {
    color("orange")
        difference() {
            sphere(d = 35);
            translate([0, 0, 20])
                cube(40, center = true);
        }
    color("orange")
        cylinder(d1 = 15, d2 = 14, h = 4);
    if (debug) {
        color("grey") cylinder(d = 120, h = 1);
        color("red") cube([1, 1, 1200]);
    }
}



module base(base_height, baseDiameter) {
    color("chartreuse")
        difference() {
            union() {
                difference() {
                    cylinder(d = baseDiameter, h = base_height, $fn = 6);
                    translate([0, 0, - 0.001])
                        cylinder(d = baseDiameter - 8, h = base_height + 0.002, $fn = 6);
                }
                cylinder(d = 30, h = base_height, $fn = 6);
                translate([0, 0, base_height / 2])
                    for (i = [0:2]) {
                        rotate([0, 0, 60 * i + 30])
                            cube([4, baseDiameter - 3, base_height], center = true);
                    }
            }
            cube(10, center = true);
        }
}
