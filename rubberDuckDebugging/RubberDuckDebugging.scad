
duck("ARCHI", 12, [0,-6,32], "Bitstream Vera Sans");
//duck("PHP", 15, [0,-6,33], "Bitstream Vera Sans");
//duck(".NET",  15, [2,-6,32], "Bitstream Vera Sans", "C#",  15, [0,-6,33]);
//duck("JAVA",  15, [2,-6,32], "Bitstream Vera Sans", ";-)",  15, [0,-6,33]);
//duck("Javascript",  8, [2, 0, 30], "Bitstream Vera Sans", "HTML/CSS",  8, [-4, 0, 30]);
//duck("Python",  12, [2, 0, 30], "Bitstream Vera Sans", "Hello world",  8, [-4, -2, 30]);
//duck("SQL", 15, [2,-6,32], "Bitstream Vera Sans", "SELECT * FROM",  6, [-4, -2, 30]);
//duck("C/C++", 12, [2,-6,32], "Bitstream Vera Sans", "#include <>",  6, [-4, -2, 30]);
//duck("sh/bash", 10, [2, 0, 30], "Bitstream Vera Sans", "rm -Rf /",  6, [-4, -2, 30]);

module duck(text_string1, text_size1, text_position1, text_font = "Bitstream Vera Sans", text_string2 = "", text_size2 = 15, text_position2 = [0,0,0]) {
    difference()
    {
        import("Rubber_Duck.stl", convexity=10);
        rotate([0, 90, 00]){
            translate(text_position1) {
                rotate([0, 0, 90]){
                        linear_extrude(height=10, convexity=10)
                            text(text_string1, text_size1, font=text_font, halign="center", valign="center");
                }
            }
        }
        rotate([0, -90, 0]){
            translate(text_position2) {
                rotate([0, 0, -90]){
                        linear_extrude(height=10, convexity=10)
                            text(text_string2, text_size2, font=text_font, halign="center", valign="center");
                }
            }
        }
    }
}
