$fn = 100;

include <BOSL2/std.scad>
include <BOSL2/threading.scad>

tongji_d = 27.20;
tongji_h = 4.7;
cannon_d = 3;
cannon_h = 2.5;

mvmt_d = tongji_d;
mvmt_h = tongji_h;

// base
diff() {
  threaded_rod(d=mvmt_d + 4,
               l=mvmt_h,
               pitch=1.5) {
    tag("remove") cyl(d=mvmt_d, h=mvmt_h);
    // base cylinder
    attach(BOT,TOP) cyl(d=mvmt_d+6, h=mvmt_h+3) {
      // cannon pinon cutout
      attach(TOP, BOT, overlap=cannon_h)
        tag("remove") #cyl(d=cannon_d, h=cannon_h);
    }
  }
}

// cap
translate([0,0,20]) {
diff() {
    cyl(d=mvmt_d + 6, h=mvmt_h + 3) {
      attach(BOT,TOP,overlap=mvmt_h) tag("remove")
        #threaded_rod(d=mvmt_d + 4,
                      l=mvmt_h,
                      pitch=1.5,
                      internal=true,
                      $slop = 0.075
                      );
    }
 }
}
