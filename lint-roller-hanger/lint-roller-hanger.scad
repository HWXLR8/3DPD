$fn=100;

thickness = 9;
radius = thickness/2;

// clothes rack dimensions
rack_curvature = 230;
rack_thickness = 8;
// lint roller dimensions
roller_curvature = 180;
roller_thickness = 17;
hook_depth=30;

// do not edit these
rack_radius = (rack_thickness + thickness) / 2;
roller_radius = (roller_thickness + thickness) / 2;

module hook() {
        // straight part
        translate([0, 0, 0])
            rotate([90,0,0])
            cylinder(hook_depth, radius, radius);
        // part which hooks onto lint roller
        translate([-roller_radius, 0, 0])
            rotate_extrude(angle=roller_curvature)
                translate([roller_radius, 0])
                    circle(radius);
        // part which hangs onto clothes rack
        translate([rack_radius, -hook_depth, 0])
            rotate_extrude(angle=rack_curvature)
                translate([-rack_radius, 0])
                    circle(radius);  
}

// flatten the sides for easy printing
cube_x = 100;
cube_y = 100;
cube_z = 1;
difference() {
hook();
translate([0, 0, (cube_z/2) + radius - 1])
    cube([cube_x, cube_y, cube_z], center=true);
translate([0, 0, -(cube_z/2) - radius + 1])
    cube([cube_x, cube_y, cube_z], center=true);
}