use <../libs/openscad_xels_lib/round.scad>;

x=43.8;
y=24;
z=14;


t=1;
r=10;

cut_x=21;
cut_z=7;
cut_r=5;

cable_x=4;
cable_y=2;

$fn=64;

outer();

module outer(){
  difference(){
    rounded_cube_z([x+2*t,y+2*t,z+t], r=r);
    
    translate([t,t,0]) 
    rounded_cube_z([x,y,z], r=r);

    translate([t+(x-cut_x)/2,0,-cut_z]) 
    rounded_cube_x([cut_x,t,2*cut_z], r=cut_r);

    translate([t+(x-cable_x)/2,y-cable_y,0]) 
    rounded_cube_z([cable_x,cable_y,2*z], r=.8);
  }
}