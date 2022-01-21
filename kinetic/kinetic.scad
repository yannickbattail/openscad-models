
/* [cone dimentions] */
cone_width=3; // [0.1:0.1:10]
cone_count=8; // [1:8]

/* [Animation] */
// Animation rotation
animation_rotation = false;

$fn=20;

/* [Hidden] */
GOLDANGLE=-137.5;
pi=3.141592653589793;
rad=(((cone_width * cone_count)*4)/(2*pi));

$vpt = animation_rotation?[0, 0, 0]:$vpt;
$vpr = animation_rotation?[60, 0, ((144 * $t)*GOLDANGLE) % 360]:$vpr; // animation rotate around the object
$vpd = animation_rotation?100:$vpd;//Camera Distance

//view-animate
//set fps=30
//set steps=144

module mkCone(x){
    linear_extrude(
        height = 10,
        twist = 360,
        scale = -10
    )
        rotate([0,0,x*36])
            translate([1,0,0])
                circle(r=cone_width);
}
module mkSpikes(){
    union(){
        sphere(
            r = rad
        );
        for(x=[1:cone_count*12]){
            rotate([x,0,(-137.5*x)])
                translate([0,0,rad])
                    mkCone(x);
        }
    }
}
module flower() {
    color("MediumVioletRed")
    difference(){
        mkSpikes();
        translate([-25,-25,-rad])
            cube([50,50,rad]);
    };
    color("darkgreen")
    translate([0,0,-3])
        cylinder(
            h = 3,
            r1 = rad,
            r2 = rad+((cone_count*12)/10)
        );

    color("orange")
    translate([0,0,-10])
        cylinder(
            h = 7,
            r = rad
        );
}
flower();
