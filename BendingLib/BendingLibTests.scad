include <BendingLib.scad>

angle = 60;
$fn = 50;

bend(angle, _big_value = 100)
    linear_extrude(50, /*scale=[0,0],*/ center = true)
        pentagon(r = 5);

module pentagon(r) {
    circle(r = r, $fn = 5);
}


