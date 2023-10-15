$fn = 50;

module aligned_cube( size, align = [ 0, 0, 0 ] )
 translate(size/2*[[align[0],0,0],[0,align[1],0],[0,0,align[2]]])
  cube( size, center = true );
  
base = [127.5, 127.5, 8];
wall = [base.x, base.y, 55];
wall_thickness = 5;
hole_spacing = [89.5/2, 82.5/2];
hole_inner = 2;
hole_outer = 5;
post_height = 17;
fan = [120, 120, 25];
wall_slot_height = 10;
wall_slot_size = 80;
ledge_height = post_height + 17.5;
ledge_depth = 5;

// mounting posts
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


// base
aligned_cube(base, align = [0, 0, 1]);

// walls
translate([0, 0, base.z]) {
    difference() {
        aligned_cube(wall, align = [0, 0, 1]);
        aligned_cube([wall.x - wall_thickness, 
              wall.y - wall_thickness, 
              wall.z], 
              align = [0, 0, 1]);
        // wall slot/cutout
        translate([0, 0, wall_slot_height]) {
        aligned_cube([base.x, hole_spacing.y * 2, wall_slot_size], align = [0, 0, 1]);
        aligned_cube([hole_spacing.x * 2, base.y, wall_slot_size], align = [0, 0, 1]);
        }
    }
}

// fan ledge
difference() {
    aligned_cube([wall.x, wall.y, post_height + 20], align = [0, 0, 1]);
    aligned_cube([wall.x - wall_thickness - ledge_depth, 
          wall.y - wall_thickness - ledge_depth, 
          post_height + 20], 
          align = [0, 0, 1]);
    aligned_cube([base.x, hole_spacing.y * 2, wall_slot_size], align = [0, 0, 1]);
    aligned_cube([hole_spacing.x * 2, base.y, wall_slot_size], align = [0, 0, 1]);
}

// fan
translate([0, 0, 50]) {
#cube(fan, center = true);
}