$fn = 100;

include <BOSL2/std.scad>

desk_t      = 20.05; // the thickness of your desk
top_clamp_t = 5;
bot_clamp_t = 30;
conn_t      = 6;
w           = 50;
top_d       = 60;
bot_d       = 110;
hitbox_t    = 18;
total_h = bot_clamp_t + desk_t + top_clamp_t;

module clamp() {
  diff("remove")
    // BACKBONE CONNECTOR
    cuboid([w, conn_t, total_h],
           anchor=BOTTOM, rounding=3, edges=TOP+FRONT) {
    // TOP CLAMP
    attach(BACK, FRONT, align=TOP) {
      cuboid([w, top_d, top_clamp_t],
             anchor=BOTTOM, rounding=2, edges=TOP+BACK);
    }
    // BOTTOM CLAMP
    attach(BACK, FRONT, align=BOTTOM) {
      cuboid([w, bot_d, bot_clamp_t], anchor=BOTTOM) {
        // CUTOUT
        attach(LEFT, RIGHT, overlap=40) {
          tag("remove") right(6) #cuboid([bot_d, bot_d, hitbox_t], anchor=BOTTOM);
        }
        // BRACKET SLOTS
        attach(RIGHT, LEFT, align=FRONT, overlap=4) {
          tag("remove") #cuboid([50, 4, hitbox_t], anchor=BOTTOM);
        }
        attach(RIGHT, LEFT, align=BACK, overlap=4) {
          tag("remove") left(6) #cuboid([50, 4, hitbox_t], anchor=BOTTOM);
        }
      }
    }
  }
}

clamp();
