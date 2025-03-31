use <../libs/NUT_JOB__Nut_Bolt_Washer_and_Threaded_Rod_Factory/files/Nut_Job.scad>
use <../libs/Round-Anything/MinkowskiRound.scad>;
/*

                             /|
                            / |
                           /  |
                          /   |
                          MWMWM
MWMWMWMWMWMWMWMWMWMWMW    
|---               ---|   
   |---------------|      
   |---------------|      
|---               ---|   
MWMWMWMWMWMWMWMWMWMWMW    
                          MWMWM
                          \   |
                           \  |
                            \ |
                             \|


*/

// debug=true;
debug=false;

res=debug?16:128;

metal_screw_d_raw=8;
metal_screw_d=metal_screw_d_raw+1;

length = 72;

screw_thickness_plus=3;

bear_out_dil_raw = 22;
bear_out_dil = bear_out_dil_raw+0.2;
bear_h_raw = 7;
bear_h = bear_h_raw + 1;





//Thread step or Pitch (2mm works well for most applications ref. ISO262: M3=0.5,M4=0.7,M5=0.8,M6=1,M8=1.25,M10=1.5)
thread_step           = 2;
//Outer diameter of the thread
thread_outer_diameter = bear_out_dil + screw_thickness_plus + thread_step;
//Step shape degrees (45 degrees is optimised for most printers ref. ISO262: 30 degrees)
step_shape_degrees    = 45;
//Length of the threaded section
thread_length         = length;
//Resolution (lower values for higher resolution, but may slow rendering)
resolution            = debug?3:0.5;
//Countersink in both ends
countersink           = 2;
//Distance between flats for the hex head or diameter for socket or button head (ignored for Rod)
head_diameter         = 0;
//Height of the head (ignored for Rod)
head_height           = 0;
//Length of the non-threaded section
non_thread_length     = 0;
//Diameter for the non-threaded section (-1: Same as inner diameter of the thread, 0: Same as outer diameter of the thread, value: The given value)
non_thread_diameter   = 0;

nut_thread_outer_diameter_tol = 0.4;


// fil_screw();
// fil_nut();
// translate([60,0,0])
// fil_nut(isConterNut=true);
fil_nut(isConterNut=true);

module fil_screw(){
  difference(){
    hex_screw(
      thread_outer_diameter,
      thread_step,
      step_shape_degrees,
      thread_length,
      resolution,
      countersink,
      head_diameter,
      head_height,
      non_thread_length,
      non_thread_diameter);
      
      translate([0,0,-1])
      cylinder(d=metal_screw_d,h=thread_length+2,$fn=res);

      translate([0,0,-1])
      cylinder(d=bear_out_dil,h=bear_h+1,$fn=res);

      translate([0,0,thread_length-bear_h])
      cylinder(d=bear_out_dil,h=bear_h+1,$fn=res);
  }
}

module fil_nut(isConterNut=false){
  screw_offset = 12;
  rounding = debug?0:1;

  max_d=90;
  min_d=thread_outer_diameter+screw_offset;

  nut_w = 8;


  finger_hole_d = (max_d-min_d)*0.85;//*1.03;
  holes = 3;
  hol_fac = 0.4;

  rot_of = 0;

  difference(){
    minkowskiOutsideRound(rounding)
    if(isConterNut){
      cylinder(d=min_d+4,h=nut_w,$fn=6);
    }else{
      difference(){
        cylinder(d1=max_d,d2=min_d,h=nut_w,$fn=6);
          for (i=[1:holes]) {
                  translate([sin(i/holes*360+rot_of)*max_d*hol_fac
                    ,cos(i/holes*360+rot_of)*max_d*hol_fac
                    ,0]) 
                    cylinder(d=finger_hole_d,h=nut_w,$fn=6);
          }
      }
    }

    hex_screw(
      thread_outer_diameter+nut_thread_outer_diameter_tol,
      thread_step,
      step_shape_degrees,
      nut_w,
      resolution,
      0,
      head_diameter,
      head_height,
      non_thread_length,
      non_thread_diameter);
  }
}