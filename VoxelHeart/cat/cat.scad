
cat_svg();

module cat_svg(center=true) {
    tranlation = center?[-300, -425]:[0,0];
    translate(tranlation+[-100, 550])
        difference() {
            union() {
                //import("split_svg_path/path_0.svg");
                //import("split_svg_path/path_1.svg"); // all
                import("split_svg_path/path_3.svg"); // contour
                import("split_svg_path/path_21.svg"); // belly V
                import("split_svg_path/path_11.svg"); // mouth
                import("split_svg_path/path_28.svg"); // mouth 2
                import("split_svg_path/path_26.svg"); // nose top
                import("split_svg_path/path_18.svg"); // moustash left
                import("split_svg_path/path_17.svg"); // moustash right
                import("split_svg_path/path_22.svg"); // eyebrow right
                import("split_svg_path/path_20.svg"); // eyebrow left
                import("split_svg_path/path_27.svg"); // fur tail
                import("split_svg_path/path_6.svg"); // eye out right
                import("split_svg_path/path_5.svg"); // eye out left
                import("split_svg_path/path_9.svg"); // ear left
                import("split_svg_path/path_10.svg"); // ear right
            }
            import("split_svg_path/path_19.svg"); // nose in
            import("split_svg_path/path_7.svg"); // ear right in
            import("split_svg_path/path_23.svg"); // pupille left
            import("split_svg_path/path_24.svg"); // pupille right
            import("split_svg_path/path_12.svg"); // eye in left
            import("split_svg_path/path_13.svg"); // eye in right
            import("split_svg_path/path_2.svg"); // body in
            import("split_svg_path/path_4.svg"); // tail in
            import("split_svg_path/path_8.svg"); // leg left
            import("split_svg_path/path_14.svg"); // paw right
            import("split_svg_path/path_15.svg"); // paw left
            import("split_svg_path/path_16.svg"); // tail out
            import("split_svg_path/path_25.svg"); // fur
        }
}