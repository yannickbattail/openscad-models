
mat = [
        [1,1,1],
        [1,1,0],
        [1,0,0],
    ]; // [1:2]

offset=15; // [13:20]

matrixpattern(mat, offset);

module matrixpattern(mat, offset) {
    for (x = [0:len(mat)-1]) {
        for (y = [0:len(mat[0])-1]) {
            if (mat[x][y]) {
                translate([x*offset, y*offset, 0])
                    scaleModel();
            }
        }
    }
}

module scaleModel() {
    translate([111, 110, -6.5])
        rotate([0,0,135])
            import("scale.stl");
}


