$fn = 100;

include <BOSL2/std.scad>

outer = 48.6833 + 0.5;
inner = 38.6833 + 0.5;
h = 100;

difference() {
  cuboid([outer, outer, h], anchor=BOT,
         chamfer=5,
         edges=[FRONT+RIGHT,
                FRONT+LEFT,
                BACK+RIGHT,
                BACK+LEFT]);
  cuboid([inner, inner, h], anchor=BOT);
}
