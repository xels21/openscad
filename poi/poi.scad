use <../libs/openscad_xels_lib/round.scad>;
use <../libs/openscad_xels_lib/helper.scad>;





tube_outer_d = 25;
tube_thickness = 2;
tube_inner_d = tube_outer_d - (2 * tube_thickness);




charger_x=17.5;
charger_y=1.1;
charger_z=29.5;
charger_z_plus=2;

usb_x = 9.5;
usb_y = 3.2;
usb_z = 8;

switch_x=9;
switch_y=4+1;
switch_z=5;

switch_off=1;

plug_z_off=2;

led_x=10.5;
led_y=3.5;

controller_x = 18.5;
controller_y = 1.1;
controller_z = 25;

controller_z_plus=2;

screw_d=5;

solder_x = 1.5;
solder_y = .7;

// plug_charger();
plug_controller();



module plug_controller(z=10){
  plug_z = controller_z+controller_z_plus;
  difference() {
    // rotate([0,0,90]) 
    plug_base(plug_z);
    translate([-controller_x/2,2.2,0]) 
    // charger();
    controller();

    translate([-tube_inner_d/2,0,12]) 
    rotate([0,90,0])
    cylinder(d=screw_d, h=tube_inner_d, $fn=32);
    // #translate([-switch_x/2,-6,0]) 
    // switch(plug_z);

    translate([tube_outer_d/2+screw_d-.3,0,0]) 
    cylinder(d=screw_d*2,h=controller_z,$fn=64);

    translate([-(tube_outer_d/2+screw_d-.3),0,0]) 
    cylinder(d=screw_d*2,h=controller_z,$fn=64);

    // linear_extrude(height = 100) 
    translate([3.7,-11,0]) 
    scale([12,12,.2])
    linear_extrude(height = 1) 
    mirror([1,0,0])
#    twenty_one();

  }
}

module controller(){
    off = 0.8;

    cube([controller_x, controller_y, controller_z]);
    translate([(controller_x-usb_x)/2,0,0]) 
    rounded_cube_z([usb_x,usb_y+controller_y,usb_z], r=(usb_y+controller_y)/3);
    
    translate([off,0,0]) 
    cube([controller_x-2*off, 3.2, controller_z]);

    translate([1.5,-solder_y,0]) 
    cube([solder_x, solder_y, controller_z]);
    
    translate([controller_x-1.5-solder_x,-solder_y,0]) 
    cube([solder_x, solder_y, controller_z]);

    hole_x=12;
    translate([(controller_x-hole_x)/2,0,controller_z-1]) 
    cube([hole_x, controller_z_plus*2, controller_z_plus*2]);
}

module plug_charger(){
  plug_z = charger_z+charger_z_plus;
  difference() {
    plug_base(plug_z);
    #translate([-charger_x/2,2,0]) 
    charger();
    #translate([-switch_x/2,-6,0]) 
    switch(plug_z);
  }
}

module switch(z=10){
  cube([switch_x, switch_y, switch_z]);
  translate([switch_off,switch_off,0]) 
  cube([switch_x-2*switch_off, switch_y-2*switch_off, z]);

}

module charger(){
  union(){

    cube([charger_x, charger_y, charger_z]);
    translate([2,0,0]) 
    cube([charger_x-2.5, 3, charger_z]);
    translate([(charger_x-usb_x)/2,0,0]) 
    rounded_cube_z([usb_x,usb_y+charger_y,usb_z], r=usb_y+charger_y/3);

    translate([2,-solder_y,0]) 
    cube([solder_x, solder_y, charger_z]);
    translate([5,-solder_y,0]) 
    cube([solder_x, solder_y, charger_z]);
    translate([charger_x-5-solder_x,-solder_y,0]) 
    cube([solder_x, solder_y, charger_z]);
    translate([charger_x-2-solder_x,-solder_y,0]) 
    cube([solder_x, solder_y, charger_z]);

    // gap_x=4;
    // gap_z=4;
    hole_x=12;
    translate([(charger_x-hole_x)/2,-charger_z_plus*2+charger_y,charger_z-1]) 
    cube([hole_x, charger_z_plus*2, charger_z_plus*2]);
  }
}

module plug_base(z=10){
  rotate_extrude($fn=128){
    translate([tube_outer_d/2,plug_z_off/2,0])
    circle(d=plug_z_off, $fn=32);
  }
  cylinder(h=plug_z_off,d=tube_outer_d, $fn=128);



  difference(){
    cylinder(h=z,d1=tube_inner_d, d2=tube_inner_d-.3, $fn=128);
    // rotate([0,0,90]) 
    {
    translate([-led_x/2,tube_inner_d/2-led_y,plug_z_off]) 
    cube(size = [led_x,led_y,z-plug_z_off]);

    translate([-led_x/2,-tube_inner_d/2,plug_z_off]) 
    cube(size = [led_x,led_y,z-plug_z_off]);
    }
  }
}
