$fn = 500;

hole_offset = 73.5/2; // from origin
hole_size = 3.5;
plate_radius = 95/2;
plate_thickness = 3;

linear_extrude(plate_thickness) {
    difference() {
        circle(plate_radius);
        translate([hole_offset, 0, 0]) {
            circle(d = hole_size);
        }
        translate([-hole_offset, 0, 0]) {
            circle(d = hole_size);
        }
        translate([0, hole_offset, 0]) {
            circle(d = hole_size);
        }
        translate([0, -hole_offset, 0]) {
            circle(d = hole_size);
        }
    }
}