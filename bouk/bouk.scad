bothSides = false;

thickness = 1; // [1:0.1:10]

thicknessBase = 1; // [0:0.1:10]

bouk(thickness, thicknessBase, bothSides);

module bouk(thickness, thicknessBase, bothSides = false) {
    color("yellow") {
        linear_extrude(thicknessBase) {
            import("svg/path_base.svg");
        }
    }
    color("blue") {
        translate([0, 0, thicknessBase]) {
            linear_extrude(thickness) {
                bouk2D();
            }
        }
    }
    if (bothSides) {
        color("blue") {
            translate([0, 0, - thickness]) {
                linear_extrude(thickness) {
                    bouk2D();
                }
            }
        }
    }
}

module bouk2D() {
    import("svg/splited_svg_path/path_0.svg");
    import("svg/splited_svg_path/path_1.svg");
    import("svg/splited_svg_path/path_2.svg");
    import("svg/splited_svg_path/path_3.svg");
    import("svg/splited_svg_path/path_4.svg");
    import("svg/splited_svg_path/path_5.svg");
    import("svg/splited_svg_path/path_6.svg");
    import("svg/splited_svg_path/path_7.svg");
    import("svg/splited_svg_path/path_8.svg");
    import("svg/splited_svg_path/path_9.svg");
    import("svg/splited_svg_path/path_10.svg");
    import("svg/splited_svg_path/path_11.svg");
    import("svg/splited_svg_path/path_12.svg");
    import("svg/splited_svg_path/path_13.svg");
    import("svg/splited_svg_path/path_14.svg");
    import("svg/splited_svg_path/path_15.svg");
    import("svg/splited_svg_path/path_16.svg");
    import("svg/splited_svg_path/path_17.svg");
    import("svg/splited_svg_path/path_18.svg");
    import("svg/splited_svg_path/path_19.svg");
    import("svg/splited_svg_path/path_20.svg");
    import("svg/splited_svg_path/path_21.svg");
    import("svg/splited_svg_path/path_22.svg");
    import("svg/splited_svg_path/path_23.svg");
    import("svg/splited_svg_path/path_24.svg");
    import("svg/splited_svg_path/path_25.svg");
    import("svg/splited_svg_path/path_26.svg");
    import("svg/splited_svg_path/path_27.svg");
    import("svg/splited_svg_path/path_28.svg");
    import("svg/splited_svg_path/path_29.svg");
    import("svg/splited_svg_path/path_30.svg");
    import("svg/splited_svg_path/path_31.svg");
    import("svg/splited_svg_path/path_32.svg");
    import("svg/splited_svg_path/path_33.svg");
    import("svg/splited_svg_path/path_34.svg");
    import("svg/splited_svg_path/path_35.svg");
    import("svg/splited_svg_path/path_36.svg");
    import("svg/splited_svg_path/path_37.svg");
    import("svg/splited_svg_path/path_38.svg");
    import("svg/splited_svg_path/path_39.svg");
    import("svg/splited_svg_path/path_40.svg");
    import("svg/splited_svg_path/path_41.svg");
    import("svg/splited_svg_path/path_42.svg");
    import("svg/splited_svg_path/path_43.svg");
    import("svg/splited_svg_path/path_44.svg");
    import("svg/splited_svg_path/path_45.svg");
    import("svg/splited_svg_path/path_46.svg");
    import("svg/splited_svg_path/path_47.svg");
    import("svg/splited_svg_path/path_48.svg");
    import("svg/splited_svg_path/path_49.svg");
    import("svg/splited_svg_path/path_50.svg");
    import("svg/splited_svg_path/path_51.svg");
    import("svg/splited_svg_path/path_52.svg");
    import("svg/splited_svg_path/path_53.svg");
    import("svg/splited_svg_path/path_54.svg");
    import("svg/splited_svg_path/path_55.svg");
    import("svg/splited_svg_path/path_56.svg");
    import("svg/splited_svg_path/path_57.svg");
    import("svg/splited_svg_path/path_58.svg");
    import("svg/splited_svg_path/path_59.svg");
    import("svg/splited_svg_path/path_60.svg");
    import("svg/splited_svg_path/path_61.svg");
    import("svg/splited_svg_path/path_62.svg");
    import("svg/splited_svg_path/path_63.svg");
    import("svg/splited_svg_path/path_64.svg");
    import("svg/splited_svg_path/path_65.svg");
    import("svg/splited_svg_path/path_66.svg");
    import("svg/splited_svg_path/path_67.svg");
    import("svg/splited_svg_path/path_68.svg");
    import("svg/splited_svg_path/path_69.svg");
    import("svg/splited_svg_path/path_70.svg");
    import("svg/splited_svg_path/path_71.svg");
    import("svg/splited_svg_path/path_72.svg");
    import("svg/splited_svg_path/path_73.svg");
    import("svg/splited_svg_path/path_74.svg");
    import("svg/splited_svg_path/path_75.svg");
    import("svg/splited_svg_path/path_76.svg");
    import("svg/splited_svg_path/path_77.svg");
    import("svg/splited_svg_path/path_78.svg");
    import("svg/splited_svg_path/path_79.svg");
    import("svg/splited_svg_path/path_80.svg");
    import("svg/splited_svg_path/path_81.svg");
    import("svg/splited_svg_path/path_82.svg");
    import("svg/splited_svg_path/path_83.svg");
    import("svg/splited_svg_path/path_84.svg");
    import("svg/splited_svg_path/path_85.svg");
    import("svg/splited_svg_path/path_86.svg");
    import("svg/splited_svg_path/path_87.svg");
    import("svg/splited_svg_path/path_88.svg");
    import("svg/splited_svg_path/path_89.svg");
    import("svg/splited_svg_path/path_90.svg");
    import("svg/splited_svg_path/path_91.svg");
    import("svg/splited_svg_path/path_92.svg");
    import("svg/splited_svg_path/path_93.svg");
    import("svg/splited_svg_path/path_94.svg");
    import("svg/splited_svg_path/path_95.svg");
    import("svg/splited_svg_path/path_96.svg");
    import("svg/splited_svg_path/path_97.svg");
    import("svg/splited_svg_path/path_98.svg");
    import("svg/splited_svg_path/path_99.svg");
    import("svg/splited_svg_path/path_100.svg");
    import("svg/splited_svg_path/path_101.svg");
    import("svg/splited_svg_path/path_102.svg");
    import("svg/splited_svg_path/path_103.svg");
    import("svg/splited_svg_path/path_104.svg");
    import("svg/splited_svg_path/path_105.svg");
    import("svg/splited_svg_path/path_106.svg");
    import("svg/splited_svg_path/path_107.svg");
    import("svg/splited_svg_path/path_108.svg");
    import("svg/splited_svg_path/path_109.svg");
    import("svg/splited_svg_path/path_110.svg");
    import("svg/splited_svg_path/path_111.svg");
    import("svg/splited_svg_path/path_112.svg");
    import("svg/splited_svg_path/path_113.svg");
    import("svg/splited_svg_path/path_114.svg");
    import("svg/splited_svg_path/path_115.svg");
    import("svg/splited_svg_path/path_116.svg");
    import("svg/splited_svg_path/path_117.svg");
    import("svg/splited_svg_path/path_118.svg");
    import("svg/splited_svg_path/path_119.svg");
    import("svg/splited_svg_path/path_120.svg");
    import("svg/splited_svg_path/path_121.svg");
    import("svg/splited_svg_path/path_122.svg");
    import("svg/splited_svg_path/path_123.svg");
    import("svg/splited_svg_path/path_124.svg");
    import("svg/splited_svg_path/path_125.svg");
    import("svg/splited_svg_path/path_126.svg");
    import("svg/splited_svg_path/path_127.svg");
    import("svg/splited_svg_path/path_128.svg");
    import("svg/splited_svg_path/path_129.svg");
    import("svg/splited_svg_path/path_130.svg");
    import("svg/splited_svg_path/path_131.svg");
    import("svg/splited_svg_path/path_132.svg");
}
