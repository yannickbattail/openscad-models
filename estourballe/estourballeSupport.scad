
// part to generate
part = "all"; // [all, base, cup]

// hauteur des coupes
height=30; // [10:5:100]

// gemme octogone sur la coupe
octo=true;

// affiche les estourballe
withEstourballe=false;

/* [Animation] */
// resolution
$fn=50;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 100]:$vpt;
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:$vpr;  // animation rotate around the object
$vpd = is_animated?600:$vpd;

if (part == "base") {
    base();
} else if (part == "cup") {
    cup(height, octo, withEstourballe);
} else {
    base();
    allCup(height, octo, withEstourballe);
}

module allCup(height, octo, withEstourballe) {
    translate([40,-40,5])
        cup(height, octo, withEstourballe);
    translate([40,40,35])
        cup(height, octo, withEstourballe);
    translate([-40,-40,35])
        cup(height, octo, withEstourballe);
    translate([-40,40,65])
        cup(height, octo, withEstourballe);
}

module cup(height, octo, withEstourballe) {
    coneHeight=15;
    color("orange") {
        cylinder(d1 = 8, d2=10, h = coneHeight);
        translate([0,0,coneHeight])
            cylinder(d=10, h = height);
        translate([0,0,height+coneHeight])
            cupHead(octo);
    }
    if (withEstourballe)
        translate([0,0,height+coneHeight+20])
            estouballeModel();
}

module cupHead(octo) {
    if (octo)
        sphere(10, $fn=8);
    difference() {
        rotate_extrude() {
            translate([24, 26.5])
                circle(r = 3);
            difference() {
                square([25, 29]);
                translate([29, 0])
                    circle(r = 24);
            }
        }
        translate([0, 0, 21])
            estouballeModel();
    }
}

module base(withEstourballe) {
    color("yellow")
    difference() {
        translate([0,0,40])
            cube([120, 120, 80], center=true);
        rot=20;
        translate([0,0,220])
            rotate([rot,rot,0])
                cube(300, center=true);
        allCup(height, octo, withEstourballe);
    }
}

module torus(radius, thickness) {
    rotate_extrude() {
        translate([radius, 0]) circle(r = thickness);
    }
}

module estouballeModel() {
    translate([0,0,35]) {
        color("red")
        difference() {
            sphere(d = 70.01);
            translate([0, 0, -40])
                cube(80, center = true);
        }
        color("white") {
            difference() {
                sphere(d = 70);
                translate([0, 0, 40])
                    cube(80, center = true);
            }
            rotate([0, 0, 45]) {
                translate([0, 0, 30])
                    cube([7, 7, 100], center = true);
                translate([0, 0, 60])
                    cube([40, 7, 7], center = true);
            }
        }
    }
}
