use <../libs/openscad_xels_lib/round.scad>;
use <../libs/openscad_xels_lib/helper.scad>;
use <../libs/openscad_xels_lib/geometry.scad>;

tube_outer_d = 25; //from poi.scad
tube_thickness = 2; //from poi.scad
tube_inner_d = tube_outer_d - (2 * tube_thickness);
tube_cutoff=6;
// tube_inner_d2 = tube_inner_d-.2;

led_x=12.5;
led_z1=1.2;
led_z2=2.2;
led_inner_x=5.2;

led_y_plus=4;

tube_connector_scale = .992;

l_sum=406;
l=l_sum/2;

screw_d=5; //from poi.scad
screw_z=10; //from poi.scad

hole_d=2;
hole_off=20;

$fn=128;

tube(h=l, w_led_start=true);
// tube(h=l, w_led_start=false);
// led();
// tube_connector();


module tube_connector(height = 70){
  difference(){
    rotate([90,0,0])
    translate([0,0,-height/2])
    intersection() {
      translate([0,0,height]) 
      rotate([180,0,0])
      cylinder(h = height, d1=tube_inner_d-1, d2=tube_outer_d*2);
      cylinder(h = height, d1=tube_inner_d-1, d2=tube_outer_d*2);
      linear_extrude(height = height)
      tube_connector_2d();
    }
    rotate([0,60,0])
    translate([0,hole_off,0]) 
    #cylinder(h=tube_outer_d,d=hole_d, $fn=32, center=true);

    rotate([0,-60,0])
    translate([0,-hole_off,0]) 
    #cylinder(h=tube_outer_d,d=hole_d, $fn=32, center=true);
  }
}

module tube_connector_2d(){
  // rotate([90,0,0]) 
  // linear_extrude(height = 40) 
  scale([tube_connector_scale,tube_connector_scale])
  difference(){
    tube_inner();
    translate([tube_inner_d/2,0,0]) 
    rounded_sqare(x=6,y=5,r=.9,center=true);
  }
}

module led(){
  translate([-led_x/2,0,0]){
    square(size = [led_x,led_z1]);
    translate([(led_x-led_inner_x)/2,0,0]) 
    square(size = [led_inner_x,led_z2]);
  }
}

module tube(h=20, w_led_start=false){
  difference(){
    translate([0,0,h])
    rotate([180,0,0])
    difference(){
      linear_extrude(height = h)
      tube_2d(); 
      if(w_led_start){
        #cube([led_x-2,tube_inner_d,10*2],center=true);
        translate([-tube_outer_d,0,screw_z]) 
        rotate([0,90,0])
        #cylinder(h=2*tube_outer_d,d=screw_d);
      }
    }
    // rotate([0,60,0])
    translate([0,0,hole_off])
    rotate([90,0,60])
    #cylinder(h=tube_outer_d*2,d=hole_d, $fn=32, center=true);
  }
}


module tube_2d(){
  difference(){
    tube_base();
    translate([0,tube_outer_d/2-3,0])
    led();

    rotate([0,0,180])
    translate([0,tube_outer_d/2-3,0])
    led();

    cube([led_x,tube_inner_d,5],center=true);

    tube_inner();
  }
}

module tube_inner(){
  intersection() {
    square([tube_inner_d,tube_inner_d-tube_cutoff],center=true);
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