$fn=100;
GOLDANGLE=-137.5;
pi=3.141592653589793;
cone_width=3;
cone_count=8;
rad=(((cone_width * cone_count)*4)/(2*pi));
$vpt = [0, 0, 0];
$vpr = [60, 0, ((144 * $t)*GOLDANGLE) % 360];
$vpd = 300;//Camera Distance
 
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
                    mkCone(1);
        }
    }
}
 
difference(){
    mkSpikes();
    translate([-25,-25,-rad])
        cube([50,50,rad]);
};
translate([0,0,-3])
    cylinder(
        h = 3,
        r1 = rad,
        r2 = rad+((cone_count*12)/10)
    );
translate([0,0,-10])
    cylinder(
        h = 7,
        r1 = 15,
        r2 = 15
    );
 