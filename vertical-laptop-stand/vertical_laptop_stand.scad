/* general settings */
baseWidth = 150; // in x direction
baseHeight = 120; // in y direction
totalHeight = 50; // floor height plus wall height

baseDepth = 5.5; // floor height, default: 5.5
wallDepth = 6; // central wall

cornerRadius = 10; // corner radius of base and walls

modular = false;
/* if modular */
distanceWall_1 = 24.0; // height of laptop 1
distanceWall_2 = 10.0; // height of laptop 2

/* if not modular */
wallBase = 2; // additional base at the end of the wall

minDistance =  10; // min wall distance if modular
maxDistance = 35; // max wall distance if modular

slotOffset = baseHeight/3; // distance of slots to center if modular

countersunkScrew = true; // if false, for button or socket head screwes
threadInserts = true;// if true, the walls use thread inserts, instead of screwing directly into the plastic

centerOffset = 10; // shift both walls off-center

/* beauty settings */
$fn = 512; // the higher the number the longer takes the render

/*
 * utility function
 * that mirros a object and ceeps the original
 */
module copyMirror(x,y,z){
  children();
  mirror([x,y,z]) children();
}

/*
 * basic slot form
 */
module slotForm(diamter, height){
  distance = maxDistance-minDistance;

  cube([diamter,distance,height*2], true);
  translate([0,distance/2,0]) cylinder(h=height,d=diamter);
  translate([0,-distance/2,0]) cylinder(h=height,d=diamter);
}

/*
 * the negative of a slot for a M3 screw
 */
module slot(){
  screwDiameter = 3.1;
  screwHeadDiameter = 7;
  screwHeadHeight = 3.5;
  distance = maxDistance-minDistance;

  translate([0,distance/2,0])
    union(){
    slotForm(screwDiameter ,baseDepth);
    slotForm(screwHeadDiameter ,screwHeadHeight);

    if(countersunkScrew){
      copyMirror(0,1,0)
        translate([0,distance/2,screwHeadHeight])
        cylinder(h=baseDepth-screwHeadHeight, d1=screwHeadDiameter, d2=screwDiameter);

      points = [
                [0,0],
                [(screwHeadDiameter-screwDiameter)/2,0],
                [0,baseDepth-screwHeadHeight]
                ];

      copyMirror(1,0,0)
        translate([screwDiameter/2,0,screwHeadHeight])
        rotate([90,0,0])
        linear_extrude(distance,center=true)
        polygon(points);
    }
  }
}

/*
 * the negative for all six slots at the right position
 */
module solts(){

  copyMirror(0,1,0)
    translate([0,minDistance+wallDepth,0])
    union(){
    slot();
    copyMirror(1,0,0)
      translate([slotOffset,0,0])
      slot();
  }
}

/*
 * the center wall
 * that has rounded corners on the top side
 */
module wall(){
  // center wall
  translate([0,0,totalHeight/2])
    rotate([90,0,0])
    linear_extrude(wallDepth, center=true)
    offset(cornerRadius)
    square([baseWidth - cornerRadius*2, totalHeight - cornerRadius*2], true);

  // center wall lower half, to hide rouded corners on lower half
  linear_extrude(totalHeight/2)
    square([baseWidth, wallDepth], true);
}

/*
 * the base with the six slots and a central wall
 */
module base(){
  difference(){
    // base plate
    linear_extrude(baseDepth)
      offset(cornerRadius)
      square([baseWidth - cornerRadius*2, baseHeight - cornerRadius*2], true);

    if(modular)
      solts();
  }

  translate([0, centerOffset, 0]) wall();
}

/*
 * the negative of the screw holes in the wall
 */
module screwNegative(){
  screwDiameter = 3.05;
  threadDiameter = 5;
  diffRadius = (threadDiameter-screwDiameter)/2;
  translate([0,0,baseDepth]){
    cylinder(h=16.5, d=screwDiameter);
    if(threadInserts){
      cylinder(h=10.5, d=threadDiameter);
      translate([0,0,10.5]) cylinder(h=diffRadius, d1=threadDiameter,d2=screwDiameter);
      cylinder(h=0.5, d1=threadDiameter+0.5,d2=threadDiameter);
    }
  }
}

/*
 * side wall
 * the inner side is flat, the outher has a radius
 * and at the end is edge for the phone
 */
module sideWall(offset){
  r = 7.5;
  additionalBottom = modular ? wallBase : 0;

  translate([0,-wallDepth-offset,0])

    difference(){

    union(){
      wall();
      translate([-baseWidth/2,-r,baseDepth])
        cube([baseWidth, r,totalHeight/2]);

      mirror([0,1,0])
        translate([-baseWidth/2,0,baseDepth])
        union(){
        difference(){
          union(){
            cube([baseWidth,baseHeight/2-maxDistance-wallDepth,additionalBottom]);
          }

          translate([baseWidth/2,baseHeight/2-maxDistance-wallDepth-cornerRadius,0])
            copyMirror(1,0,0)
            translate([baseWidth/2-cornerRadius,0,0])
            linear_extrude(10)
            difference(){
            square(cornerRadius);
            circle(cornerRadius);
          }
        }


      }

    }
    translate([0,-r,totalHeight])
      scale([1,1,(totalHeight-baseDepth-additionalBottom)/r])
      rotate([0,90,0])
      intersection(){
      cylinder(h=baseWidth, r=r, center=true);
      translate([0,0,-baseWidth/2]) cube(baseWidth);
    }

    linear_extrude(baseDepth)
      square([baseWidth, wallDepth], true);

    if(modular){
      screwNegative();
      copyMirror(1,0,0)
        translate([slotOffset,0,0])
        screwNegative();
    }
  }
}

base();
translate([0, centerOffset, 0]) sideWall(distanceWall_1);
translate([0, centerOffset, 0]) mirror([0,1,0]) sideWall(distanceWall_2);
