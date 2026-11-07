use <../libs/openscad_xels_lib/round.scad>;




t=1;
inner_t=.5;
// 14500
battery_d=14;
battery_h=50;

esp32_x=18;
esp32_y=23;
esp32_pcb_z=.7;
usbc_x=9;
usbc_z=3;
usbc_plus_y=t; //1;

charger_x=14;
charger_y=18.5;
charger_pcb_z=1.6;

dcdc_x=11;
dcdc_y=22;
dcdc_z=4;

switch_x=10;
switch_y=5.5;
switch_z=5;

max_inner_z=max(battery_d, esp32_x);

left_x=max((esp32_pcb_z+usbc_z), (charger_pcb_z+usbc_z));
right_x=max(switch_y, dcdc_z);

max_x=t+left_x+inner_t+battery_d+inner_t+right_x+t;
max_y=t+battery_h+t;
max_z=t+max_inner_z+t;



// lid_z=8;

log(str("##########max_inner_z: ", max_inner_z));

stabilizer=4;

// preview_esp_battery_box();

case(is_bottom=false,top_plus=2);

module case(is_bottom=false, top_plus=0, bottom_inlay_plus=4){
  mirror([is_bottom ? 1 : 0, 0, 0])
  difference(){
    translate([-battery_d/2-inner_t-left_x-t,-t,-t])
    rounded_cube_z([(max_x),max_y,(max_z+top_plus)*.5], r=t*.8);

    if(!is_bottom){
      // !translate([-battery_d/2-inner_t-left_x-t,-t,t+bottom_inlay_plus])
      translate([-(max_x-2*t)/2,0,bottom_inlay_plus])
      cube([(max_x-2*t),battery_h,(max_z+top_plus)*.5]);
    }

    translate([-battery_d/2-inner_t-left_x,0,stabilizer])
    difference(){
      cube([left_x, battery_h, max_z-stabilizer]);

      translate([0,esp32_y,0])
      cube([left_x,battery_h-(esp32_y+charger_y),max_z]);

    }

    translate([battery_d/2+inner_t,0,0])
    cube([right_x, battery_h-(switch_z-t), max_z]);

    #preview_esp_battery_box();
  }
}

module switch(){
  switch_hole_d=1.8;
  switch_hole_x_off=1.8;
  
  union(){
    cube([switch_x,switch_y,switch_z]);

    translate([-switch_hole_x_off,switch_y/2,0])
    cylinder(d=switch_hole_d,h=switch_z,$fn=16);

    translate([switch_hole_x_off+switch_x,switch_y/2,0])
    cylinder(d=switch_hole_d,h=switch_z,$fn=16);
  }
}

module dcdc(){
  cube([dcdc_x,dcdc_y,dcdc_z]);
}

module esp32(){
  cube([esp32_x,esp32_y,esp32_pcb_z+usbc_z]);

  translate([(esp32_x-usbc_x)/2,-usbc_plus_y,esp32_pcb_z])
  rounded_cube_x([usbc_x,esp32_y+usbc_plus_y,usbc_z],r=usbc_z*.35);
}

module charger(){
  cube([charger_x,charger_y,charger_pcb_z+usbc_z]);

  translate([(charger_x-usbc_x)/2,-usbc_plus_y,charger_pcb_z])
  rounded_cube_x([usbc_x,charger_y+usbc_plus_y,usbc_z],r=usbc_z*.35);
}

module battery(){
  union(){
  cylinder(d=battery_d, h=battery_h, $fn=64);
  translate([-battery_d/2,-battery_d/2,0])
  cube([battery_d,battery_d/2,battery_h]);
  }
}

module preview_esp_battery_box(){
  translate([-battery_d/2-inner_t,0,0])
  rotate([0,-90,0])
  esp32();

  translate([0,0,max_inner_z/2])
  rotate([-90,0,0])
  battery();

  translate([-battery_d/2-inner_t,battery_h,charger_x+(max_inner_z-charger_x)/2])
  rotate([0,90,180])
  charger();

  translate([battery_d/2+inner_t,battery_h*0.15,dcdc_x])
  rotate([0,90,0])
  dcdc();

  translate([battery_d/2+inner_t,battery_h+t,switch_x+(max_inner_z-switch_x)/2])
  rotate([90,90,0])
  switch();
}



