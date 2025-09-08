difference() {
    translate([0,0,-10])
    rotate([25,0,0])
        rotate([0,0,18])
            import("grogu.3mf"); // https://www.thingiverse.com/thing:5411741
    translate([0,0,-50])
        #cube(100, center=true);
}
