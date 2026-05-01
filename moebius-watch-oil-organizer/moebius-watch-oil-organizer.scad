$fn = 200;

include <BOSL2/std.scad>

bottle_d = 40.25; // bottle diameter
height   = 14;    // slot height
gap      = 5;     // gap between slots
rounding = 10;    // outside corner rounding
grid_x   = 3;     // x slots
grid_y   = 2;     // y slots

base_t   = 3;
spacing = bottle_d + gap;
total_x   = grid_x * bottle_d + (grid_x + 1) * gap;
total_y   = grid_y * bottle_d + (grid_y + 1) * gap;

difference() {
  cuboid(
    [total_x, total_y, height],
    anchor   = BOT,
    rounding = rounding,
    edges    = [LEFT+FRONT, LEFT+BACK, RIGHT+FRONT, RIGHT+BACK]
  );

  for (xi = [0 : grid_x - 1], yi = [0 : grid_y - 1]) {
    translate([
      (xi - (grid_x - 1) / 2) * spacing,
      (yi - (grid_y - 1) / 2) * spacing,
      base_t
    ])
      cylinder(d=bottle_d, h=height + base_t);
  }
}
