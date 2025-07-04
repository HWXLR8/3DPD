// inner side = the length of _one_ side of the inner hexagon
// thickness = the orthogonal distance two sides
module hexagon(inner_side, thickness, height, gap = 0) {
    outer_side = inner_side + 2 * thickness / tan(60);

    module trapezoid(b=outer_side, t=inner_side, h=thickness) {
    polygon(points=[
        [-b/2, -h/2],
        [+b/2, -h/2],
        [+t/2, +h/2],
        [-t/2, +h/2]
    ]);
    }

    center_radius = (tan(60) * inner_side /2) + thickness/2;
    for(i = [0:5])
        rotate([0, 0, i*60])
        linear_extrude(height)
        translate([0, -center_radius])
        trapezoid(
            b = outer_side - gap,
            t = inner_side - gap,
            h = thickness
        );
}

inner_opening = 30;
wall_thickness = 3;
box_size = 40;

difference() {
    // shell
    hexagon(inner_opening / tan(60),
            box_size + (4 * wall_thickness),
            height = 60
    );
    // cutout
    hexagon((inner_opening / tan(60)) + (wall_thickness),
            box_size + (wall_thickness * 2),
            height = 60,
            gap = wall_thickness*1
    );
}

module hex_base(radius, height) {
    linear_extrude(height)
        polygon(points = [ for (i = [0:5])
            [cos(i * 60) * radius, sin(i * 60) * radius]
        ]);
}

base_thickness = 3;
hex_base(box_size + (7 * wall_thickness) + inner_opening/2, base_thickness);
