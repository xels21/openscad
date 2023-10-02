use <../libs/openscad_xels_lib/simple_models.scad>;

t=2;

lower_r = 33.3;
upper_r=99.9/2;
height=40;
// l_count= 32;
// l_count = 128;
l_count = 200;

deg=66.6;
circle_fn=9;

stick_d=2;
stick_h=height/2;
stick_lower_d=30;
stick_upper_d=15;
stick_h_helper = 4;


stick_holder_v2();



module stick_holder_v2(){
  lower_r = 15;
  upper_r=35;
  height=20;
  deg=80;

  difference(){
    bowl(lower_r = lower_r,upper_r = upper_r,height = height, deg=deg);
    translate([0,-upper_r,0]) 
    cube([upper_r,upper_r*2, height]);
  }
  
  scale([5,1,1])
  difference(){
    bowl(lower_r = lower_r,upper_r = upper_r,height = height, deg=deg);
    translate([-upper_r,-upper_r,0]) 
    cube([upper_r,upper_r*2, height]);
  }
  
  translate([0,0,t]) 
  difference(){
    translate([-7,0,-11]) 
    rotate([0, 45,0])
    stick_holder(stick_h=height*1.6);
    translate([0,0,-stick_lower_d/2]) 
    cube([stick_lower_d*2,stick_lower_d*2,stick_lower_d], center=true);
  }
}
module stick_holder_v1(){
  bowl();
  stick_holder();
}

module stick_holder(stick_h=stick_h){
  translate([0,0,t])
  difference(){
    twisted_cylinder(r1=stick_lower_d/2, r2=stick_upper_d/2, h=stick_h, layers=l_count/2, fn=circle_fn, deg=-360/circle_fn);
    cylinder(h = stick_h, d = stick_d, $fn=l_count/3);

    translate([0,0,stick_h-stick_h_helper])
    cylinder(d1=stick_d,d2=stick_upper_d,h=stick_h_helper,$fn=circle_fn);

    #cylinder(h = 200, d = stick_d, $fn=l_count/3);
  }
}


module bowl(lower_r = lower_r, upper_r=upper_r, height=height, l_count=l_count, deg=deg){
  // translate([]) 
  difference(){
    twisted_cylinder(r1=lower_r, r2=upper_r, h=height, layers=l_count, fn=circle_fn, deg=deg);
    twisted_cylinder(r1=lower_r-t, r2=upper_r-t, h=height, layers=l_count, fn=circle_fn, deg=deg);
  }

  cylinder(r1=lower_r, r2=lower_r+(upper_r-lower_r)/l_count, h=t, $fn=circle_fn);
}