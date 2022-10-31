use <../libs/Round-Anything/MinkowskiRound.scad>;



p_h=35;
p_h_off=4;
p_h_inner=p_h-2*p_h_off;

p_inner_t=1.5;
profile_t=4;
profile_diff_t = profile_t - p_inner_t;
// profile_diff_t=3;

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
  minkowskiOutsideRound(rounding) 
  raw_w_profile();

  // bottom
  // translate([0,-d_1/2-screw_outer,0])
  // screw();

  //bottom_right
  translate([d_1/3-screw_outer/2,-d_1/2-screw_outer,0])
  screw();

  //top
  translate([0,d_1/2-screw_outer+screw_h*2,0])
  rotate([0,0,180])
  screw();


  //left
  translate([-d_1/2-screw_outer+profile_diff_t,0,0])
  rotate([0,0,-90])
  screw();

  //right
  translate([d_2/2+screw_outer-profile_diff_t,0,0])
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

module raw_w_profile(){
  difference(){
    translate([0,0,-rounding]) 
    linear_extrude(p_h+rounding) 
    raw();

    translate([0,0,p_h_off]) 
    linear_extrude(p_h_inner) 
    raw(d_1=d_1-profile_diff_t*2, d_2=d_2-profile_diff_t*2);
    
    translate([0,0,-rounding/2]) 
    cube([d_1*2,d_1*2,rounding],center=true);
  }
}

module raw(d_1=d_1,d_2=d_2){
  half_circle(d=d_1,t=profile_t, is_left=true);
  translate([0,(d_1-d_2)/2,0]) 
  half_circle(d=d_2,t=profile_t, is_left=false);
  extension(d_1,length=70);
}

module extension(d_1=d_1,length){
  translate([0,-d_1/2]) 
  square([length,profile_t]);
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
























// linear_extrude(height=10)
// example_1();
// example_2();
module example_1(){
r=1;
thickness=2;
loops=3;
 polygon(points= concat(
    [for(t = [90:360*loops]) 
        [(r-thickness+t/90)*sin(t),(r-thickness+t/90)*cos(t)]],
    [for(t = [360*loops:-1:90]) 
        [(r+t/90)*sin(t),(r+t/90)*cos(t)]]
        ));
}


module example_2(){
  r = 1;
thickness = 2;
loops = 3;

start_angle = 90;
end_angle = 360 * loops;

function spiral(r, t) = let(r = (r + t / 90)) [r * sin(t), r * cos(t)];

inner = [for(t = [start_angle : end_angle]) spiral(r - thickness, t) ];

outer = [for(t = [end_angle : -1 : start_angle]) spiral(r, t) ];

polygon(concat(inner, outer));
}

module profile(){



}