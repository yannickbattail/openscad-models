
height=6;
diameter=10;
hole_height=3.2;
hole_diameter=3.05;


/* [Animation] */
// resolution
$fn=200;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:$vpt;
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:$vpr;  // animation rotate around the object
$vpd = is_animated?200:$vpd;

difference() {
    cylinder(h=height, d=diameter);
    translate([0,0,height-hole_height])
        cylinder(h=hole_height, d=hole_diameter);
}
