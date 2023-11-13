use <../libs/openscad_xels_lib/round.scad>;

/*
__________________________________
| |                            | |
| |                            | |
| |                            | |
| |                            | |
| |                            | |
| |                            |_|
| |____________________________| |
|________________________________|


 _______________
|              |
|              |
|              |
|              |
|              |
|              |
|              |
|______________|
  |_|   |___|  



*/

thickness = 1;

battery_x = 26;
battery_y = 17;
battery_z_wo_pin = 45;

hole_x = 29;
hole_y=21.3;
hole_z_wo_top=battery_z_wo_pin + thickness;

pin_off_x=4;
pin_off_y=6;

top_plus=1;
top_z=2;

top_cut_y=6;

all();
// hole_wo_top();
module all(){

  translate([-top_plus,-top_plus,hole_z_wo_top])
  difference(){
    top();
    #translate([0,hole_y+top_plus,0])
    cube([hole_x+2*top_plus,top_plus, top_z]);
  }
  difference(){
    hole_wo_top();
    translate([(hole_x-battery_x)/2,(hole_y-battery_y)/2,thickness])
    battery_wo_pin();
    translate([(hole_x-battery_x)/2,0,thickness])
    battery_wo_pin();
    //pins
    #translate([pin_off_x,0,0])
    cube([hole_x-2*pin_off_x,hole_y-pin_off_y,thickness]);
    //minus sign
    #translate([hole_x-8,hole_y-3,0])
    cube([4,0.5,0.3]);
  }
}

module top(){
  translate([0,0,-top_z])
  difference() {
    rounded_cube_xy([hole_x+2*top_plus,hole_y+2*top_plus, 2*top_z], r=top_z*0.999, fn=.1, center=false);
    cube([hole_x+2*top_plus,hole_y+2*top_plus, top_z]);
    translate([(hole_x+2*top_plus)-top_plus,((hole_y+2*top_plus)-top_cut_y)/2,top_z]) 
    cube([top_plus,top_cut_y, top_z]);
  }
}

module hole_wo_top(){
  cube([hole_x, hole_y, hole_z_wo_top]);

}

module battery_wo_pin(){
  cube([battery_x, battery_y, battery_z_wo_pin]);
}

