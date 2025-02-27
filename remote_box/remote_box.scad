use <../libs/Round-Anything/MinkowskiRound.scad>;
use <../libs/openscad_xels_lib/round.scad>;
// x=48;
x=55; //bigger
// y=23;
y=25; //bigger
z=55;

t=2;

x_max=t+x+t;
y_max=t+y+t;
z_max=t+z;

screw_d = 4;

res=99;

simple_heater_hanger();
module simple_heater_hanger(){
  w = 59.5;
  thickness = 3;
  extrude = 20;
  back_length = 30;
  front_length = 140;

  holes_gap=15;
  holes_d=3;

/*
 ________
|  ____ |
| |   | |
|_|   | |
      | |
      | |
      | |
      |=|
      |=|
      |_|
*/

difference(){
  linear_extrude(height = extrude) 
  difference(){
    
    rounded_sqare(x=2*thickness+w,y=front_length+thickness,r=thickness*.6,fn=res);
    // square([2*thickness+w,front_length+thickness]);
    translate([thickness,-thickness,0])
    rounded_sqare(x=w,y=front_length+thickness,r=thickness*.6,fn=res);

    // square([w,front_length]);
    square([thickness,front_length-back_length]);
  }
  
  translate([0,extrude/2,extrude/2]) 
  rotate([0,90,0]){
    translate([0,holes_gap,0])
    #cylinder(d=holes_d,h=100,$fn=16);
    #cylinder(d=holes_d,h=100,$fn=16);
  }
}

}

// hook_box();

module hook_box(){
// minkowskiOutsideRound(t*0.35)
  union() {
    hook();
    box();
  }
}


module hook(){
  translate(v = [x_max/2, 0, z_max]) 
  rotate([-90, 0, 0]) 
  difference() {

    cylinder(h = t, d = x_max, $fn=res);
    translate(v = [0, -x_max/4, 0]) 
    cylinder(h = t, d = screw_d,$fn=res/3);
  }
}

module box(){
  difference() {
    cube(size = [x_max, y_max, z_max]);
    translate(v = [t,t,t])
    cube(size = [x, y, z]);
  }
}