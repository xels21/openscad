use <../libs/Round-Anything/MinkowskiRound.scad>;


/*

           __
          |__|
          |__|              ____
          |  |             |   |
          |  |             |   |
          |  |             |   |
          |  |_____________|   |
          |                    |
          |               _,-*`
          |          _,-*`
          |     _,-*`
          |_,-*`

*/



controller_w_raw=42;
controller_w_plus=10;
controller_w=controller_w_raw+controller_w_plus;

controller_h=30;

back_h=controller_h+20;

controller_extrude = 140;
controller_extrude_gap_raw=50;
controller_extrude_gap=controller_extrude_gap_raw+0;

controller_gap_off=10;

screw_off=15;

t=10;

lower_support=20;

max_x=t+controller_w+t;

frame_3d();

module frame_3d(){
  difference(){
  minkowskiOutsideRound(t*.5, $fn=32)
    difference(){
      union(){
        rotate([90,0,-90])
        translate([0,0,-.5*controller_extrude])
        linear_extrude(height = controller_extrude)
        frame_2d();
      }

      // back cut
      translate([0,0,controller_gap_off])
      scale([1.9,1,3])
      translate([0,0,controller_extrude_gap_raw*.462])
      rotate([90,1/16*360,0])
      #cylinder(h=t,d=controller_extrude_gap_raw,$fn=8);

      // front cut
      translate([0,0,controller_gap_off])
      scale([2.6,1,6])
      translate([0,-(t+controller_w),controller_extrude_gap*.462])
      rotate([90,1/16*360,0])
      #cylinder(h=t,d=controller_extrude_gap,$fn=8);

      // preview
      // #cube([controller_extrude_gap,200,10],center=true);
    }

    mirror([1,0,0])
    left_screw();
    left_screw();
  }
}

module left_screw(){
    translate([-controller_extrude/2+screw_off,0,back_h-screw_off])
    rotate([90,0,0])
    #cylinder(h=t,d=4,$fn=10);
}

module frame_2d(){
  // !offset(t*.3)
  // offset(-t*.3)
  polygon(points=[
    [0,0],
    [0,back_h],
    [t,back_h],
    [t,0],
    [t+controller_w,0],
    [t+controller_w,controller_h],
    [t+controller_w+t,controller_h],
    [t+controller_w+t,-t],
    [0,-t-lower_support],
    ]);
}