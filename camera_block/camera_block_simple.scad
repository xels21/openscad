use <../libs/openscad_xels_lib/round.scad>;


x=16;
y=20;
z=16;

t=2;

r=1.5;


difference(){
  rounded_cube_y([x,y+2*t,z+t], r=r);

  translate([0,t,-r])
  rounded_cube_y([x,y,z+r], r=r/2);
}
