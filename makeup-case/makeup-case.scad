module hexagon(inner_side, thickness) {
    outer_side = inner_side + 2 * thickness / tan(60);
    
    module trapezoid(bottom=outer_side, top=inner_side, height=thickness) {
    polygon(points=[
        [-bottom/2, -height/2],
        [+bottom/2, -height/2],
        [+top/2, +height/2],
        [-top/2, +height/2]
    ]);
    }
    
    center_radius = (tan(60) * inner_side /2) + thickness/2;
    for(i = [0:5])
        rotate([0, 0, i*60])
        linear_extrude(height = 50)
        translate([0, -center_radius])
        trapezoid(bottom = outer_side, top = inner_side, height = thickness);
}

difference() {
hexagon(20, 20);
hexagon(25, 10);
}