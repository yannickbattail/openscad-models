include <pipe2.scad>

/* [Animation] */
// Animation rotation
animation_rotation = false;

/* [Hidden] */
$vpt = animation_rotation?[4, 3, 15]:$vpt;
$vpr = animation_rotation?[60, 0, 365 * $t]:$vpr; // animation rotate around the object
$vpd = animation_rotation?3000:$vpd;

$fn=100;

example();
bugle();

module example(){
    translate([0, 100, 0])
    pipe([
        //length,outer_radius_start, inner_radius_start,outer_radius_end, inner_radius_end,rotation,angle,radius_of_curvature,straight_part_color,curved_part_color
        [    200,                50,                 47,              20,               17,       0,   90,                20,             "green",            "red"],
        [    200,                20,                 17,              10,                7,      90,  120,                20,              "blue",         "orange"],
    ]);
}

module bugle() {
    rotate([0, 90, 0]) {
        pipe([
            //length,outer_radius_start, inner_radius_start,outer_radius_end, inner_radius_end,rotation,angle,radius_of_curvature,straight_part_color,curved_part_color
            [    600,                10,                  8,              14,               12,      90,   90,                100,           "orange",         "orange"],
            [    200,                14,                 12,              14,               12,       0,   90,                100,           "orange",         "orange"],
            [    500,                14,                 12,              18,               16,     -10,   90,                100,           "orange",         "orange"],
            [    200,                14,                 12,              18,               16,       0,   90,                100,           "orange",         "orange"],
            [    500,                18,                 16,              22,               20,       0,    0,                  0,           "orange",         "orange"],
            [     50,                22,                 20,              30,               28,       0,    0,                  0,           "orange",         "orange"],
            [     50,                30,                 28,              60,               58,       0,    0,                  0,           "orange",         "orange"],
            [     50,                60,                 58,             120,              118,       0,    0,                  0,           "orange",         "orange"],
        ]);
    }
    mouthpiece();
}

module mouthpiece() {
    rotate([0, -90, 0]) {
        pipe([
            //length,outer_radius_start, inner_radius_start,outer_radius_end, inner_radius_end,rotation,angle,radius_of_curvature,straight_part_color,curved_part_color
            [     60,                8,                  7,              9,               8,       0,    0,                  0,           "orange",         "orange"],
            [     20,                9,                  8,             20,              12,       0,    0,                  0,           "orange",         "orange"],
            [     20,               20,                 12,             20,              12,       0,    0,                  0,           "orange",         "orange"],
            [      6,               20,                 12,             30,              20,       0,    0,                  0,           "orange",         "orange"],
            [     10,               30,                 20,             30,              20,       0,    0,                  0,           "orange",         "orange"],
        ]);
    }
}