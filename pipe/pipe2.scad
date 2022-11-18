function curve_length(radius, angle) = radius * tan(angle / 2);

module pipe(segments, i = 0, prev_radius_of_curvature = 0) {
    segment = segments[i];
    length = segment[0];
    outer_radius_start = segment[1];
    inner_radius_start = segment[2];
    outer_radius_end = segment[3];
    inner_radius_end = segment[4];
    rotation = segment[5];
    angle = segment[6];
    radius_of_curvature = segment[7];
    straight_part_color = segment[8];
    curved_part_color = segment[9];
    pipe_segment(segment, prev_radius_of_curvature);

    translate([0, 0, length]) {
        rotate([angle, 0, rotation]) {
            if (i < len(segments) - 1) {
                next_radius_of_curvature = curve_length(radius_of_curvature, angle);
                pipe(segments, i + 1, next_radius_of_curvature);
            }
        }
    }
}

module pipe_segment(segment, prev_radius_of_curvature) {
    //echo(str("segment=", segment));
    length = segment[0];
    outer_radius_start = segment[1];
    inner_radius_start = segment[2];
    outer_radius_end = segment[3];
    inner_radius_end = segment[4];
    rotation = segment[5];
    angle = segment[6];
    radius_of_curvature = segment[7];
    straight_part_color = segment[8];
    curved_part_color = segment[9];
    curve_length = curve_length(radius_of_curvature, angle);
    straight_pipe(segment, prev_radius_of_curvature);
    translate([0, 0, length - curve_length]) {
        curved_pipe(segment);
    }
}

module straight_pipe(segment, prev_radius_of_curvature) {
    length = segment[0];
    outer_radius_start = segment[1];
    inner_radius_start = segment[2];
    outer_radius_end = segment[3];
    inner_radius_end = segment[4];
    rotation = segment[5];
    angle = segment[6];
    radius_of_curvature = segment[7];
    straight_part_color = segment[8];
    curved_part_color = segment[9];
    curve_length = curve_length(radius_of_curvature, angle);
    h = length - prev_radius_of_curvature - curve_length;
    translate([0, 0, prev_radius_of_curvature]) {
        color(straight_part_color) {
            difference() {
                cylinder(h = h, r1 = outer_radius_start, r2 = outer_radius_end);
                cylinder(h = h, r1 = inner_radius_start, r2 = inner_radius_end);
            }
        }
    }
}

module curved_pipe(segment) {
    length = segment[0];
    outer_radius_start = segment[1];
    inner_radius_start = segment[2];
    outer_radius_end = segment[3];
    inner_radius_end = segment[4];
    rotation = segment[5];
    angle = segment[6];
    radius_of_curvature = segment[7];
    straight_part_color = segment[8];
    curved_part_color = segment[9];
    rotate([90, 0, rotation + 90]) {
        translate([- radius_of_curvature, 0, 0]) {
            color(curved_part_color) {
                rotate_extrude(angle = angle) {
                    difference() {
                        translate([radius_of_curvature, 0, 0]) {
                            difference() {
                                circle(r = outer_radius_end);
                                circle(r = inner_radius_end);
                            }
                        }
                        translate([- outer_radius_end, 0, 0]) square(size = [outer_radius_end * 2, outer_radius_end * 2]
                        , center = true);
                    }
                }
            }
        }
    }
}
