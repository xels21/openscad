use <../libs/openscad_xels_lib/screw.scad>;

/*

_______________________________
|  ||   _______________   ||  |
|  ||  |               |  ||  |
|  ||  |               |  ||  |
|_/ \_ |_______________| _/ \_|
     |__________________|

*/

usb_x1=21;
usb_x2=19.5;
usb_x3=20.5;

usb_x_max = max(usb_x1,usb_x2);

usb_y1=2;
usb_y2=24;

usb_z1=15;
usb_z2=13;
usb_z3=5;

usb_z_max = max(usb_z1,usb_z2);


t=2;

screw_d=4;
screw_h=8;
screw_off=4;

screw_x=(screw_off+screw_d+screw_off);

x_max = 2*screw_x+2*t+usb_x_max;
z_max= usb_z_max+t;
y_max = usb_y1 + usb_y2;

r=4;

res=256;

difference(){
  case();
  translate([screw_x*1/2,y_max/2,z_max-screw_h-r/6])
  rotate([180,0,0])
  #screw(upper_d=screw_d*2.2,lower_d=screw_d,upper_h=4,max_h=screw_h+r/6, fn=32);

  translate([x_max-screw_x*1/2,y_max/2,z_max-screw_h-r/6])
  rotate([180,0,0])
  #screw(upper_d=screw_d*2.2,lower_d=screw_d,upper_h=4,max_h=screw_h+r/6, fn=32);

  // translate([screw_x+t,0,t]) 

  translate([screw_x+t,0,t]) 
  union(){
    #cube([usb_x1,usb_y1,usb_z1], fn=res);
    translate([(usb_x1-usb_x2)/2,usb_y1,(usb_z1-usb_z2)/2]) 
    #cube([usb_x2,usb_y2,usb_z2], fn=res);
    translate([(usb_x1-usb_x3)/2,0,(usb_z_max-usb_z3)/2]) 
    #cube([usb_x3,usb_y1+usb_y2,usb_z3], fn=res);
  }
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