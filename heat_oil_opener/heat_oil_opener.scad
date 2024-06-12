use <../libs/Round-Anything/MinkowskiRound.scad>;

RELEASE = false;
// RELEASE = true;

d=68;
teeth_count = 12;
teeth_d = 6;
teeth_h = 1.5;

d_thickness = RELEASE ? 15 : 5;
handle_w = 30;
handle_l = 70;

rounding = 2;
extrude = RELEASE ? 10 : 1;

$fn=64;

difference(){
  if(RELEASE){
    minkowskiOutsideRound(rounding)
    linear_extrude(extrude)
    outer_2d();
  }else {
    linear_extrude(extrude)
    outer_2d();
  }

  linear_extrude(extrude)
  inner_2d();
}

module inner_2d(){
  fac = 0.50;
  circle(d=d);
    for(i=[0:teeth_count]){
        translate([sin(i/teeth_count*360)*d*fac
                ,cos(i/teeth_count*360)*d*fac
                ,0]) 
    rotate([0,0,-i/teeth_count*360])
    scale([1,.5,1])
    circle(d=teeth_d);
  }
}

module outer_2d(){
  circle(d=d + 2*d_thickness);
  if (RELEASE){
    outer_handle_2d();
  }
}
module outer_handle_2d(){
  translate([0,-handle_l-d/2]){
    translate([-handle_w/2,0])
      square([handle_w,handle_l]);
    circle(d=handle_w);
  }
}