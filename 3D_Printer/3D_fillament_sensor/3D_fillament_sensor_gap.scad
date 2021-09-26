/*

 __  __
|-| |-|
|-|_|-|
|     |
|     |
|     |
|     |
|  ___|
|-| 
|-|
|_|

*/

screw_d=2.7;
under_screw=9;
under_screw_gap=5;
printer_x=8;
holder_x=5;
holder_y=8;
distance=30;
z=14;

res=64;

max_y=under_screw_gap+under_screw+distance;
max_x=holder_x+printer_x;

difference(){
  translate([z/2,0,0])
  rotate([0,-90,0])
  linear_extrude(z)
  polygon(points=[
    [0,0],
    [0,max_y],
    [max_x/2-(holder_x/2),max_y],
    [max_x/2-(holder_x/2),max_y-holder_y],
    [max_x/2+(holder_x/2),max_y-holder_y],
    [max_x/2+(holder_x/2),max_y],
    [max_x,max_y],
    [max_x,under_screw_gap+under_screw],
    [max_x-printer_x,under_screw_gap+under_screw],
    [max_x-printer_x,0],
  ]);
  translate([0,under_screw_gap,0])
  cylinder(d=screw_d, h=z, $fn=res);

  translate([0,max_y-holder_y/2,0])
  cylinder(d=screw_d, h=z, $fn=res);
  }