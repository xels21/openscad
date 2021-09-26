/*

 ______________________
|___   |      |    ___|
 __|   |      |   |___
|______|______|______|


*/

use <../libs/openscad_xels_lib/round.scad>;

offset=5;

x=14;
y=11;
h=3;

x_max = x+offset;
y_max = y+offset;


thickness=1.5;

inner_d=8;

h_max=thickness+h+thickness;
r=7;

rotate([0,-90,0])
cutoff();

module cutoff(){
  difference(){
    raw();
    cube([offset/2,y_max,h_max]);
  }
}

module raw(){
  difference(){
    plug();
    translate([x_max/2,y_max/2,0])
    cylinder(d=inner_d,h=h_max, $fn=32);
  }
}

module plug(){
  rounded_cube_z([x_max,y_max,thickness], r=r);
  translate([offset/2,offset/2,thickness])
  rounded_cube_z([x,y,h], r=r-2);
  translate([0,0,thickness+h])
  rounded_cube_z([x_max,y_max,thickness], r=r);
}




