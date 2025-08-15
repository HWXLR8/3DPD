$fn = 50;

include <BOSL2/std.scad>

2u = 44.45 * 2;
ear_w = 14.5;
gap = 10;

fan_hole_r = 6/2;
fan_hole_dx = 71.5;
fan_hole_dy = fan_hole_dx;

fan_x = 80;
fan_y = fan_x;
fan_pad = 7.5;
fan_r = 76/2;

// main plate
module plate() {
  difference() {
    rect([fan_x + fan_pad, 2u]
         //anchor = BOT+LEFT
         );

    translate([fan_hole_dx/2, fan_hole_dy/2, 0]) {
      circle(fan_hole_r);
    }
    translate([fan_hole_dx/2, -fan_hole_dy/2, 0]) {
      circle(fan_hole_r);
    }
    translate([-fan_hole_dx/2, -fan_hole_dy/2, 0]) {
      circle(fan_hole_r);
    }
    translate([-fan_hole_dx/2, fan_hole_dy/2, 0]) {
      circle(fan_hole_r);
    }

    // fan circle
    circle(fan_r);
  }
}

module ear() {
  rack_hole_r = 6.7/2;
  rack_hole_dy = 33 - 1.35;
  delta_u = 12.5;

  difference() {
    rect([ear_w, 2u]);

    translate([0, delta_u/2, 0]) {
      circle(rack_hole_r);
    }
    translate([0, delta_u/2 + rack_hole_dy, 0]) {
      circle(rack_hole_r);
    }
    translate([0, -delta_u/2, 0]) {
      circle(rack_hole_r);
    }
    translate([0, -delta_u/2 - rack_hole_dy, 0]) {
      circle(rack_hole_r);
    }
  }
}

linear_extrude(3) {
  plate();
  translate([(fan_x+fan_pad)/2 + (gap/2), 0, 0]) {
    rect([gap, 2u]);
  }
  translate([(fan_x+fan_pad)/2 + (ear_w/2) + gap, 0, 0]) {
    ear();
  }
}
