use <../libs/Round-Anything/MinkowskiRound.scad>;
use <../libs/Poor_mans_openscad_screw_library/polyScrewThread_r1.scad>;



/*
           _________________________
  _       |                         |
 / \      |     ____________________|
|   |     |    |
|   |     |    |
|   |     |    |
\   \____/     |______________________________
 \                             >        <    |
  \____________________________>________<____|
*/

thickness=10;
length = 10;

screw_res = 1;
screw_deg = 55;
screw_step = 4;
screw_d = 7;
screw_head = 5;

screw_h=thickness+2;

table_height = 25;
table_height_span=1;
hook_gap=10;
hook_height=15;
hook_support=3;


tagble_length = 30;
tagble_length_lower_plus = 20;

rad=3;

all(with_screw=true);


module all(with_screw=true){
  difference() {
    minkowskiRound(rad)
    union(){
      table();
      translate([0,hook_support,0])
      hook();
    }
    if(with_screw){
      translate(v = [thickness + tagble_length + tagble_length_lower_plus-screw_d,-screw_head,length/2]) 
      rotate([-90,0,0])
      screw();
    }
  }
  if(with_screw){
      translate(v = [thickness*2,thickness + table_height*.5,0])
      scale(.96)
      screw();
  }
}

module hook(){
  max_h = thickness + hook_height;
  max_x = hook_gap + thickness;
  linear_extrude(height = length)
  polygon(points = [
    [0,-hook_support],
    [-hook_support,0],
    [-max_x+hook_support*2,0],
    [-max_x,hook_support*2],
    [-max_x,max_h-hook_support],
    [-max_x+hook_support,max_h],
    [-max_x+thickness-hook_support,max_h],
    [-max_x+thickness,max_h-hook_support],
    [-max_x+thickness,thickness+hook_support],
    [-max_x+thickness+hook_support,thickness],
    [-hook_support,thickness],
    [0,thickness+hook_support],
  ]);
}

module table(){
  max_h = thickness + table_height + thickness;
  max_x = thickness + tagble_length + tagble_length_lower_plus;
  difference(){
    linear_extrude(height = length) 
    polygon(points = [
      [0,0],
      [0,max_h],
      [thickness+tagble_length,max_h-table_height_span],
      [thickness+tagble_length,max_h-thickness-table_height_span],
      [thickness,max_h-thickness],
      [thickness,thickness],
      [max_x,thickness+table_height_span],
      [max_x,0+table_height_span],
    ]);
  }
}

module screw(){
  hex_screw(screw_d,  // Outer diameter of the thread
            screw_step,  // Thread step
            screw_deg,  // Step shape degrees
            screw_h,  // Length of the threaded section of the screw
            screw_res,  // Resolution (face at each 2mm of the perimeter)
            2,  // Countersink in both ends
            screw_d+5,  // Distance between flats for the hex head
            screw_head,  // Height of the hex head (can be zero)
            0,  // Length of the non threaded section of the screw
            0);  // Diameter for the non threaded section of the screw
}