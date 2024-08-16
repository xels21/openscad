use <../libs/openscad_xels_lib/round.scad>;






tube_outer_d = 25;
tube_thickness = 2;
tube_inner_d = tube_outer_d - (2 * tube_thickness);




charger_x=18;
charger_y=1.3;
charger_z=29;
charger_z_plus=2;

charger_usb_x = 9.5;
charger_usb_y = 3.5 +charger_y;
charger_usb_z = 8;

  switch_x=9;
  switch_y=4;
  switch_z=5;

  switch_off=1;

plug_z_off=2;

led_x=10;
led_y=3;

plug_charger();

module plug_charger(z=10){
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
    solder_x = 2;
    solder_y = 1;
    cube([charger_x, charger_y, charger_z]);
    translate([2,0,0]) 
    cube([charger_x-2.5, 3, charger_z]);
    translate([(charger_x-charger_usb_x)/2,0,0]) 
    rounded_cube_z([charger_usb_x,charger_usb_y,charger_usb_z], r=charger_usb_y/3);

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
    cylinder(h=z,d1=tube_inner_d, d2=tube_inner_d-.6, $fn=128);
    // rotate([0,0,90]) 
    {
    translate([-led_x/2,tube_inner_d/2-led_y,plug_z_off]) 
    cube(size = [led_x,led_y,z-plug_z_off]);

    translate([-led_x/2,-tube_inner_d/2,plug_z_off]) 
    cube(size = [led_x,led_y,z-plug_z_off]);
    }
  }
}
