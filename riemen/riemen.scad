res=256;

// belt(inner_r=(64/2), r_help=0.5,depth=3,outer_h=5,inner_h=3);
belt_depth=13;
outer_r=(130/2);
inner_r = outer_r-belt_depth;
shaft_d=15;
belt_case(
  inner_r=inner_r,
  belt_depth=belt_depth,
  outer_belt_h=10,
  inner_belt_h=3,
  belt_thickness=5,
  rad_l=20,
  rad_r=shaft_d/2+10,
  rad_stab=5,
  shaft_d=shaft_d,
  screw_d=4.2
);

module belt_case(inner_r, belt_depth, outer_belt_h, inner_belt_h, rad_l, rad_r, rad_stab, belt_thickness, shaft_d, screw_d){
/*
         ___________
        |   |   |   |
        |---|---|---|
        |---|---|---|
        |   |   |   |
________|   |   |   |_________
|           |   |            |
  \         |   |          /  
    |       |   |        |    
  /         |   |          \  
|___________|___|____________|
*/
  h_diff= outer_belt_h-inner_belt_h;

  belt_h_sum = belt_thickness+outer_belt_h+belt_thickness;

  difference(){
    rotate_extrude($fn=res)
    polygon(points=[
      [0,0],
      [inner_r+belt_depth,0],
      [inner_r+belt_depth,belt_thickness],
      [inner_r,belt_thickness+h_diff/2],
      [inner_r,belt_thickness+h_diff/2+inner_belt_h],
      [inner_r+belt_depth,belt_thickness+outer_belt_h],
      [inner_r+belt_depth,belt_h_sum],

      [rad_r,belt_h_sum+rad_stab],
      [rad_r,belt_h_sum+rad_l],
      [0,belt_h_sum+rad_l],
    ]);

    translate([-2*rad_r,0,belt_h_sum+rad_stab+(rad_l-rad_stab)/3])
    rotate([0,90,0])
    #cylinder(d=5.2,h=rad_r*4,$fn=res);

    #cylinder(d=shaft_d,h=belt_h_sum+rad_l,$fn=res);

    screw_r=inner_r-10;
    count = 5;
    for(i=[0:count]){
      translate([sin(i/count*360)*screw_r
              ,cos(i/count*360)*screw_r
              ,0]) 
        #cylinder(d=screw_d,h=belt_h_sum +rad_stab ,$fn=res/16);

      translate([sin((i+.5)/count*360)*inner_r*.65
              ,cos((i+.5)/count*360)*inner_r*.65
              ,0]) 
        #cylinder(d=inner_r*.55,h=belt_h_sum +rad_stab ,$fn=res/8);
    }
    for(i=[0:4]){
      translate([sin((i+.5)/4*360)*(rad_r-screw_d/2-3)
              ,cos((i+.5)/4*360)*(rad_r-screw_d/2-3)
              ,0]) 
      #cylinder(d=screw_d,h=belt_h_sum + rad_l ,$fn=res/16);
  }
  }
}

module belt(inner_r, r_help, depth, outer_h, inner_h){
  h_diff= outer_h-inner_h;
  rotate_extrude($fn=res)
  translate([inner_r,0,0])
  polygon(points=[
    [depth,0],
    [depth-r_help,0],
    [0,h_diff/2],
    [0,h_diff/2+inner_h],
    [depth-r_help,outer_h],
    [depth,outer_h]
  ]);

}