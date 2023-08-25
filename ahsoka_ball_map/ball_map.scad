circlesRadius = 80; // [60:100]
circlesDepth = 55; // [40:70]
// resolution
$fn = 50; // [10:5:100]

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:$vpt;
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:$vpr; // animation rotate around the object
$vpd = is_animated?1000:$vpd;

ballMap(circlesRadius, circlesDepth);

module ballMap(circlesRadius, circlesDepth) {
    difference() {
        sphere(r = 100);
        ringTrace(circlesRadius, circlesDepth);
        rotate([180, 0, 0])
            ringTrace(circlesRadius, circlesDepth);
        for (i = [0:4]) {
            rotate([0, 0, 72 * i]) {
                rotate([116.565, 0, 0]) {
                    ringTrace(circlesRadius, circlesDepth);
                }
            }
            rotate([0, 0, 72 * (i + 0.5)]) {
                rotate([180 - 116.565, 0, 0]) {
                    ringTrace(circlesRadius, circlesDepth);
                }
            }
        }
    }
}


module ringTrace(circlesRadius, circlesDepth) {
    translate([0, 0, circlesDepth])
        pipe(circlesRadius, 10, 10);
}

module pipe(innerRadius, thickness, height) {
    difference() {
        cylinder(r = innerRadius + thickness * 2, h = height);
        cylinder(r = innerRadius, h = height);
    }
}

