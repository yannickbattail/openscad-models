use <grogu.scad>

bothSides = false;

thickness = 5; // [1:0.1:10]

thicknessBase = 5; // [0:0.1:10]

width = 100;

hookPosition = "both"; // [both, top, bottom, none]

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
