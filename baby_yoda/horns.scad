
module horn(translation, cube_size) {
    if (!debug) {
        translate([-cube_size[0]/2,-cube_size[1]/2,0]) { // center it (not on z)
            translate(-translation) { // translate to 0,0,0
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

// name of the horns (north south est west)
//  nw  n  ne
//      o
//  w       e
//   sw   se
//      s

module horn_n() {
    translation = [94, 125, 0];
    cube_size = [40,50,50];
    horn(translation, cube_size);
}
module horn_o() {
    translation = [95, 79, 0];
    cube_size = [40,45,50];
    horn(translation, cube_size);
}
module horn_s() {
    translation = [100, 10, 0];
    cube_size = [28,40,50];
    horn(translation, cube_size);
}
module horn_w() {
    translation = [34, 61, 0];
    cube_size = [35,32,50];
    horn(translation, cube_size);
}
module horn_e() {
    translation = [157, 61, 0];
    cube_size = [35,32,50];
    horn(translation, cube_size);
}
module horn_nw() {
    translation = [39, 123, 0];
    cube_size = [40,36,50];
    horn(translation, cube_size);
}
module horn_ne() {
    translation = [147, 121, 0];
    cube_size = [46,36,50];
    horn(translation, cube_size);
}
module horn_sw() {
    translation = [59, 24, 0];
    cube_size = [36,40,50];
    horn(translation, cube_size);
}
module horn_se() {
    translation = [132, 29, 0];
    cube_size = [36.9,34.7,50];
    horn(translation, cube_size);
}
