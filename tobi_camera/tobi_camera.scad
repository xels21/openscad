use <../libs/openscad_xels_lib/round.scad>;

x=12.5;
y=6.5;

d=2.5;
off = 1;

h1=2;
h2=5;

d_gap = .5;

$fn=32;

difference(){
  union(){
    rounded_cube_z([x,y,h1], r=y*.49);
    translate([off,off,0]) 
    rounded_cube_z([x-off*2,y-off*2,h2], r=(y-off*2)*.49);
  }

  translate([off+d/2+1,y/2,0]){ 
    cylinder(d=d,h=h2);
    translate([d+d_gap,0,0]) 
    cylinder(d=d,h=h2);
    translate([d+d_gap+d+d_gap,0,0]) 
    cylinder(d=d,h=h2);
  }
}