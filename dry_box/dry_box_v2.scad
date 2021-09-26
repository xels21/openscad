use <..\libs\NUT_JOB__Nut_Bolt_Washer_and_Threaded_Rod_Factory\files\Nut_Job.scad>
/*

 /|
| |__
|    MWMW
|       |
|-------|
|-------|
|  __MWMW
| |
| |
| |
 \|

 ____
|    \
|    |
MWMWMW


MWMWMW
|    |
|___/


*/

// debug=true;
debug=false;

res=debug?16:128;

big_d_hole_raw=8;
big_d_hole=big_d_hole_raw+0.2;

big_thread_length = 4;

filament_d_hole_raw=1.75;
filament_d_hole=filament_d_hole_raw+0.25;

filament_thread_length = 2;

hole_thickness=4;

head_r_plus=3;

box_t_raw=2;
box_t=box_t_raw+0.0;


//Outer diameter of the thread
// thread_outer_diameter = big_d_hole+hole_thickness;
//Thread step or Pitch (2mm works well for most applications ref. ISO262: M3=0.5,M4=0.7,M5=0.8,M6=1,M8=1.25,M10=1.5)
thread_step           = 1.5;
//Step shape degrees (45 degrees is optimised for most printers ref. ISO262: 30 degrees)
step_shape_degrees    = 45;
//Length of the threaded section
// thread_length         = thread;
//Resolution (lower values for higher resolution, but may slow rendering)
resolution            = debug?2:0.5;
//Countersink in both ends
countersink           = 1;
//Distance between flats for the hex head or diameter for socket or button head (ignored for Rod)
// head_diameter         = thread_outer_diameter+2*head_r_plus;
//Height of the head (ignored for Rod)
head_height           = 2;
//Length of the non-threaded section
non_thread_length     = box_t;
//Diameter for the non-threaded section (-1: Same as inner diameter of the thread, 0: Same as outer diameter of the thread, value: The given value)
// non_thread_diameter   = thread_outer_diameter;


union(){
  outer(hole_d = filament_d_hole, thread_length = filament_thread_length);
  translate([15,0,0])
  inner(hole_d = filament_d_hole, thread_length = filament_thread_length);
}

// translate([0,17,0])
// union(){
//   outer(hole_d = big_d_hole, thread_length=big_thread_length);
//   translate([22,0,0])
//   inner(hole_d = big_d_hole, thread_length=big_thread_length);
// }

// translate([0,-17,0])
// union(){
//   outer(hole_d = big_d_hole, thread_length=big_thread_length);
//   translate([22,0,0])
//   inner(hole_d = big_d_hole, thread_length=big_thread_length);
// }


module inner(hole_d, thread_length){
  thread_outer_diameter = hole_d + hole_thickness;
  head_diameter         = thread_outer_diameter+2*head_r_plus;
  non_thread_diameter   = thread_outer_diameter;

  difference(){
    hex_screw(thread_outer_diameter,thread_step,step_shape_degrees,thread_length,resolution,countersink,head_diameter,head_height,non_thread_length,non_thread_diameter);
    cylinder(d=hole_d,h=head_height+thread_length+non_thread_length+0.1,$fn=res);
  }
}

module outer(hole_d, thread_length){
  thread_outer_diameter = hole_d + hole_thickness;
  head_diameter         = thread_outer_diameter+2*head_r_plus;
  nut_thread_outer_diameter_tol = 0.4;


  nut_diameter              =head_diameter;
  nut_height                =thread_length;
  nut_thread_step           =thread_step;
  nut_step_shape_degrees    =step_shape_degrees;
  nut_thread_outer_diameter =thread_outer_diameter+nut_thread_outer_diameter_tol;
  nut_resolution            =resolution;
	hex_nut(nut_diameter,nut_height,nut_thread_step,nut_step_shape_degrees,nut_thread_outer_diameter,nut_resolution);
}