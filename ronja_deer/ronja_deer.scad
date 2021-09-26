use <..\libs\Round-Anything\MinkowskiRound.scad>;
// minkowskiOutsideRound(3,1)


depth=20;
thickness=2;

x_raw=14;
y_raw=4;

tol=0.5;

x=x_raw+tol;
y=y_raw+tol;

x_overhang=4;

minkowskiOutsideRound(1)
linear_extrude(depth)
difference(){
  square([x+thickness*2,y+thickness*2],center=true);
  square([x,y],center=true);
  translate([0,y,0])
  square([x-x_overhang,y],center=true);
}