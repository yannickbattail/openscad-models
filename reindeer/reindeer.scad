smooth = false;

smoothSize = 3; // [0:8]

smoothRez = 5; // [4:50]

/* [Animation] */
// resolution
$fn = 5;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:$vpt;
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:$vpr;  // animation rotate around the object
$vpd = is_animated?200:$vpd;


if (smooth) {
    minkowski() {
        reindeer();
        sphere(smoothSize, $fn = smoothRez);
    }
} else {
    reindeer();
}

module reindeer() {
    rotate([90, 0, 0]) {
        intersection() {
            linear_extrude(200, center = true)
                import("reindeer_front.svg");
            rotate([0, 90, 0])
                linear_extrude(200, center = true)
                    import("reindeer_side.svg");
        }
    }
}
