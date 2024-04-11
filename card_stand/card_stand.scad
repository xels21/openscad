use <../libs/openscad_xels_lib/round.scad>;

/*
 ________________
/ |            | \
| |____________| |
|________________|

*/

res=8;
// res=16;
// res=32;
// res=64;

// card_holder(card_w=94, card_d=22, card_h=12, t=4, r=4, botthom_t=4);
card_holder(card_w=70.5, card_d=22, card_h=14, t=10, r=12, botthom_t=2);

module card_holder(card_w=94, card_d=22, card_h=12, t=4, r=4, botthom_t=4)
{
  difference(){
    translate([0,0,-r])
    difference(){
      rounded_cube([card_w+2*t,card_d+2*t,botthom_t+card_h+r], r, fn=res);
      cube([card_w+2*t,card_d+2*t,r]);
    }

    translate([t,t,botthom_t])
    cube([card_w,card_d,card_h]);
  }
}