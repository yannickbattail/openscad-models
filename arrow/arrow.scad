
part = "all"; // [all, part1, part2, part3]
// thickness of the arrow
thickness = 8; // [1:1:20]
// Percent scale of the arrow (original size is nearly 1000)
scalePercent = 50; // [5:1:400]

scale1 = scalePercent/100;

if (part == "all") {
    arrowPart(thickness, scale1, 0, 1000);
} else if (part == "part1") {
    arrowPart(thickness, scale1, 0, 400);
} else if (part == "part2") {
    arrowPart(thickness, scale1, 400, 300);
} else if (part == "part3") {
    arrowPart(thickness, scale1, 700, 300);
}

module arrowPart(thickness, scale1, partFrom, partLength) {
    intersection() {
        arrow(thickness, scale1);
        translate([0,(partFrom+partLength/2)*scale1,0]) cube(partLength*scale1, center=true);
    }
}

module arrow(thickness, scalePercent) {
    linear_extrude(thickness)
        scale(scalePercent)
            arrow2D();
}

module arrow2D() {
    translate([-105,611])
    difference() {
        import("arrow_path1.svg");
        import("arrow_path2.svg");
    }
}
