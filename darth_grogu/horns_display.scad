include <horns.scad>

/* [parameters] */

// horns
horn = "all"; // [all, n, o, s, w, e, nw, ne, sw, se]
debug=false;

if (horn == "all") {
    all_horns();
}
else {
    horns_by_name(horn);
}
