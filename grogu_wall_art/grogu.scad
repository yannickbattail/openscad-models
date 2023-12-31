// drawing details on both sides
bothSides = false;

// thickness of the drawing details
thickness = 5; // [1:0.1:10]

// thickness of the base
thicknessBase = 5; // [0:0.1:10]

// hooks position
hookPosition = "both"; // [both, top, bottom, none]

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:[];
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:[]; // animation rotate around the object
$vpd = is_animated?2000:[];

grogu(thickness, thicknessBase, bothSides);

if (hookPosition == "both" || hookPosition == "top")
    translate([490, 602, 0])
        hook();

if (hookPosition == "both" || hookPosition == "bottom")
    translate([490, 10, 0])
        rotate([0, 0, 180])
            hook();

module hook() {
    color("DarkGreen")
        linear_extrude(thickness + thicknessBase)
            difference() {
                circle(r = 100);
                circle(r = 50);
                translate([0, -110])
                    square([220, 220], center = true);
            }
}


module grogu(thickness, thicknessBase, bothSides = false) {
    color("Green") {
        linear_extrude(thicknessBase) {
            import("svg/grogu_base.svg");
        }
    }
    color("DarkGreen") {
        translate([0, 0, thicknessBase]) {
            linear_extrude(thickness) {
                grogu2D();
            }
        }
    }
    if (bothSides)
        color("DarkGreen") {
            translate([0, 0, -thickness]) {
                linear_extrude(thickness) {
                    grogu2D();
                }
            }
        }
}

module grogu2D() {
    import("svg/splited_svg_path/path_0.svg");
    import("svg/splited_svg_path/path_1.svg");
    import("svg/splited_svg_path/path_2.svg");
    import("svg/splited_svg_path/path_3.svg");
    import("svg/splited_svg_path/path_4.svg");
    import("svg/splited_svg_path/path_5.svg");
    import("svg/splited_svg_path/path_6.svg");
    import("svg/splited_svg_path/path_7.svg");
    import("svg/splited_svg_path/path_8.svg");
    import("svg/splited_svg_path/path_9.svg");
    import("svg/splited_svg_path/path_0.svg");
    import("svg/splited_svg_path/path_1.svg");
    import("svg/splited_svg_path/path_2.svg");
    import("svg/splited_svg_path/path_3.svg");
    import("svg/splited_svg_path/path_4.svg");
    import("svg/splited_svg_path/path_5.svg");
    import("svg/splited_svg_path/path_6.svg");
    import("svg/splited_svg_path/path_7.svg");
    import("svg/splited_svg_path/path_8.svg");
    import("svg/splited_svg_path/path_9.svg");
}