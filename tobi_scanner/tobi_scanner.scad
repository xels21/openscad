use <../libs/Round-Anything/MinkowskiRound.scad>;

p_h=35;
p_h_off=4;
p_h_inner=p_h-2*p_h_off;

p_inner_t=1.5;
p_t=4;
p_diff_t = p_t - p_inner_t;

d_1=130;
d_2=115;

// res=32;
res=256;


screw_outer=10;
screw_inner=4;
screw_inner_top_d=8;
screw_inner_top_h=3;
screw_h=10;

rounding = 1;

// mirror([1,0,0]) 
all();

module all(){
  difference(){
    minkowskiOutsideRound(rounding) 
    raw_w_p();
    translate([0,0,-rounding/2]) 
    cube([d_1*2,d_1*2,rounding],center=true);
  }
  // bottom
  // translate([0,-d_1/2-screw_outer,0])
  // screw();

  //bottom_right
  translate([d_1/3-screw_outer/2,-d_1/2-screw_outer,0])
  screw();

  //top
  translate([0,d_1/2-1.2*screw_outer+screw_h*2,0])
  rotate([0,0,180])
  screw();


  //left
  translate([-d_1/2-screw_outer+p_diff_t,0,0])
  rotate([0,0,-90])
  screw();

  //right
  translate([d_2/2+screw_outer-p_diff_t,0,0])
  rotate([0,0,90])
  screw();

}

module screw(){
difference(){
  union(){
    cylinder(d=screw_outer, h=screw_h,$fn=res);
    translate([-screw_outer/2,0])
    cube([screw_outer,screw_outer,screw_h]);
  }
  translate([0,0,screw_h-screw_inner_top_h])
  cylinder(d2=screw_inner_top_d, d1=screw_inner, h=screw_inner_top_h, $fn=res);

  cylinder(d=screw_inner, h=screw_h,$fn=res);
}
}

module raw_w_p(){
  difference(){
    translate([0,0,-rounding]) 
    linear_extrude(p_h+rounding) 
    raw(d_1=d_1, d_2=d_2);
    
    translate([0,0,p_h_off]) 
    linear_extrude(p_h_inner) 
    raw(d_1=d_1-p_diff_t*2, d_2=d_2-p_diff_t*2);
  }
}

module raw(d_1=d_1,d_2=d_2){
  half_circle(d=d_1,t=p_t, is_left=true);
  translate([0,(d_1-d_2)/2,0]) 
  half_circle(d=d_2,t=p_t, is_left=false);
  extension(d_1,length=70);
}

module extension(d_1=d_1,length){
  translate([0,-d_1/2]) 
  square([length,p_t]);
}
module half_circle(d,t,is_left)
difference(){
  circle(d=d, $fn=res);
  circle(d=d-2*t, $fn=res);
  if(is_left){
    translate([0,-d/2])
    square([d,d]);
  }else{
    translate([-d,-d/2])
    square([d,d]);
  }
}