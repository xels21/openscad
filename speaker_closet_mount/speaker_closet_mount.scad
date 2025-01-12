use <../libs/openscad_xels_lib/round.scad>;



positions=16;
scale_fac = 1.34;

border_height=35;
closet_height=20;

closet_plus_border_height=border_height + closet_height;

inner_rot_r=66;

speaker();
// closet();

module closet(){
  difference(){
  translate([0,0,-(closet_plus_border_height/2)+border_height])
  rounded_cube([inner_rot_r*2.25,inner_rot_r*2.25,closet_plus_border_height], center=true, r=8, fn=32);
  translate([0,0,-20]) 
  rounded_cube_x([110,inner_rot_r*3,border_height+2], center=true, r=2);

  translate([0,0,-border_height])
  linear_extrude(height = border_height*2) 
  rotate([0,0,.5/positions*360])
  circle(r=inner_rot_r+1, $fn=positions);
  }
}

module speaker(){
  difference(){
    linear_extrude(height = border_height) 
    rotate([0,0,.5/positions*360])
    circle(r=inner_rot_r, $fn=positions);

    translate([0,0,14])
    rotate([20,0,0])
    linear_extrude(height = border_height+1)
    #scale([scale_fac,scale_fac,1])
    translate([-38.5,-29,])
    import("speaker_closet_mount.svg");
  }
}
