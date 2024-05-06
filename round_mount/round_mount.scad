use <../libs/Round-Anything/MinkowskiRound.scad>;


/*

       ______________
      |             |
 _____|    _____    |______
| ||     #`     `#     || |
| ||   /           \   || |
|_||__|_____________|__||_|

*/



d=34;
thickness = 8;

circle_gap = 0.5;

screw_fac=.7;
top = 50;

rad=4;

length = 20;

screp_mount_gap = 35;

intersection() {
difference(){
//BODY
  minkowskiOutsideRound(rad)
  translate([0,length/2,0])
  rotate([90,0,0]) 
  linear_extrude(length){
  union(){
    // #circle(d=d + 2*thickness);

    translate([d*screw_fac,0,0])
    square([d*screw_fac,d*screw_fac], center=true);

    translate([-d*screw_fac,0,0])
    square([d*screw_fac,d*screw_fac], center=true);

    square([top,d+2*thickness], center=true);
    }
  }

//HOLE
  translate([0,length/2,0]) 
  rotate([90,0,0])
  cylinder(d=d, h=length, $fn=64);

//SIDE SCREWS
  translate([1.25*d*screw_fac,0,0]) 
  #cylinder(d=3, h=d*screw_fac, $fn=16);

  translate([-1.25*d*screw_fac,0,0]) 
  #cylinder(d=3, h=d*screw_fac, $fn=16);

//CENTER SCREWS
  translate([.5*screp_mount_gap,0,d*.2]) 
  #cylinder(d=3, h=d, $fn=16);

  translate([-.5*screp_mount_gap,0,d*.2]) 
  #cylinder(d=3, h=d, $fn=16);
}
translate([0,0,(d/2+thickness)/2+circle_gap]) 
cube(size = [3*d*screw_fac,length,d/2+thickness],center=true);
}