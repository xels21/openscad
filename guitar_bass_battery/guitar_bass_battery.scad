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

hole_x_raw = 29;
hole_y_raw = 21.3;
hole_x = hole_x_raw - 0.65;
hole_y = hole_y_raw - 0.1;
hole_z_wo_top=battery_z_wo_pin + thickness;

pin_off_x=4;
pin_off_y=6.5;
pin_rad=4;

top_plus=1.7;
top_z=2.5;

top_cut_y=9;

back_cut_off=8;

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
    #translate([back_cut_off,0,back_cut_off])
    rounded_cube_x([hole_x-2*back_cut_off, hole_y, hole_z_wo_top-2*back_cut_off], r=5);
    //bat cut
    translate([(hole_x-battery_x)/2,(hole_y-battery_y)/2,thickness])
    battery_wo_pin();
    //front cut
    translate([(hole_x-battery_x)/2,0,thickness])
    battery_wo_pin();
    //pins
    #translate([pin_off_x,-pin_rad,0])
    rounded_cube_z([hole_x-2*pin_off_x,hole_y-pin_off_y+pin_rad,thickness], r=pin_rad);
    //minus sign
    translate([hole_x-8,hole_y-4,0])
    #rounded_cube_z([4,1,thickness/2], r=0.49);
  }
}

module top(){
  top_gap_rad=top_plus*0.5;

  translate([(hole_x+2*top_plus)-top_plus-2,((hole_y+2*top_plus)-top_cut_y)/2,]) 
  {
    rounded_cube_xyz([top_plus+2+1,top_cut_y, top_z],r=top_gap_rad);
    rounded_cube_z([top_plus+2+1,top_cut_y, top_gap_rad],r=top_gap_rad);
  }

  translate([0,0,-top_z])
  difference() {
    rounded_cube_xy([hole_x+2*top_plus,hole_y+2*top_plus, 2*top_z], r=top_z*0.999, fn=.1, center=false);
    cube([hole_x+2*top_plus,hole_y+2*top_plus, top_z]);
  }
}

module hole_wo_top(){
  support_h=24;
  cube([hole_x, hole_y, hole_z_wo_top]);
  translate([hole_x,(hole_y-top_cut_y)/2,hole_z_wo_top-support_h]) 
  mirror([0,1,0]) 
  rotate([90,0,0])
  linear_extrude(height = top_cut_y) 
  polygon(points = [
    [0,0],
    [0,support_h],
    [top_plus/2,support_h],
  ]);
}

module battery_wo_pin(){
  cube([battery_x, battery_y, battery_z_wo_pin]);
}

