use <../libs/openscad_xels_lib/round.scad>;

/*

   ______       _______
 /      |      |       \
|       |      |       |
|       |      |       |
|       |      |       |
\       |______|       |
 ´-,________________,-´

*/

inner_d=18;
outer_d=33;
h=22;
thickness=4;

r1=5;
r2=10;

helper = 10;
helper_2 = 5;

juggling_club();
module juggling_club() {
  rotate_extrude($fn=64) {
    juggling_club_2d();
  }
}


module juggling_club_2d() {
  intersection() {
    square([outer_d,h]);
    difference() {
      union(){
        square([5,h]);
        translate([0,helper_2]) 
        rounded_sqare(x=outer_d/2, y=h-helper_2, r=r1, fn=10, center=false);

        translate([-helper,0]) 
        rounded_sqare(x=outer_d/2+helper, y=h, r=r2, fn=10, center=false);
      }
      translate([0,thickness]) 
      square([inner_d/2,h-thickness]);
      square([1.5,thickness]);
    }
  }
}