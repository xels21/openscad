use <../libs/openscad_xels_lib/round.scad>;
use <../libs/openscad_xels_lib/helper.scad>;
use <../libs/openscad_xels_lib/geometry.scad>;

tube_outer_d = 25;
tube_thickness = 2;
tube_inner_d = tube_outer_d - (2 * tube_thickness);
// tube_inner_d2 = tube_inner_d-.2;

led_x=12.5;
led_z1=1.2;
led_z2=2.2;
led_inner_x=5.2;

led_y_plus=4;

$fn=64;

linear_extrude(height = 20) 
tube();
// led();
// tube_connector();

module tube_connector(){
  // rotate([90,0,0]) 
  // linear_extrude(height = 40) 
  scale([.99,.99])
  difference(){
    tube_inner();
    translate([tube_inner_d/2,0,0]) 
    rounded_sqare(x=4,y=4,r=.9,center=true);
  }
}

module led(){
  translate([-led_x/2,0,0]){
    square(size = [led_x,led_z1]);
    translate([(led_x-led_inner_x)/2,0,0]) 
    square(size = [led_inner_x,led_z2]);
  }
}

module tube(){
  difference(){
    tube_base();
    translate([0,tube_outer_d/2-3,0])
    led();

    rotate([0,0,180])
    translate([0,tube_outer_d/2-3,0])
    led();

    tube_inner();
  }
}

module tube_inner(){
  intersection() {
    square([tube_inner_d,tube_inner_d-6],center=true);
    circle(d=tube_inner_d);
  }
}

module tube_base(){
  led_off=1-.1;
  led_x1=led_x+6;
  led_x2=led_x+2;

  translate([0,tube_outer_d/2-(led_y_plus/2)-led_off,0]) 
  trapezoid(x1=led_x1,x2=led_x2,h=led_y_plus,r=1, center=1);

  rotate([0,0,180])
  translate([0,tube_outer_d/2-(led_y_plus/2)-led_off,0])
  trapezoid(x1=led_x1,x2=led_x2,h=led_y_plus,r=1, center=1);

  intersection() {
    circle(d=tube_outer_d);
    square(size = [tube_outer_d*2,tube_outer_d-2],center=true);
  }
}