// ######################################################################################
// #  ./EasiestHeart.scad  #
// ######################################################################################
// heart bumps width
scale_x = 1; // [0.5:0.01:2]
// heart width
scale_y = 0.7; // [0.5:0.01:2]
// heart bumps length
scale_z = 1.7; // [0.5:0.01:2]

// resolution
$fn = 100;

/* [Animation] */
// rotating animation
animation_rotation = false;

$vpt = animation_rotation ? [0, 0, 0] : [];
$vpr = animation_rotation ? [70, 0, 365 * $t] : [];
$vpd = animation_rotation ? 300 : [];

easiest_heart([scale_x, scale_y, scale_z]);

module half_heart(s = [1, 0.7, 1.7]) {
    difference() {
        rotate([0, 45, 0])
            scale(s)
                sphere(r = 20);
        translate([-50, 0, 0])
            cube([100, 100, 100], center = true);
    }
}

module easiest_heart(s = [1, 0.7, 1.7]) {
    half_heart(s);
    mirror([1, 0, 0])
        half_heart(s);
}
