use <../libs/Round-Anything/MinkowskiRound.scad>;


/*
____
|  |
|  |
|  |
|  |
|  |
|  |______    _____
|        |   |    |
|________|   |____|


*/


fence_h = 35;
fence_t = 4;

screw_h = 7;
screw_d = 4;

screw_fence_offset = 8;

max_x=screw_fence_offset+screw_d*3;

screw_screw_gap = 54;
screw_offset_1=18;

length=100;

fridge_fence();

module fridge_fence(){
  difference(){
    translate([length,screw_fence_offset+screw_d*.5,0]) 
    rotate([90,0,-90])
    fridge_fence_base();

    translate([screw_offset_1,0,0]){
      cylinder(d=screw_d,h=screw_h, $fn=32);
      translate([screw_screw_gap,0,0]) 
      cylinder(d=screw_d,h=screw_h, $fn=32);
    }
  }
}

module fridge_fence_base(){
    minkowskiOutsideRound(fence_t*.5)
    linear_extrude(height = length)
    polygon(points = [
      [0,0],
      [0,fence_h],
      [fence_t,fence_h],
      [fence_t,screw_h],
      [max_x-screw_d,screw_h],
      [max_x,0],
    ]);
}