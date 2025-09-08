
bothSides = false;

thickness = 1; // [1:0.1:10]

thicknessBase = 1; // [0:0.1:10]

width = 100;

resize([width, width / 1.62833738, thickness + thicknessBase])
    grogu(thickness, thicknessBase);

module grogu(thickness, thicknessBase, bothSides=false) {
    color("darkgrey") {
        linear_extrude(thicknessBase) {
            import("svg/grogu_base.svg");
        }
    }
    color("white") {
        translate([0, 0, thicknessBase]) {
            linear_extrude(thickness) {
                grogu2D();
            }
        }
    }
    if (bothSides)
    color("white") {
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