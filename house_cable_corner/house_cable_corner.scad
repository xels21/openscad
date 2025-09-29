use <../libs/openscad_xels_lib/round.scad>;


x=70;
y=100;
z=90;

t=21;
t_min=17;
t_off=t-t_min;
t_gap=20;

cable_x_off=30;
cable_t=30;

screw_d=5;

r=5;

difference(){
  union(){
    translate([0,y-t,0])
    cube([x,t,z]);
    translate([0,0,z-t])
    cube([x,y,t]);
  }
  #union(){
    translate([0,y-t,0])
    translate([cable_x_off,t_off,t_gap])
    rounded_cube_z([cable_t,t_min+r,z], r=r, center=false);

    translate([0,0,z-t])
    translate([cable_x_off,t_gap,t_off])
    rounded_cube_x([cable_t,y,t_min+r], r=r, center=false);
  }
  #union(){
    translate([15,y/2,0])
    cylinder(r=screw_d/2, h=z);

    translate([15,0,z/2])
    rotate([-90,0,0])
    cylinder(r=screw_d/2, h=y);
  }

}