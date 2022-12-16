
part = "all_parts"; // [whole, connector, part1, part2, part3, all_parts]
// thickness of the arrow
thickness = 8; // [1:1:20]
// Percent scale of the arrow (original size is nearly 1000)
scalePercent = 50; // [5:1:400]

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:$vpt;
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:$vpr; // animation rotate around the object
$vpd = is_animated?300:$vpd;

scale1 = scalePercent/100;

epsi = 0.001;

if (part == "whole") {
    arrowPart(thickness, scale1, 0, 1000);
} else if (part == "part1") {
    arrowPart1(thickness, scale1, 0, 400);
} else if (part == "part2") {
    arrowPart2(thickness, scale1, 400, 300);
} else if (part == "part3") {
    arrowPart3(thickness, scale1, 700, 300);
} else if (part == "connector") {
    connector(thickness, scale1);
} else if (part == "all_parts") {
    translate([-90,25,0]*scale1) connector(thickness, scale1);
    translate([-70,25,0]*scale1) connector(thickness, scale1);
    translate([0,0,0]*scale1) arrowPart1(thickness, scale1, 0, 400);
    translate([140,-400,0]*scale1) arrowPart2(thickness, scale1, 400, 300);
    translate([-190,-700,0]*scale1) arrowPart3(thickness, scale1, 700, 300);
} else {
    
}

module connector(thickness, scale1) {
    translate([0,0,thickness/4-epsi]) cube([8*scale1, 50*scale1, thickness/2], center=true);
}

module arrowPart1(thickness, scale1, partFrom, partLength) {
    difference() {
        arrowPart(thickness, scale1, partFrom, partLength);
        translate([0,(partFrom+partLength)*scale1,0]) connector(thickness, scale1);
    }
}

module arrowPart2(thickness, scale1, partFrom, partLength) {
    difference() {
        arrowPart(thickness, scale1, partFrom, partLength);
        translate([0,(partFrom)*scale1,0]) connector(thickness, scale1);
        translate([0,(partFrom+partLength)*scale1,0]) connector(thickness, scale1);
    }
}

module arrowPart3(thickness, scale1, partFrom, partLength) {
    difference() {
        arrowPart(thickness, scale1, partFrom, partLength);
        translate([0,(partFrom)*scale1,0]) connector(thickness, scale1);
    }
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
