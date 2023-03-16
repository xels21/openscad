use <../libs/openscad_xels_lib/screw.scad>;
use <../libs/openscad_xels_lib/round.scad>;

/*

______________________________
|  ||  |              |  ||  |
|_/ \_ \_____________/  _/ \_|
     |_________________|

*/

usb_x1=17;
usb_x2=12;
usb_y1=25;
usb_y2=10;

usb_z1=9;
usb_z2=8;

t=3;

screw_d=4;
screw_h=8;
screw_off=4;

screw_x=(screw_off+screw_d+screw_off);

x_max = 2*screw_x+2*t+usb_x1;
z_max= usb_z1+t;
y_max = usb_y1 + usb_y2;

r=3;

res=256;

difference(){
  case();
  translate([screw_x*1/2,y_max/2,z_max-screw_h-r/8])
  rotate([180,0,0])
  #screw(upper_d=screw_d*2,lower_d=screw_d,upper_h=3,max_h=screw_h+r/8, fn=32);

  translate([x_max-screw_x*1/2,y_max/2,z_max-screw_h-r/8])
  rotate([180,0,0])
  #screw(upper_d=screw_d*2,lower_d=screw_d,upper_h=3,max_h=screw_h+r/8, fn=32);

  translate([screw_x+t,0,t]) 
  #rounded_cube_x([usb_x1,usb_y1,usb_z1*2],r=usb_z1*0.5, fn=res);

  translate([screw_x+t+(usb_x1-usb_x2)/2,usb_y1,t+(usb_z1-usb_z2)]) 
  #rounded_cube_x([usb_x2,usb_y2,usb_z2*2],r=usb_z1*0.5, fn=res);
}


module case(){
  translate([0,y_max,0])
  rotate([90,0,0])
  linear_extrude(height = y_max) 
  offset(-r)
  offset(r)
  polygon(points = [
    [0,z_max-screw_h],
    [0,z_max],
    [x_max ,z_max],
    [x_max ,z_max-screw_h],
    [x_max-screw_x ,z_max-screw_h],
    [x_max-screw_x ,0],
    [screw_x ,0],
    [screw_x ,z_max-screw_h],
  ]);
}