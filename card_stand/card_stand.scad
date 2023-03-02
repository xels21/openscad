use <../libs/openscad_xels_lib/round.scad>;

/*
 ________________
/ |            | \
| |____________| |
|________________|

*/

card_w=94;
card_d=22;
card_h=12;
t=4;

difference(){
  translate([0,0,-t])
  difference(){
    rounded_cube([card_w+2*t,card_d+2*t,card_h+2*t], t, fn=20);
    cube([card_w+2*t,card_d+2*t,t]);
  }

  translate([t,t,t])
  cube([card_w,card_d,card_h]);
}