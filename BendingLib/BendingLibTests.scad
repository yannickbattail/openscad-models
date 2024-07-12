include <BendingLib.scad>

angle=60;
$fn=50;

bend(angle)
    pen5();

module pentagon(r) {
    circle(r=r, $fn=5);
}

module pen5() {
            linear_extrude(50, center=true)
                pentagon(r=5);
}

