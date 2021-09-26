use <../libs/openscad_xels_lib/round.scad>;


VARIANT_A = true;

h         = VARIANT_A ? 25.0 : 25.0  ;
thickness = VARIANT_A ?  4.0 :  0.7  ;

/*
y   = m * x         + b
fac = m * thickness + b

0.54 = 5m+b
m=0.54/5 - b/5

0.572 = 0.7m+b
m= 0.572/0.7 - b/0.7

0,54/5 - b/5              = 0,572/0,7 - b/0,7
0,108  - 0,81714285714286 = - b/0,7 + b/5
-0,70914285714286         = -1,428571428571429b + 0.2b
-0,70914285714286         = -1,228571428571429b
0,5772093023255835          = b

y=mx+b
0,54=5m+0,577209302325583
-0,577209302325583 = 5m
m=-0,0074418604651166

y= -0,0074418604651166 * 5   + 0,5772093023255835
y= -0,0074418604651166 * 0,7 + 0,5772093023255835
*/

fac       = -0.0074418604651166 * thickness + 0.5772093023255835;
bottom    = 0.2 ;
rounding  = 7   ;


can_d_raw=65;
can_d_tol=2.1;
can_d_inner = can_d_raw + can_d_tol;
can_d_outer = can_d_inner+2*thickness;

count=3;

res=128;


can_organizer_v2();

module can_organizer_v2(){
    for(i=[0:count]){
    translate([sin(i/count*360)*can_d_outer*fac
              ,cos(i/count*360)*can_d_outer*fac
              ,0]) 
  single_can_holder(d_inner=can_d_inner, thickness=thickness, h=h);
}
}

module single_can_holder(d_inner, thickness, h){
  rotate_extrude($fn=res)
  translate([can_d_inner/2,0,0])
  rounded_sqare(x=thickness, y=h, r=thickness/2.001, fn=1);
}

module can_organizer_v1(){
  difference(){
    cans_outer();
    cans_inner();
  }
}

module cans_inner(){
  translate([0,0,bottom])
  // minkowskiOutsideRound(rounding)
  for(i=[0:count]){
    translate([sin(i/count*360)*can_d_outer*fac
              ,cos(i/count*360)*can_d_outer*fac
              ,0]) 
    rounded_cylinder(r=can_d_inner/2,h=2*h,n=rounding, fn=res);
  }
}

module cans_outer(){
  for(i=[0:count]){
    translate([sin(i/count*360)*can_d_outer*fac
              ,cos(i/count*360)*can_d_outer*fac
              ,0]) 
    cylinder(d=can_d_outer,h=h,$fn=res);
  }
  cylinder(d=can_d_outer,h=h,$fn=6);
}

module can(){
  difference(){
    circle(d=can_d_outer,$fn=res);
    circle(d=can_d_inner,$fn=res);
  }
}