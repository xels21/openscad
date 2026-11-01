use <../libs/openscad_xels_lib/round.scad>;
use <../libs/openscad_xels_lib/spiral.scad>;


ball_d=63;
ball_r=ball_d/2;

shell_t=3;

ball_inner_d=ball_d-2*shell_t;

res = 32;


battery_x=43.7;
battery_y=23.8;
battery_r=11;

battery_h=50;

cut_off=10;

led_w=4.7;


difference(){
  sphere (d=ball_d, $fn=res);
  
  spiral(r=ball_r-led_w*.2, rr=led_w/2, iterations = 400, turns = 5, $fn=8);

  cylinder(d=led_w, h=ball_d, $fn=32, center=true);

  translate([-ball_r,-ball_r,ball_r-cut_off])
  cube([ball_d,ball_d,ball_d]);

  translate([-battery_x/2,-battery_y/2,ball_r-battery_h])
  #rounded_cube_z([battery_x,battery_y,ball_d+battery_h], r=battery_r, center=false);
}



// difference(){
  // shell();
  // cube([100,100,100]);
// }

module shell(){
  rotate_extrude( $fn=res){
    intersection(){
      translate([0,-ball_d/2])
      square([ball_d,ball_d], center=false);
      difference(){
        circle (d=ball_d, $fn=res);
        circle (d=ball_inner_d, $fn=res);
      }
    }
  }
}