// inner side = the length of _one_ side of the inner hexagon
// thickness = the orthogonal distance two sides
module hexagon(inner_side, thickness, height, gap = 0) {
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
        trapezoid(
            bottom = outer_side - gap, 
            top = inner_side - gap, 
            height = thickness
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
    hexagon((inner_opening / tan(60)) + (wall_thickness*1.5), 
            box_size + (wall_thickness),
            height = 70,
            gap = wall_thickness*1.5
    );
}