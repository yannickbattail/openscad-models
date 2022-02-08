// name of the horns (north south est west)
//  nw  n  ne
//      o
//  w       e
//   sw   se
//      s

horns_list = [
    ["n",  [ 94, 125, 0], [40,50,50] ],
    ["o",  [ 95,  79, 0], [40,45,50] ],
    ["s",  [100,  10, 0], [28,40,50] ],
    ["w",  [ 34,  61, 0], [35,32,50] ],
    ["e",  [157,  61, 0], [35,32,50] ],
    ["nw", [ 39, 123, 0], [40,36,50] ],
    ["ne", [147, 121, 0], [46,36,50] ],
    ["sw", [ 59,  24, 0], [36,40,50] ],
    ["se", [132,  29, 0], [36.9,34.7,50] ]
];

module all_horns() {
    for (i = [0:len(horns_list) - 1]) {
        translate([i * 50, 0, 0])
            horn(horns_list[i][1], horns_list[i][2]);
    }
}

module horns_by_name(horn_name) {
    for (i = [0:len(horns_list) - 1]) {
        if (horn_name == horns_list[i][0]) {
            horn(horns_list[i][1], horns_list[i][2]);
        }
    }
}

module horn(translation, cube_size) {
    if (!debug) {
        translate([- cube_size[0] / 2, - cube_size[1] / 2, 0]) {// center it (not on z)
            translate(- translation) {// translate to 0,0,0
                intersection() {
                    import("base_stl/Darth_Maul_Horns_Cosplay.stl");
                    translate(translation) {
                        cube(cube_size);
                    }
                }
            }
        }
    } else {
        import("base_stl/Darth_Maul_Horns_Cosplay.stl");
        translate(translation) {
            #cube(cube_size);
        }
    }
}


module fill_horn() {
    for (i = [0:50]) {
        translate([0, 0, - i]) horn_n();
    }
}
