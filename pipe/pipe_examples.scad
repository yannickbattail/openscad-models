include <pipe.scad>

$fn=100;

paperclip();
example();

module example(){
    //   outer_radius, inner_radius, list of segments
    pipe(10,           7,           [
        //length,rotation,angle,radius_of_curvature 
        [    200,       0,   90,    10],
        [    120,      90,  120,    20],
        [    100,       0,  120,    20],
        [     60,       0,    0,    20]
    ]);
    
    color("white")
    rotate([180, 0, 0])
    pipe(14,          10,           [
        //length,rotation,angle,radius_of_curvature 
        [     60,     180,   90,     0],
        [     60,      90,    0,    20]
    ]);

}

// example paperclip
module paperclip() {
    color("gray")
    translate([300, 0, 60])
    pipe(10, 9, [
        //length,rotation,angle,radius_of_curvature 
        [    500,       0,   90,    70],
        [    140,       0,   90,    70],
        [    550,      10,   90,    30],
        [    120,       0,   90,    30],
        [    400,      10,   90,    50],
        [    100,       0,   90,    50],
        [    360,      10,    0,    50],
    ]);
}
