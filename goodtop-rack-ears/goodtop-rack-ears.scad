$fn = 50;

include <BOSL2/std.scad>

switch_w = 201.5;
switch_h = 44;
rack_w = 223.0;

// switch-facing plate
module switch_plate() {
  switch_hole_dx = 34;
  switch_hole_dy = switch_hole_dx;
  switch_hole_r = 3.7/2; // ~M3
  switch_hole_inset = 6.11; // how deep the first hole is

  difference() {
    square(switch_h);
    // holes
    translate([switch_hole_inset - switch_hole_r,
               (switch_h - switch_hole_dy) / 2,
               0]) {
      circle(switch_hole_r);
      translate([switch_hole_dx, 0, 0]) {
        circle(switch_hole_r);
      }
      translate([0, switch_hole_dy, 0]) {
        circle(switch_hole_r);
      }
      translate([switch_hole_dx, switch_hole_dy, 0]) {
        circle(switch_hole_r);
      }
    }
  }
}

module rack_plate() {
  rack_hole_r = 6.7/2;
  rack_hole_dy = 33;

  gap = ((rack_w - switch_w) / 2);
  ear = 13;

  difference() {
    rect([gap + ear, switch_h],
         rounding = [3, 0, 0, 3],
         anchor=BOT+LEFT);
    // holes
    translate([gap + (ear / 2),
               (switch_h - rack_hole_dy) / 2,
               0]) {
      circle(rack_hole_r);
      translate([0, rack_hole_dy, 0]) {
        circle(rack_hole_r);
      }
    }
  }
}

module ear(st, rt) {
  linear_extrude(rt) {
    rack_plate();
  }

  rotate([0, 90, 0]) {
    linear_extrude(st) {
      switch_plate();
    }
  }
}

ear(3, 2.5);
