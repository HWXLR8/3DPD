$fn = 50;

base = [100, 100, 5];
hole_spacing = [89.5/2, 82.5/2];
hole_inner = 2;
hole_outer = 5;
post_height = 17;


translate(hole_spacing) {
    difference() {
        cylinder(h = post_height, d = hole_outer);
        cylinder(h = post_height, d = hole_inner);
    }
}

translate(-hole_spacing) {
    difference() {
        cylinder(h = post_height, d = hole_outer);
        cylinder(h = post_height, d = hole_inner);
    }
}

translate([hole_spacing.x, -hole_spacing.y]) {
    difference() {
        cylinder(h = post_height, d = hole_outer);
        cylinder(h = post_height, d = hole_inner);
    }
}

translate([-hole_spacing.x, hole_spacing.y]) {
    difference() {
        cylinder(h = post_height, d = hole_outer);
        cylinder(h = post_height, d = hole_inner);
    }
}

cube(base, center = true);