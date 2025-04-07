use <../libs/openscad_xels_lib/round.scad>;
use <../libs/openscad_xels_lib/helper.scad>;
use <../libs/Round-Anything/MinkowskiRound.scad>;


// IDEA: split every module with positive and negative and translate it
// REASON: better unoin/difference/intersection later on

// ORDER: (left -> rioght)
// 1. charger
// 2. battery (heavy endpoint)
// 3. switch
// 4. converter
// 5. (cabling)
// 6. uC

thickness=2;
length = 290;
// inner_d= 18;
inner_d= 19;
outer_d= inner_d+thickness*2;

battery_d=15;
battery_x=51;

usb_c_x=8;
usb_c_y=9.5;
usb_c_z=3;

charger_y=17;
charger_x=28; //w/o usbc
charger_pins_x=23; //w/o usbc
charger_usb_off_z=1.5;
charger_z=usb_c_z+charger_usb_off_z;
charger_off_z=outer_d/2-(1/1*charger_z);

uC_x=23.2; //w/usb
uC_y=12; //w/pins
uC_z=charger_z;
uC_usb_off_z = charger_usb_off_z;
uC_off_z = charger_off_z;

// uC_x=22;
// uC_y=18;

// top_cut=outer_d/2+(2/3*charger_z);
// top_cut=outer_d/2+charger_z/2;
top_cut=charger_off_z+charger_z;
res=64;

screw_d=3;
screw_d_plus=6;
screw_d_all=2*screw_d_plus+screw_d;
screw_d2=6;
screw_h=2;


string_hole_d = 7;
string_hole_thickness = 3;
// string_hole_outer_d = string_hole_innder_d + 2*string_hole_thickness;
string_hole_x = string_hole_d + 2*screw_d_all;
string_hole_x_off = length-uC_x-string_hole_x-2;
string_hole_y_cut = 3; //cable




screw_1_off_x=charger_x+thickness;
// screw_2_off_x=length/3;
screw_2_off_x=screw_1_off_x+1.5*screw_d_all+battery_x;
// screw_3_off_x=length*2/3;
screw_3_off_x=180;


uC_reset_off_x=13;
uC_reset_x=3;
uC_reset_y=5;




switch_small_x=5.2;
switch_small_y=3.2;

switch_x=20;
switch_y=6;
switch_z=4;
switch_screw_out_off_x=2.5;
switch_screw_d=1.5;

switch_x_off=120;
// switch_x_off=length/2-switch_x/2;

led_x=5;
led_inner_x=3;
led_z_1=1;
led_z_2=2.5;
  led_z_plus=2;
  led_z_x_plus=5;


// screw();
all();
// charger();
// switch();
// uC_neg();
// string_hole();
// tube();
// charger();
// uC();
// cloak();
// led();

module led_2d(){
  difference() {
    led_pos();
    #led_neg_2d();
  }
}

module led(is_pos=true){
  linear_extrude(height = height) 
  if(is_pos){
    led_pos_2d();
  }else{
    led_neg_2d();
  }
}

module led_pos_2d(){
/*
     _____    _____
   /  ___|   |___  \
 /   |__________|   \
|                    |


|  _____
| |___  \
|____|   \
|         |
|
*/
  copy_mirror([1,0,0]) 
  polygon(points=[
    [0,-led_z_plus],
    [0,+led_z_2],
    [led_x/2+1,+led_z_2],
    [led_x/2+3,0],
    [led_x/2+3,-led_z_plus]
    ]);
}

module led_neg_2d(){
  copy_mirror([1,0,0]) 
  polygon(points=[
    // [0,-led_z_plus],
    [0,0],
    [led_x/2,0],
    [led_x/2,led_z_1],
    [led_inner_x/2,+led_z_1],
    [led_inner_x/2,outer_d],
    [0,outer_d],
    // [led_x/2+1,+led_z_2],
    // [led_x/2+3,0],
    // [led_x/2+3,-led_z_plus]
    ]);

}


module switch(){
  difference() {
    switch_pos();
    switch_neg();
  }
}
module switch_pos(){
  translate([switch_x_off,(outer_d-switch_y)/2,0]) 
  cube([switch_x, switch_y, switch_z]);
}
module switch_neg(){
  #translate([switch_x_off+(switch_x-switch_small_x)/2,(outer_d-switch_small_y)/2,0]) 
  cube([switch_small_x, switch_small_y, switch_z]);

  #translate([switch_x_off+switch_screw_out_off_x,(outer_d)/2,0]) 
  cylinder(h=switch_z,d=switch_screw_d, $fn=res);

  #translate([switch_x_off + switch_x - switch_screw_out_off_x,(outer_d)/2,0]) 
  cylinder(h=switch_z,d=switch_screw_d, $fn=res);
}

module uC(){
  difference() {
    uC_pos();
    uC_neg();
  }
}

module uC_pos(){
  translate([length-thickness-uC_x,(outer_d-uC_y)/2,0]) 
  cube([uC_x, uC_y, outer_d]);
}
module uC_neg(){
  intersection() {
    tube_raw_neg();
    translate([length-thickness-uC_x,0,uC_off_z]) 
    cube([uC_x, outer_d, uC_z]);
  }

  // USB C
  translate([length-usb_c_x,(outer_d-usb_c_y)/2,uC_usb_off_z+uC_off_z]) 
  rounded_cube_y([usb_c_x,usb_c_y,usb_c_z], r=(usb_c_z)/3);

  // reset
  translate([length-thickness-uC_x+uC_reset_off_x,(outer_d-uC_reset_y)/2,uC_off_z]) 
  rounded_cube_z([uC_reset_x,uC_reset_y,outer_d], r=(uC_reset_x)/3);
}

module screw(){
  difference() {
    screw_pos();
    screw_neg();
  }
}

module screw_pos(){
  // cylinder(h = outer_d, d = screw_d_all, $fn=res);
  translate([-(screw_d_all/2), -( inner_d-2*string_hole_y_cut)/2,0]) 
  cube([screw_d_all,  inner_d-2*string_hole_y_cut, outer_d]);
}

module screw_neg(both_sides=true){
  if(both_sides){
    cylinder(h = screw_h, d1 = screw_d2, d2=screw_d, $fn=res);
  }
  translate([0,0,outer_d-screw_h]) 
  cylinder(h = screw_h, d2 = screw_d2, d1=screw_d, $fn=res);
  translate([0,0,screw_h]) 
  cylinder(h = outer_d-screw_h, d = screw_d, $fn=res);
}

module all(is_top=false){

  difference(){
    intersection() {
      //positive part
      cloak(is_top=is_top);
      // tube_raw()
      

      union() {
        string_hole_pos();
        // cloak();

        tube_raw();
        // tube();
        charger_pos();
        uC_pos();

        screw_1(is_pos=true);
        screw_2(is_pos=true);
        screw_3(is_pos=true);

        switch_pos();
      }
    }
    union() {
      string_hole_neg();
      screw_1(is_pos=false);
      screw_2(is_pos=false);
      screw_3(is_pos=false);
      switch_neg();

      // tube_raw();
      // tube();
      #charger_neg();
      uC_neg();
    }

  }
}

module screw_1(is_pos=true, both_sides=false){
  translate([(screw_d_all/2)+screw_1_off_x,outer_d/2,0]) 
  if(is_pos){
    screw_pos(both_sides=both_sides);
  }else{
    screw_neg(both_sides=both_sides);
  }
}
module screw_2(is_pos=true, both_sides=false){
  translate([screw_2_off_x,outer_d/2,0]) 
  if(is_pos){
    screw_pos(both_sides=both_sides);
  }else{
    screw_neg(both_sides=both_sides);
  }
}
module screw_3(is_pos=true, both_sides=false){
  translate([screw_3_off_x,outer_d/2,0]) 
  if(is_pos){
    screw_pos(both_sides=both_sides);
  }else{
    screw_neg(both_sides=both_sides);
  }
}

module cloak(is_top=false){
  intersection(){
    translate([0,-led_z_2,0]) 
    if(is_top){
      translate([0,0,top_cut]) 
      cube([length,outer_d+2*led_z_2,outer_d-top_cut]);
    }else{
      cube([length,outer_d+2*led_z_2,top_cut]);
    }
    tube_raw_pos(); //TODO: change
  }
}

module charger(){
  difference() {
    charger_pos();
    #charger_neg();
  }
}

module charger_pos(){
  cube([charger_pins_x, outer_d, outer_d]);
}
module charger_neg(){
  intersection() {
    tube_raw_neg();
    translate([thickness,0,charger_off_z]) 
    cube([charger_pins_x, outer_d, charger_z]);
  }

  // USB C
  translate([0,(outer_d-usb_c_y)/2,charger_off_z+charger_usb_off_z]) 
  rounded_cube_y([usb_c_x,usb_c_y,usb_c_z], r=(usb_c_z)/3);
}


module string_hole(){
  difference() {
    string_hole_pos();
    #string_hole_neg();
  }
}

module string_hole_pos(){
  translate([string_hole_x_off,thickness+string_hole_y_cut,0]) 
  cube([string_hole_x, inner_d-2*string_hole_y_cut, outer_d]);
}
module string_hole_neg(){
  // translate([string_hole_x_off,thickness+string_hole_y_cut,0]) 
  translate([string_hole_x_off+string_hole_x/2,outer_d/2,0]) 
  union(){
    cylinder(h = outer_d, d = string_hole_d, $fn=res);

    translate([-string_hole_x/3,0,0]) 
    screw_neg(both_sides=false);

    translate([string_hole_x/3,0,0]) 
    screw_neg(both_sides=false);
  }
}




module tube_raw(){
  difference() {
    tube_raw_pos();
    tube_raw_neg();
  }
}
module tube_raw_pos(){
  translate([0,outer_d/2,outer_d/2])
  rotate([90,180,90])
  // cylinder(d=outer_d, h=length, $fn=res);

  linear_extrude(height = length)
  round2d(OR=1,IR=1)
  union(){
    circle(d=outer_d, $fn=res);

    translate([-outer_d/2,0,0]) 
    rotate([0,0,90])
    led_pos_2d();

    translate([outer_d/2,0,0]) 
    rotate([0,0,-90])
    led_pos_2d();
  }
}
module tube_raw_neg(){
  translate([thickness,outer_d/2,outer_d/2])
  rotate([90,180,90])
  
  union(){
    linear_extrude(height = length-2*thickness) 
    circle(d=inner_d, $fn=res);
  
    linear_extrude(height = length-thickness) 
    translate([-outer_d/2,0,0]) 
    rotate([0,0,90])
    led_neg_2d();

    linear_extrude(height = length-thickness) 
    translate([outer_d/2,0,0]) 
    rotate([0,0,-90])
    led_neg_2d();

    tube_led_helper=3;
    tube_led_x=10;

    translate([-outer_d/2,-(led_x-1)/2,length-tube_led_x]) 
    cube([tube_led_helper,led_x-1,tube_led_x]);
    translate([outer_d/2-tube_led_helper,-(led_x-1)/2,length-tube_led_x]) 
    cube([tube_led_helper,led_x-1,tube_led_x]);
  }
}