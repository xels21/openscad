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



thickness = 4;
hanger_x = 13.5;
hanger_x_span = 2;
hanger_y = 25.5;
hanger_clip = 2;

hook_hanger_off=25;

hook_x=15;
hook_y=14;
hook_rounding=4;
hook_secure=3;

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
    [thickness,-hook_y+hook_rounding],
    [thickness+hook_rounding,-hook_y],
    [thickness+hook_x-hook_rounding,-hook_y],
    [thickness+hook_x,-hook_y+hook_rounding],
    [thickness+hook_x,-hook_secure],
    [thickness+hook_x-hook_secure,0],
    [thickness+hook_x+thickness,0],
    [thickness+hook_x+thickness,-hook_y-thickness+hook_rounding],
    [thickness+hook_x+thickness-hook_rounding,-hook_y-thickness],
    [+hook_rounding,-hook_y-thickness],
    [0,-hook_y-thickness+hook_rounding],
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