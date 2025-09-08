
// intersection() {
//     cylinder(r=25, h=10);
    //translate([0,0,1]) 
    // resize([50,50,6]) {
    //     surface(file = "alpes.png", center = true, invert=false, convexity = 5);
    // }
// }


// difference() {
//     translate([0,0,-2]) cylinder(r=26, h=3);
//     cylinder(r=25, h=4);
// }


translate([0, 0, 0]) {
    cylinder(r1=10, r2=8, h=10, center=true);
}