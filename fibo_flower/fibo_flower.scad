/*
view -> animate
set fps=30
set steps=144
*/

/* [cone dimentions] */
form = "cone"; // [cone, petal]
cone_width = 8; // [6:0.1:10]
cone_count = 8; // [1:8]
cone_rotation = true;
cone_curliness = 4; // [1:8]
SDIAM = 90;//SDIAM=100;
SRADI = 45;//SDIAM=50

flower_color="MediumVioletRed";
base_color="orange";

/* [Animation] */
// Animation rotation
animation_rotation = false;

$fn = 20;

/* [Hidden] */
GOLDANGLE = - 137.5;
rad = (((cone_width * cone_count) * 4) / (2 * PI));

$vpt = animation_rotation?[0, 0, 0]:$vpt;
$vpr = animation_rotation?[60, 0, ((144 * - $t) * GOLDANGLE) % 360]:$vpr; // animation rotate around the object
$vpd = animation_rotation?400:$vpd;//Camera Distance


module mkCone(loop) {
    rot = cone_rotation?loop * 36:0;
    rotate([loop, 0, (- GOLDANGLE * loop)])
        translate([0, 0, SRADI])
            linear_extrude(height = 30, twist = 360, scale = - 10)
                rotate([0, 0, rot])
                    translate([cone_curliness, 0, 0])
                        circle(r = cone_width);
}

module petal(loop) {
    rotate([0, 0, - (GOLDANGLE * loop)])
        rotate([0, loop / 2, 0])
            translate([0, 0, SRADI])
                rotate([0, loop, 0])
                    // cube(10,center=true);
                    cylinder(h = 10, r1 = 10, r2 = 0, center = false);
}

module element(loop) {
    if (form == "cone") {
        mkCone(loop);
    } else if (form == "petal") {
        petal(loop);
    } else {
        assert(true, str("unknown form: ", form));
    }
}

module elements() {
    union() {
        for (loop = [1:cone_count * 12]) {
            element(loop);
        }
    }
}

module flower() {
    color(flower_color)
        difference() {
            union() {
                sphere(r = rad);
                elements();
            }
            translate([- 25, - 25, - rad])
                cube([50, 50, rad]);
        };
    color(base_color)
        translate([0, 0, - 3])
            cylinder(
            h = 3,
            r1 = rad,
            r2 = rad + ((cone_count * 12) / 10)
            );

    color(base_color)
        translate([0, 0, - 10])
            cylinder(
            h = 7,
            r = rad
            );
}
flower();
