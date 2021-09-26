/*
____________________________________/-\
|  __                          _______|
|_| |                 _______/
    |        _______/
    |_______/

*/

include <..\..\libs\openscad_xels_lib\ball_bearings.scad>;

thickness=8;
upper_thickness=12;
pre_printer_y=20;
post_printer_y=35;
w=160;
bear_first_h=0.5;

max_y=max(pre_printer_y,post_printer_y)+upper_thickness;
max_x=thickness+thickness+w;

weight=bear_out_dil+thickness;

difference(){
  union(){
    translate([-max_x,weight/2,-max_y])
    rotate([90,0,0])
    linear_extrude(weight){
      polygon(points=[
        [0,max_y-pre_printer_y-upper_thickness],
        [0,max_y],
        [max_x,max_y],
        [max_x,max_y-thickness-bear_h],
        [thickness + thickness,0],
        [thickness + thickness,post_printer_y],
        [thickness ,post_printer_y],
        [thickness ,max_y-pre_printer_y-upper_thickness],
      ]);
    }
  translate([0,0,-(bear_h+thickness+bear_first_h)])
  cylinder(d=bear_out_dil+thickness,h=bear_h+thickness+bear_first_h, $fn=64);
  }
 
  translate([0,0,-bear_h])
  cylinder(d=bear_out_dil,h=bear_h, $fn=64);

  translate([0,0,-bear_h-bear_first_h])
  cylinder(d=bear_out_dil- 2*bear_out_t_r,h=bear_first_h, $fn=64);
}