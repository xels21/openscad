use <../libs/openscad_xels_lib/round.scad>;
use <../libs/openscad_xels_lib/helper.scad>;




tol=.1;
tube_outer_d = 25;
tube_thickness = 2.0;
tube_inner_d_raw = tube_outer_d - (2 * tube_thickness);
tube_inner_d = tube_inner_d_raw-tol*2;
tube_inner_d2 = tube_inner_d-.2;

tube_cutoff_raw = 6;
tube_cutoff = tube_cutoff_raw-tol;


charger_x=18;
charger_y=1.3;
charger_z=29.5;
charger_z_plus=2;

usb_x = 9.5;
usb_y = 3.2;
usb_z = 8;

switch_x=9;
switch_y=4;
switch_z=5;

switch_off=1;

plug_z_off=2;

// led_x=10.5; //3 pin
led_x=12.25; //4 pin
led_y=4;

controller_x = 18.8;
controller_y = 1.2;
controller_z = 25.2;

controller_z_plus=2;

screw_d=5;
screw_z=10;

solder_x = 2.5;
solder_y = 1;

solder_x_off=.5;


plug_charger(w_led=false);
// plug_controller();



module plug_controller(z=10, w_led=false, inside_led=true){
  plug_z = controller_z+controller_z_plus;
  difference() {
    // rotate([0,0,90]) 
    plug_base(plug_z, w_pin=1, w_led=w_led, inside_led=inside_led);
    translate([0,4.3,0]) 
    // charger();
    // rotate([0,0,180])
    translate([-controller_x/2,-(usb_y+controller_y)/2,0])
    #controller();

    translate([-tube_inner_d/2,0,screw_z+plug_z_off]) 
    #rotate([0,90,0])
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

    translate([solder_x_off,-solder_y,0]) 
    cube([solder_x, solder_y, controller_z]);
    
    translate([controller_x-solder_x_off-solder_x,-solder_y,0]) 
    cube([solder_x, solder_y, controller_z]);

    hole_x=12;
    translate([(controller_x-hole_x)/2,0,controller_z-1]) 
    cube([hole_x, controller_z_plus*2, controller_z_plus*2]);
}

module plug_charger(w_led=false, inside_led=true){
  plug_z = charger_z+charger_z_plus;
  difference() {
    plug_base(plug_z, w_led=w_led, inside_led=true);
    #translate([-charger_x/2,1.7,0]) 
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
    rounded_cube_z([usb_x,usb_y+charger_y,usb_z], r=(usb_y+charger_y)/3);
    // !rounded_cube_z([usb_x,usb_y+charger_y,usb_z], r=usb_y+charger_y/3);

    translate([1,-solder_y,0]) 
    cube([solder_x, solder_y, charger_z]);
    translate([5,-solder_y,0]) 
    cube([solder_x, solder_y, charger_z]);
    translate([charger_x-5-solder_x,-solder_y,0]) 
    cube([solder_x, solder_y, charger_z]);
    translate([charger_x-1-solder_x,-solder_y,0]) 
    cube([solder_x, solder_y, charger_z]);

    // gap_x=4;
    // gap_z=4;
    hole_x=12;
    translate([(charger_x-hole_x)/2,-charger_z_plus*2+charger_y,charger_z-1]) 
    cube([hole_x, charger_z_plus*2, charger_z_plus*2]);
  }
}

module plug_base(z=10, w_pin=0, w_led=true, inside_led=true){
  rotate_extrude($fn=128){
    translate([tube_outer_d/2,plug_z_off/2,0])
    circle(d=plug_z_off, $fn=32);
  }
  cylinder(h=plug_z_off,d=tube_outer_d, $fn=128);



  difference(){
    intersection() {
      cylinder(h=z,d1=tube_inner_d, d2=tube_inner_d2, $fn=128);
      cylinder(h=z*1.9,d1=tube_inner_d*2, d2=0, $fn=128);
      if(inside_led){
        linear_extrude(height = z)
        difference(){
          square([tube_inner_d,tube_inner_d-tube_cutoff],center=true);
          translate([0,(tube_inner_d-tube_cutoff)/2,0]) 
          square([led_x,3],center=true);
          
          translate([0,-(tube_inner_d-tube_cutoff)/2,0]) 
          square([led_x,3],center=true);
        }
      }
    }
    // rotate([0,0,90]) 
    {
    translate([-led_x/2,tube_inner_d/2-led_y,plug_z_off]) 
    union(){
      if(w_pin){
        // translate([0,-2,0]) 
        // cube(size = [led_x,led_y+2,4]);

        translate([1,-1,0]) 
        cube(size = [led_x-2,led_y+1,z-plug_z_off]);
      }
      if(w_led){
        led(led_x=led_x, led_y=led_y, plug_z_off=plug_z_off, z=z);
      }
      // cube(size = [led_x,led_y,z-plug_z_off]);
    }

    translate([-led_x/2,-tube_inner_d/2,plug_z_off]) 
    union(){
      if(w_pin){
          // translate([0,2,0]) 
          // cube(size = [led_x,led_y+2,4]);

          translate([1,0,0]) 
          cube(size = [led_x-2,led_y+1,z-plug_z_off]);
      }
      if(w_led){
        led(led_x=led_x, led_y=led_y, plug_z_off=plug_z_off, z=z);
      }
      }
    }
  }
}

module led(led_x, led_y, plug_z_off, z){
        cube(size = [led_x,led_y,z-plug_z_off]);

        translate([led_x/2,0,z-led_x*.5]) 
        rotate([-90,-30,0])
        linear_extrude(height = led_y) 
        circle(r = led_x*.8, $fn=3);
}
