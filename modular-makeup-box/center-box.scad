module hexagon(side) {
    r = side;  // for a regular hexagon
    points = [for (i = [0:5]) [r * cos(i * 60), r * sin(i * 60)]];
    polygon(points);
}
fatness = 40;
top_inner = 20;
wall_thickness = 1.5;
base_thickness = 3;

cutout_inner = 14;
cutout_outer = 7;

min_height = 60;
max_height = 100;

difference () {
    // Center container is a hexagonal shape with side length: top_inner
    linear_extrude(max_height)
        hexagon(top_inner);
    
    translate([0, 0, wall_thickness]){
        linear_extrude(max_height)
            hexagon(top_inner - 2 * wall_thickness);
    }
}


