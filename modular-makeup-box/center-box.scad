top_inner = 20;
wall_thickness = 1.5;
base_thickness = 3;

cutout_inner = 14;
cutout_outer = 7;

min_height = 60;
max_height = 100;

module trapezoid(b, t, h) {
    polygon(points=[
        [-b/2, -h/2],
        [+b/2, -h/2],
        [+t/2, +h/2],
        [-t/2, +h/2]
    ]);
}

module hexagon(side) {
    r = side;  // for a regular hexagon
    points = [for (i = [0:5]) [r * cos(i * 60), r * sin(i * 60)]];
    polygon(points);
}

// Put trapezoid on each side of a hexagon
module hex_with_trapezoids(hex_side, trap_base, trap_top, trap_height) {
    r = hex_side;  // For regular hexagon: side = radius to vertex
    points = [for (i = [0:5]) [r * cos(i * 60), r * sin(i * 60)]];

    for (i = [0:5]) {
        p1 = points[i];
        p2 = points[(i + 1) % 6];

        center = [ (p1[0] + p2[0]) / 2, (p1[1] + p2[1]) / 2 ];

        // Angle between p2 and p1 from the x-xis
        angle = atan2(p2[1] - p1[1], p2[0] - p1[0]);

        // Place and rotate the trapezoid
        translate(center)
            rotate(angle)
                trapezoid(trap_base, trap_top, trap_height);
    }
}

difference () {
    // Center container is a hexagonal shape with side length: top_inner
    linear_extrude(max_height)
        hexagon(top_inner);
    
    translate([0, 0, base_thickness]){
        linear_extrude(max_height)
            hexagon(top_inner - 2 * wall_thickness);
    }
}

linear_extrude(min_height)
hex_with_trapezoids(
    hex_side = top_inner,
    trap_base = cutout_outer,
    trap_top = cutout_inner,
    trap_height = wall_thickness * 2
);