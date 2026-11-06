use <../libs/openscad_xels_lib/round.scad>;
use <../libs/openscad_xels_lib/spiral.scad>;
use <../digital_box_12000_vape/digital_box_12000_vape.scad>;


ball_d=66;
ball_r=ball_d/2;

shell_t=3;

ball_inner_d=ball_d-2*shell_t;

res = 64;

diff_fac=1.04;

batt_t=1;
battery_x_raw=43.7+(2*batt_t);
battery_y_raw=23.8+(2*batt_t);

battery_x = battery_x_raw*diff_fac;
battery_y = battery_y_raw*diff_fac;

battery_r=11;

battery_h=32;

cut_off=15;

led_w=7;

esp_t=1*diff_fac;
esp_x=18*diff_fac;
esp_h=3.3*diff_fac;

esp_x_sum = esp_x+2*esp_t;
esp_h_sum = esp_h+2*esp_t;

poi_juggling_ball();
module led_hook(){
  led_hook_fac=1.8;
  x_scale=2;
  translate([0,ball_r*.6,ball_r-cut_off])
  rotate([-90,0,0])
  linear_extrude(height=led_w, center=true)
  scale([x_scale,1])
  difference(){
    circle(d=led_w*led_hook_fac, $fn=res);
    circle(d=led_w*led_hook_fac/2, $fn=res);
    translate([-led_w*led_hook_fac/2,-led_w*led_hook_fac/2])
    square([led_w*led_hook_fac,led_w*led_hook_fac/2]);
  }
}

module poi_juggling_ball(){

  difference(){
    sphere (d=ball_d, $fn=res);

    spiral(r=ball_r-led_w*.3, rr=led_w/2, iterations = 400, turns = 5, $fn=8);

    cylinder(d=1.5*led_w, h=ball_d, $fn=32, center=true);

    translate([-ball_r,-ball_r,ball_r-cut_off])
    cube([ball_d,ball_d,ball_d]);

    translate([-battery_x/2,-battery_y/2,ball_r-battery_h-cut_off])
    union(){
      rounded_cube_z([battery_x,battery_y,ball_d+battery_h], r=battery_r, center=false);
      translate([(battery_x-esp_x_sum)/2,-esp_h-esp_t,])
      rounded_cube_z([esp_x_sum,esp_h_sum,ball_d+battery_h], r=1);
    }

    translate([0,0,ball_r-cut_off+4-battery_h])
    union(){
      // rotate([90,0,0])
      // #cylinder(d=8, h=ball_d, $fn=32, center=true);
      rotate([90,0,90])
      #cylinder(d=8, h=ball_d, $fn=32, center=true);
    }

    bottom_sphere_dif=15;

    translate([0,0,-ball_r-bottom_sphere_dif/2])
    sphere(r=bottom_sphere_dif, $fn=32);

    #led_hook();

    // hull()
    // digital_box(z_plus=21, w_esp=true, center=true);
  }
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