include <../libs/MCAD/2Dshapes.scad>;

/*
|        ____
|      |    `-,
|      |       `,
|      |        \
|      |        |
|  ____|       ,'
| |________,-*
*/

all_h = 24;
all_d = 34;
all_r = all_d / 2;

string_d = 7;
string_r = string_d / 2;
string_h = 8;

knot_d = 16;
knot_r = knot_d / 2;
knot_h = all_h - string_h;

// $fn=16;
$fn=128;

poi_knot();
module poi_knot(){
  rotate_extrude() {
    poi_knot_2d();
  }
}
module poi_knot_2d()
{
    difference() {
      complexRoundSquare(size = [ all_r, all_h ],
        // rads1 = [ 5, 1 ],
        rads2 = [ 7, 7 ],
        rads3 = [ 10, 17 ],
        // rads4 = [ 0, 0 ],
        center = false);

      square(size = [string_r,all_h]);
      translate([0,string_h])
      complexRoundSquare(size = [knot_r,knot_h],
          rads1 = [ 0, 0 ],
          rads2 = [ 2, 2 ],
          rads3 = [ 0, 0 ],
          rads4 = [ 0, 0 ],
          center = false
      );
    }
    %cylinder(h=all_h, d=all_d);
}