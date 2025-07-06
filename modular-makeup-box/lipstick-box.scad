module trapezoid(b, t, h) {
    polygon(points=[
        [-b/2, -h/2],
        [+b/2, -h/2],
        [+t/2, +h/2],
        [-t/2, +h/2]
    ]);
}

module lipstick_box(top_inner, fatness, wall_thickness) {
    fatness_inner = fatness;
    fatness_outer = fatness_inner + (4 * wall_thickness);
    base_inner = top_inner + (2 * fatness_inner / tan(60));
    base_outer = top_inner + (2 * fatness_outer / tan(60));
 
    difference() {
        trapezoid(base_outer, top_inner, fatness_outer);
        trapezoid(base_inner, top_inner, fatness_inner);
    }
}

fatness = 40;
top_inner = 20;
wall_thickness = 1.5;
//color([1, 0, 0, 0.5])

cutout_inner = 14;
cutout_outer = 7;
difference() {
//translate ([0, -fatness/2, 0])
lipstick_box(20, fatness, wall_thickness);

translate([0, (fatness/2)+wall_thickness, 0])
trapezoid(cutout_inner, cutout_outer, wall_thickness*2);
}