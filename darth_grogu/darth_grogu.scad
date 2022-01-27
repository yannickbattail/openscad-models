yoda_color="#333333"; // MediumSeaGreen
horn_color="red"; // DarkKhaki

darth_grogu();

module darth_grogu() {
    union() {
        babyyoda();
        horns();
    }
}

module babyyoda() {
    color(yoda_color)
        translate([0.25,2,0]) // center z axis in the head
            rotate([0, 0, 75]) // allign hears with x axis
                import("base_stl/Babyyoda.stl");
}

module horns() {
    color("red") // DarkKhaki
    translate([0, 0, 25])
        scale(0.05)
            horn_all();
}

module horn_all() {
    //  nw  n  ne
    //      o
    //  w       e
    //   sw   se
    //      s
    horn_list = [
        ["n",  [  0,  80, -42], [-45,  0,   0]],
        ["o",  [  0,  40, -16], [-20,  0,   0]],
        ["s",  [  0, -40, -16], [ 20,  0,   0]],
        ["w",  [-86, -20, -55], [ 0, -80,  20]],
        ["e",  [ 86, -20, -55], [ 0,  80, -20]],
        ["nw", [-45,  60, -38], [-35,-30,   0]],
        ["ne", [ 45,  60, -38], [-35, 30,   0]],
        ["sw", [-45, -25, -20], [ 20,-20, -20]],
        ["se", [ 45, -25, -18], [ 20, 20,  20]],
    ];
    for (i=[0:len(horn_list)-1]) {
        translate(horn_list[i][1])
            rotate(horn_list[i][2])
                get_horn_by_name(horn_list[i][0]);
    }
}

module get_horn_by_name(horn) {
    import(str("stl/horn_",horn,".stl"));
}
