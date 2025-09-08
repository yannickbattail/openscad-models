$fn = 100;
slices = 10; // [6 : 12]

pumkin(slices);


function rndAroundN(around, moreOrLess, value_count)
= rands(around - moreOrLess, around + moreOrLess, value_count);
function rndAround(around, moreOrLess)
= rands(around - moreOrLess, around + moreOrLess, 1)[0];

module pumkin(slices) {
    for (a = [1:slices]) {
        rotate([0, 0, 360 / slices * a]) {
            r = rndAround(30, 5);
            translate([rndAround(r, 5), 0, 0]) {
                scale([1.5, 0.9, 1.2])
                    sphere(100);
            }
        }
    }
    translate([0, 0, 110])
        linear_extrude(50, twist = 200, scale = 0.5)
            translate([8, 0])
                circle(14);
    rotate([180, 0, 0])
        translate([0, 0, 115])
            linear_extrude(10, scale = 0.6)
                circle(26);
}
