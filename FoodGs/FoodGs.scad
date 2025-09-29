use <../libs/Round-Anything/MinkowskiRound.scad>;



off_x=50;
off_y=50;

logo_x=87.5;
logo_y=21.5;

max_x=off_x*2+logo_x;
max_y=off_y*2+logo_y;

// handle_x=20;
// handle_y=10;

rad =10;

linear_extrude(.5)
difference(){
  round2d(rad,rad)
  union(){
    square([max_x,max_y]);
    translate([-handle_x,max_y/2-handle_y]) 
    square([max_x+2*handle_x,2*handle_y]);
  }

  translate([off_x,off_y,0])
  translate([0,32,0])
  import("FoodGs_simple.svg");
}