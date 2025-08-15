$fn = 50;

include <BOSL2/std.scad>

mid_w = 2.2;
mid_l = 9;
mid_h = 1.5;

ledge_l = 8;
ledge_h = mid_h + 1.52;
ledge_side_h = mid_h + 7.5;

side_w = mid_w;
side_l = mid_l;
side_h = mid_h + 3;

bridge_l = 6.2;

light_t = 1.5;
light_w = 9.8;
light_h = light_w;

// mid section
cuboid([mid_w, mid_l, mid_h], anchor=BOT) {

  // right side
  attach (RIGHT, LEFT, align=BOT+BACK) {
    cuboid([side_w, side_l, side_h]);
  }
  // left side
  attach (LEFT, RIGHT, align=BOT+BACK) {
    cuboid([side_w, side_l, side_h]);
  }

  // raised mid-section
  attach (FRONT, BACK, align=BOT) {
    cuboid([side_w, ledge_l, ledge_h]);
  }
  // raised right-side
  attach (FRONT+RIGHT, BACK+LEFT, align=BOT) {
    cuboid([side_w, ledge_l, ledge_side_h]);
  }
  // raised left-side
  attach (FRONT+LEFT, BACK+RIGHT, align=BOT) {
    cuboid([side_w, ledge_l, ledge_side_h]);
  }

  // bridge between base and light
  attach (BACK, FRONT) {
    cuboid([mid_w, bridge_l, mid_h]) {
      // light base
      attach (BACK, FRONT, align=BOT) {
        cuboid([light_w, light_t, mid_h]) {
          // light front-right bar
          attach (FRONT, BACK, align=BOT+RIGHT) {
            cuboid([light_t, light_t, light_h]);
          }
          // light front-left bar
          attach (FRONT, BACK, align=BOT+LEFT) {
            cuboid([light_t, light_t, light_h]);
          }
          // light back-right bar
          attach (BACK, FRONT, align=BOT+RIGHT) {
            cuboid([light_t, light_t, light_h]);
          }
          // light back-left bar
          attach (BACK, FRONT, align=BOT+LEFT) {
            cuboid([light_t, light_t, light_h]);
          }
        }
      }
    }
  }
}
