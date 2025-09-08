include <horns.scad>

/* [parameters] */

// horns
horn = "all"; // [all, horn_n, horn_o, horn_s, horn_w, horn_e, horn_nw, horn_ne, horn_sw, horn_se]
debug=false;


module horn_all() {
    arrange() {
        horn_n();
        horn_o();
        horn_s();
        horn_w();
        horn_e();
        horn_nw();
        horn_ne();
        horn_sw();
        horn_se();
    }
}

 // Arrange its children in a regular rectangular array
 //      spacing - the space between children origins
 //      n       - the number of children along x axis
 module arrange(spacing=50, n=5) {
    nparts = $children;
    for(i=[0:1:n-1], j=[0:nparts/n])
        if (i+n*j < nparts)
            translate([spacing*(i+1), spacing*j, 0]) 
                children(i+n*j);
}

if (horn == "all") {
    horn_all();
}
else if (horn == "horn_n") {
    horn_n();
}
else if (horn == "horn_o") {
    horn_o();
}
else if (horn == "horn_s") {
    horn_s();
}
else if (horn == "horn_w") {
    horn_w();
}
else if (horn == "horn_e") {
    horn_e();
}
else if (horn == "horn_nw") {
    horn_nw();
}
else if (horn == "horn_ne") {
    horn_ne();
}
else if (horn == "horn_sw") {
    horn_sw();
}
else if (horn == "horn_se") {
    horn_se();
}
