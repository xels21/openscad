use <../libs/Round-Anything/MinkowskiRound.scad>;
use <../libs/openscad_xels_lib/round.scad>;

/*
 _____________
|   __        |
|  /  \-----  |
|  |  |-----  |
|  |  |-----  |
|  |  |-----  |
|  |  |-----  |
|  |  /     _/|
|_ | |   ,;°__|
   | |

*/

thickness = 2;

x_brush_offset = 4;
x1_raw = 7;
x1=x1_raw+x_brush_offset;
x_raw = 18;
x_tol=2;
x = x_raw+x_tol;
x_max=2*thickness+x;
x1_leftover = x-(x1_raw+x_brush_offset);

// x_max=x2 + 2*thickness;

y_raw=14;
y_tol=1;
y = y_raw+y_tol;
y_max = 2*thickness+y;

z_raw = 31;
z_tol = 5;
z = z_raw+z_tol;
z_max = 2*thickness+z;

res=64;
rad=3;

entry_rad=4;

// translate([thickness,thickness,0])
// rounded_cube_z([x1,y,thickness],r=thickness);


toothbrush_case();

module toothbrush_case(){
  difference(){
    minkowskiOutsideRound(rad)
    cube([x_max,y_max,z_max]);

    translate([thickness,thickness,thickness])
    minkowskiOutsideRound(rad)
    cube([x,y,z]);

    translate([thickness,thickness,0])
    rounded_cube_z([x1,y,thickness+rad],r=entry_rad);
  }
  translate([thickness+x1,thickness,thickness])
  difference(){
    cube([x1_leftover,y,x1_leftover]);

    translate([0,0,x1_leftover])
    rotate([-90,0,0])
    cylinder(r=x1_leftover,$fn=res,h=y);
  }
}