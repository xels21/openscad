use <../libs/openscad_xels_lib/round.scad>;


length_raw = 155;
back_off=10;
length = length_raw+back_off;
monitor_h=13;
grab_l=15;
grab_h=9;
holder_x=20;

rad=6;

screw_off=20;

max_z=monitor_h+grab_h;
max_x=holder_x+grab_l;

translate([-5,0,0])
mirror([1,0,0])
holder();

holder();

module holder(){

  difference(){
    rounded_cube([max_x,length,max_z+rad], r=rad, fn=30);

    translate([0,0,max_z])
    cube([max_x,length,rad]);

    translate([0,-back_off,grab_h])
    cube([grab_l,length,monitor_h]);

    translate([grab_l+holder_x/2,0,0])
    #union(){
      translate([0,screw_off,0])
      screw();

      translate([0,length/2,0])
      screw();

      translate([0,length-screw_off,0])
      screw();
    }
  }
}

module screw(){
  screw_d=4;
  cylinder(d1=8,d2=screw_d,h=4,$fn=32);
  cylinder(d=screw_d,h=max_z,$fn=32);
}