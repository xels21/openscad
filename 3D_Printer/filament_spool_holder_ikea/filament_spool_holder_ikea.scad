use <../../libs/openscad_xels_lib/round.scad>;
use <..\..\libs\Round-Anything\MinkowskiRound.scad>;

height = 125;
y_thick = 15;
y_max = 50;
x_off = 20;
d=8.2;
x_thick = 7;

x_inner = x_thick+d+x_thick;
x_max=x_off+x_inner+x_off;

step_h=10;

stand();
translate([0,0,height+d/2])
top();

module top(){
  // translate([0,0,height])

  difference(){
    rotate([-90,0,0])
    minkowskiOutsideRound(3)
    cylinder(d=d+x_thick*4,h=y_thick, $fn=6);

    rotate([-90,0,0])
    cylinder(d=d,h=y_thick, $fn=64);

    translate([-d/2, 0,0])
    cube([d,y_thick, 100]);
  }
}

module stand(){
  difference(){
    union(){
      // translate([0,0,step_h/2])
      // cube([x_max,y_max*2,step_h], center=true);

      scale([x_max/2/100,y_max/100,0.05])
      rotate([0,0,45])
      cylinder(d1=283,d2=230,h=100, $fn=4); //scale =100

      scale([x_max/2/100,y_max/100,0.2])
      rotate([0,0,45])
      cylinder(d1=170,d2=0,h=100, $fn=4); 

      translate([-x_inner/2,0,0])
      rounded_cube_z([x_inner,y_thick,height], r=4);
    }
    translate([0,-y_max,step_h])
    cube([x_max*2,y_max*2, step_h*2],center=true);

    translate([20,8,0])
    cylinder(d=4,h=100,$fn=64);

    translate([-20,8,0])
    cylinder(d=4,h=100,$fn=64);

    translate([0,35,0])
    cylinder(d=4,h=100,$fn=64);
  }
}