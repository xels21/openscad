use <../libs/Round-Anything/MinkowskiRound.scad>;


/*
 __________
|  _______ |
| |      | |
| |      | |
| |     _| |
| |    |___|
| |
| |
| |
| |
| |
| |
| |      _
| |     | |
| \____/  |
|_________|

*/



thickness = 3;
hanger_x = 14;
hanger_x_span = 2;
hanger_y = 26.5;
hanger_clip = 2;

hook_hanger_off=30;

hook_x=18;
hook_y=12;
hook_support=4;

z = 6;
round = 1.5;

difference(){
  minkowskiOutsideRound(round)
  linear_extrude(height = z)
  base_2d();

  #translate([thickness,thickness,0]) 
  linear_extrude(height = z)
  hanger_2d(t=0);
}


module base_2d(){
  difference(){
    union() {
      translate([0,-hook_hanger_off,0])
      hook_2d();
      translate([0,-hook_hanger_off,0])
      hook_hanger_off_2d();
      hanger_2d(t=thickness);
    }
    translate([thickness,0,0]) 
  square([hanger_x-hanger_x_span-hanger_clip,thickness+round]);
  }
}

module hanger(){
  difference(){
    hanger_2d(t=thickness);
    translate([thickness,thickness,0]) 
    hanger_2d(t=0);
  }
}


module hook_hanger_off_2d(){
  square([thickness,hook_hanger_off]);
}

module hook_2d(){
  polygon(points = [
    [0,0],
    [thickness,0],
    [thickness,-hook_y+hook_support],
    [thickness+hook_support,-hook_y],
    [thickness+hook_x-hook_support,-hook_y],
    [thickness+hook_x,-hook_y+hook_support],
    [thickness+hook_x,0],
    [thickness+hook_x+thickness,0],
    [thickness+hook_x+thickness,-hook_y-thickness],
    [0,-hook_y-thickness],
    ]);

}

module hanger_2d(t=0){
  polygon(points = [
    [0,0],
    [0,t+hanger_y+t],
    [t+hanger_x+t,t+hanger_y+t],
    [t+hanger_x+t-hanger_x_span,0],
    ]);
}