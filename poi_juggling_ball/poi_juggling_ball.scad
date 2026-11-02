use <../libs/openscad_xels_lib/round.scad>;
use <../libs/openscad_xels_lib/spiral.scad>;


ball_d=65;
ball_r=ball_d/2;

shell_t=3;

ball_inner_d=ball_d-2*shell_t;

res = 64;

batt_t=1;
battery_x_raw=43.7+(2*batt_t);
battery_y_raw=23.8+(2*batt_t);

battery_x = battery_x_raw*1.03;
battery_y = battery_y_raw*1.03;

battery_r=11;

battery_h=50;

cut_off=15;

led_w=5.2;


difference(){
  sphere (d=ball_d, $fn=res);
  
  #spiral(r=ball_r-led_w*.2, rr=led_w/2, iterations = 400, turns = 5, $fn=8);

  cylinder(d=1.5*led_w, h=ball_d, $fn=32, center=true);

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