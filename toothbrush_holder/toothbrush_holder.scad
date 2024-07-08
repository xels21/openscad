/*

 __ 
|  |
|  |
|  |
|  |
|  |
|  |      ___
|  |  __/   |
|  |_/   __/
|     __/
|  __/ 
|_/


 ______________
|             |
|             |
|             |
|             |
|___       ___|
|  |       |  |
|  |       |  |
|__|_______|__|

*/

use <../libs/Round-Anything/MinkowskiRound.scad>;
use <../libs/openscad_xels_lib/round.scad>;


tb_min_x = 8;
holder_length = 12;
holder_end = 2;
holder_thickness = 6;
holder_angle_plus = 2;
holder_side_thickness = 5;
holder_wall_length = 40;
holder_wall_thickness = 2;

mirror_h1=18;
mirror_h2=17;
mirror_length=30;

hole_rad=3;
rad=1;

x_max = holder_wall_thickness + holder_length;
y_max = holder_thickness + holder_wall_length;


toothbrush(true);
// toothbrush(false);

module toothbrush(with_mirror=false){
  minkowskiOutsideRound(rad)
  difference(){
    // minkowskiRound(rad)
    linear_extrude(height = holder_side_thickness + tb_min_x + holder_side_thickness) 
    toothbrush_2d(with_mirror);

    translate([holder_wall_thickness+rad*.4,0,holder_side_thickness])
    rounded_cube_x([holder_length+hole_rad,holder_thickness+holder_angle_plus+holder_end, tb_min_x], r=hole_rad, center=false, fn=1);
  }
}

module toothbrush_2d(with_mirror=false){
  if(with_mirror){
    translate([-mirror_length,holder_wall_length+holder_thickness,0]) 
    polygon([
        [0,0],
        [mirror_length+holder_wall_thickness,0],
        [mirror_length+holder_wall_thickness,mirror_h1],
        [0,mirror_h2],
      ]);
  }
  polygon(points = [
   [0,0],
   [0,y_max],
   [holder_wall_thickness,y_max],
   [holder_wall_thickness,holder_thickness],
   [x_max-holder_end,holder_thickness+(holder_angle_plus*(1-(holder_wall_thickness/(x_max-holder_end))))],
   [x_max-holder_end,holder_end+holder_thickness+(holder_angle_plus*(1-(holder_wall_thickness/(x_max-holder_end))))],
   [x_max,holder_end+holder_thickness+(holder_angle_plus*(1-(holder_wall_thickness/(x_max-holder_end))))],
   [x_max,holder_angle_plus+holder_end],
   [x_max-holder_end,holder_angle_plus],
  //  [x_max,holder_angle_plus],
  ]);
}