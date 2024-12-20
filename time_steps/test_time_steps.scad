use <time_steps.scad>;
use <hsv.scad>

// part or piece to display
part="logo_animation"; // [logo_animation, graph_steps]

/* [Animation] */
// rotating animation
animation_rotation = false;

// resolution
$fn=50;

$vpt = animation_rotation ? [-50, 0, 0] : [];
$vpr = animation_rotation ? [70, 0, 0] : [];
$vpd = animation_rotation ? 300 : [];

unit_tests();

if (part == "logo_animation") {
    Logo(50);
} else if (part == "graph_steps") {
    graph_steps(6);
} else {
    Logo(50);
    graph_steps(6);
}

module Logo(size=50) {
    hole = size/2;
    cylinderHeight = size * 1.25;
    t = time_steps(3);
    difference() {
        sphere(d=size);
        rotate([ 0, 0, 0]) translate([0, 0, -(1-t[0])*size]) #cylinder(d=hole, h=cylinderHeight, center=true);
        rotate([90, 0, 0]) translate([0, 0, -(1-t[1])*size]) #cylinder(d=hole, h=cylinderHeight, center=true);
        rotate([0, 90, 0]) translate([0, 0, -(1-t[2])*size]) #cylinder(d=hole, h=cylinderHeight, center=true);
    }
}

module graph_steps(nb_step) {
    rotate([90,0,0]) {
        cube([30, 1, 1]);
        cube([1, 30, 1]);
        scale([20, 10, 1]) {
            for (step = [0:nb_step - 1]) {
                color(hsv(step / nb_step, 1, 1))
                    translate([0, 0, step]) linear_extrude(1) graph(step, nb_step);
            }
        }
    }
}

module graph(step, nb_steps) {
    points = [ for (x = [0:0.01:1]) [x, t_steps(x, nb_steps)[step]] ];
    newPoints = concat(points, [[1,0],[0,0]]);
    polygon(newPoints);
}

module unit_tests() {
    test(0.2, 4, [0.8,0,0,0]);
    test(0.4, 4, [1,0.6,0,0]);
    test(0.6, 4, [1,1,0.4,0]);
    test(0.8, 4, [1,1,1,0.2]);
    echo("test success");
}

module test(t, nb_step, expected_result) {
    actual = t_steps(t, nb_step);
    assert(str(actual) == str(expected_result), str("t_steps(",t, ",",nb_step,") should be ", expected_result, " but is ", actual));
}