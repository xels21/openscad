use <../libs/openscad_xels_lib/simple_models.scad>;

t=3;

upper_r=99.9/2;
lower_r=33.3;
deg=66.6;
height=40;

l_count=128;
// l_count=200;
circle_fn=9;

stick_d=2;
stick_h=height/2;
stick_lower_d=30;
stick_upper_d=15;
stick_h_helper = 4;


bowl();
stick_holder();

module stick_holder(){
  translate([0,0,t])
  difference(){
    twisted_cylinder(r1=stick_lower_d/2, r2=stick_upper_d/2, h=stick_h, layers=l_count/2, fn=circle_fn, deg=-360/circle_fn);

    translate([0,0,stick_h-stick_h_helper])
    cylinder(d1=stick_d,d2=stick_upper_d,h=stick_h_helper,$fn=circle_fn);

    cylinder(h = stick_h, d = stick_d, $fn=l_count/3);
  }
}


module bowl(){
  difference(){
    twisted_cylinder(r1=lower_r, r2=upper_r, h=height, layers=l_count, fn=circle_fn, deg=deg);
    twisted_cylinder(r1=lower_r-t, r2=upper_r-t, h=height, layers=l_count, fn=circle_fn, deg=deg);
  }
  cylinder(r=lower_r, h=t, $fn=circle_fn);
}