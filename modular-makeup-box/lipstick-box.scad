module trapezoid(b, t, h) {
    polygon(points=[
        [-b/2, -h/2],
        [+b/2, -h/2],
        [+t/2, +h/2],
        [-t/2, +h/2]
    ]);
}

module sloped_trapezoid_3d(trapezoid_base, trapezoid_top, trapezoid_height, min_height, max_height) {
    base_pts = [
        [-trapezoid_base/2, -trapezoid_height/2],
        [+trapezoid_base/2, -trapezoid_height/2],
        [+trapezoid_top/2, +trapezoid_height/2],
        [-trapezoid_top/2, +trapezoid_height/2]
    ];
    
    // Convert base points to 3D bottom and sloped top
    bottom = [for (p = base_pts) [p[0], p[1], 0]];
    top = [
        [base_pts[0][0], base_pts[0][1], min_height],  // short side
        [base_pts[1][0], base_pts[1][1], min_height],  // short side
        [base_pts[2][0], base_pts[2][1], max_height],  // tall side
        [base_pts[3][0], base_pts[3][1], max_height]   // tall side
    ];

    // Combine into 8-point polyhedron (bottom + top)
    polyhedron(
        points = concat(bottom, top),
        faces = [
            [0,1,2,3],  // bottom face
            [4,5,6,7],  // top face
            [0,1,5,4],  // front
            [1,2,6,5],  // right
            [2,3,7,6],  // back
            [3,0,4,7]   // left
        ]
    );
}

module lipstick_box(top_inner, fatness, wall_thickness, min_height, max_height) {
    fatness_inner = fatness;
    fatness_outer = fatness_inner + (4 * wall_thickness);
    base_inner = top_inner + (2 * fatness_inner / tan(60));
    base_outer = top_inner + (2 * fatness_outer / tan(60));
 
    
    difference() {
        sloped_trapezoid_3d(base_outer, top_inner, fatness_outer, min_height, max_height);
        linear_extrude(max_height)
            trapezoid(base_inner, top_inner, fatness_inner);
    }
}

module lipstick_box_3d(top_inner, fatness, wall_thickness, height) {
    linear_extrude(height, scale=[1, 1])
        lipstick_box(20, fatness, wall_thickness);
    
    linear_extrude(base_thickness)
        trapezoid(top_inner + (2 * fatness / tan(60)), top_inner, fatness);
}

fatness = 40;
top_inner = 20;
wall_thickness = 1.5;
base_thickness = 3;
//color([1, 0, 0, 0.5])

cutout_inner = 14;
cutout_outer = 7;

min_height = 60;
max_height = 100;
lipstick_box(top_inner, fatness, wall_thickness, min_height, max_height);

/*
difference() {
    //translate ([0, -fatness/2, 0])
    lipstick_box_3d(top_inner, fatness, wall_thickness, min_height);

    // Opening for sliding
    linear_extrude(min_height - base_thickness){
        translate([0, (fatness/2)+wall_thickness, 0])
            trapezoid(cutout_inner, cutout_outer, wall_thickness*2);
    }
}
*/

