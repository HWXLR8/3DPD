$fn = 100;

include <BOSL2/std.scad>

wall = 3;

// normal
in_x = 55;
in_y = 20;

// XL
// in_x = 60;
// in_y = 25;

out_x = in_x + wall*2;
out_y = in_y + wall*2;
h = 15;
r_inner = 4;
r_outer = r_inner + wall;

linear_extrude(h) {
  difference() {
    rect([out_x, out_y], rounding=r_outer);
    rect([in_x, in_y], rounding=r_inner);
  }
}
