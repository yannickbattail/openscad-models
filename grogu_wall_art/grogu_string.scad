use <grogu.scad>

bothSides = false;

thickness = 1; // [1:0.1:10]

thicknessBase = 1; // [0:0.1:10]

width = 100;

resize([width, width / 1.62833738, thickness + thicknessBase])
    grogu(thickness, thicknessBase, bothSides);

translate([49, 59.6, 0])
    hook();
translate([49, 1, 0])
    rotate([0, 0, 180])
        hook();

module hook() {
    //color("blue")
    linear_extrude(thickness + thicknessBase)
        difference() {
            circle(r = 10);
            circle(r = 5);
            translate([0, - 11])
                square([22, 22], center = true);
        }
}
