use <../libs/Round-Anything/MinkowskiRound.scad>;

// RELEASE = false;
RELEASE = true;

d=68.5;
teeth_count = 12;
teeth_d = 6.2;
teeth_h = 1.2;

// d_thickness = RELEASE ? 15 : 5;
d_thickness = 10;
d_sum = d + 2*d_thickness;
handle_w = 25;
handle_l_out = 30;
handle_l = d+2*handle_l_out;

extrude = RELEASE ? 10 : 1;
rounding = extrude*.4;

$fn=RELEASE ? 64 : 20;
// res = RELEASE ? 64 : 20;

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
    scale([1,(2*teeth_h)/teeth_d,1])
    circle(d=teeth_d, $fn=16);
  }
}

module outer_2d(){
  circle(d=d_sum);
  outer_handle_2d();
}

module outer_handle_2d(){
    // square connector
    translate([-handle_w/2,-handle_l/2])
    square([handle_w,handle_l]);

    //both ends
    translate([0,-handle_l/2])
    circle(d=handle_w);
    translate([0,handle_l/2])
    circle(d=handle_w);

    //support
    scale([.6,1,1])
    #circle(d=d_sum*1.2);
}