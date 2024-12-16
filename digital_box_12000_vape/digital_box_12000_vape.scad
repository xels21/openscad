use <../libs/openscad_xels_lib/round.scad>;

x=43.7;
y=23.8;
z_raw=14;

battery_z=12;

t=1;
r=11;

cut_x=21;
cut_z=8;
cut_r=5;

cable_x=4;
cable_y=2;

cablecut=.5;

$fn=64;

// outer();
outer(battery_count=2, with_cablecut=true);

module outer(battery_count=1, with_cablecut=false){
  z = z_raw+((battery_count-1)*battery_z);
  difference(){
    rounded_cube_z([x+2*t,y+2*t,z+t], r=r);

    translate([t,t,0]) 
    rounded_cube_z([x,y,z], r=r);

    translate([t+(x-cut_x)/2,0,-cut_z]) 
    rounded_cube_x([cut_x,t,2*cut_z], r=cut_r);

    translate([t+(x-cable_x)/2,y-cable_y,0]) 
    rounded_cube_z([cable_x,cable_y,2*z], r=.8);
    if(with_cablecut){
      translate([t+(x-cablecut)/2,y,0]) 
      cube([cablecut,2*t,2*z]);
    }
  }
}