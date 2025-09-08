union() {
    babyyoda();

    translate([0, 0, 25]) {
        scale(base_horn_scale) {
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
}

module babyyoda() {
    translate([0.25,2,0]) // center z axis in the head
        rotate([0, 0, 75]) // allign hears with x axis
            import("base_stl/Babyyoda.stl");
}

base_horn_scale=0.05;
module horn_n() {
    import("stl/horn_n.stl");
}
module horn_o() {
    import("stl/horn_o.stl");
}
module horn_s() {
    import("stl/horn_s.stl");
}
module horn_w() {
    import("stl/horn_w.stl");
}
module horn_e() {
    import("stl/horn_e.stl");
}
module horn_nw() {
    import("stl/horn_nw.stl");
}
module horn_ne() {
    import("stl/horn_ne.stl");
}
module horn_sw() {
    import("stl/horn_sw.stl");
}
module horn_se() {
    import("stl/horn_se.stl");
}
