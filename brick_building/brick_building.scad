
// dimention of the wall [width, height] in number of brick
wall_size=[6, 6];

/* [brick] */
// dimention of a brick [x,y,z]
brick_dimention = [15, 7, 5];
// thickness of cement
cement=1;
// how round a brick is, 0:no rounding (faster rendering) 
brick_rounding=0.5; // [0:0.1:10]

/* [Animation] */
// rotating animation
animation_rotation = false;
// variables animation
animation_var = false;

$fn = 50;
/* [hidden] */

/* for animation */
$vpt = animation_rotation ? [0, 0, 0]         : (animation_var? [0, 0, 180] :[]);
$vpr = animation_rotation ? [70, 0, 360 * $t] : (animation_var? [120, 0, 60]:[]);
$vpd = animation_rotation ? 2000              : (animation_var? 1000        :[]);

/* constants */
EPSI = 0.01; // epsilon
X=0;
Y=1;
Z=2;
ROUNDING=3;
CEMENT=4;
W=0;
H=1;

brick_vars=[brick_dimention[X],brick_dimention[Y],brick_dimention[Z], brick_rounding, cement];

//brick(brick_vars);
brick_wall(wall_size, brick_vars) {
    if (brick_rounding) {
        rounded_brick(brick_vars);
    } else {
        brick(brick_vars);
    }
};

module brick(brick_vars) {
    color("orange")
        cube([brick_vars[X], brick_vars[Y], brick_vars[Z]]);
}

module rounded_brick(brick_vars) {
    r = brick_vars[ROUNDING];
    color("orange")
    translate([r,r,r])
        minkowski() {
            sphere(r);
            cube([brick_vars[X]-2*r, brick_vars[Y]-2*r, brick_vars[Z]-2*r]);
        }
}

module brick_line(length, brick_vars) {
    for (i = [0:length-1]) {
        translate([(brick_vars[X] + brick_vars[CEMENT]) * i, 0, 0]) {
            children(0);
        }
    }
}

module brick_line_odd(length, brick_vars) {
    for (i = [0:length]) {
        translate([(brick_vars[0] + brick_vars[CEMENT]) * (length - i - 0.5), 0, 0]) {
            children(0);
        }
    }
}

module brick_wall(wall_size, brick_vars) {
    for (i = [0:wall_size[1]-1]) {
        translate([0, 0, (brick_vars[2] + brick_vars[CEMENT]) * i]) {
            if (i % 2) {
                brick_line(wall_size[0], brick_vars) {
                    children(0);
                }
            } else {
                brick_line_odd(wall_size[0], brick_vars) {
                    children(0);
                }
            }
        }
    }
    color("grey")
        translate([0, brick_vars[CEMENT], 0])
            cube([wall_size[0] * (brick_vars[X] + brick_vars[CEMENT]), brick_vars[Y] - brick_vars[CEMENT]*2, wall_size[1] * (brick_vars[Z] + brick_vars[CEMENT])]);
}
