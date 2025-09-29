use <../libs/Round-Anything/MinkowskiRound.scad>;



off_x=40;
off_y=30;

logo_scale=1.5;

logo_x=65*logo_scale;
logo_y=28*logo_scale;

echo("###################################");
echo("logo_x: ", logo_x);
echo("logo_y: ", logo_y);
echo("###################################");


max_x=off_x*2+logo_x;
max_y=off_y*2+logo_y;

handle_x=0;
handle_y=0;

rad =10;

linear_extrude(.5)
difference(){
  round2d(rad,rad)
  union(){
    square([max_x, max_y]);
    translate([-handle_x,max_y/2-handle_y])
    square([max_x+2*handle_x,2*handle_y]);
  }
  
  translate([off_x,off_y,0])
  scale(v = logo_scale)
  translate([0,-6,0])
  #import("apple_handmade_v2_mask.svg", dpi=400, convexity=1);
}