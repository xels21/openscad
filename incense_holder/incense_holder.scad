use <../libs/openscad_xels_lib/simple_models.scad>;

t=3;

upper_r=70;
lower_r=40;
deg=66.6;
height=50;

l_count=128;
circle_fn=9;

stick_d=2;
stick_h=30;
stick_lower_d=30;
stick_upper_d=15;


bowl();
stick_holder();

module stick_holder(){
  translate([0,0,t])
  difference(){
    union(){
     cylinder(d1=stick_lower_d, d2=stick_upper_d, h=stick_h-(stick_upper_d/2), $fn=64);
     translate([0,0,stick_h-(stick_upper_d/2)])
     sphere(r = stick_upper_d/2, $fn=64);

    }
    translate([0,0,stick_h])
    sphere(r = stick_upper_d/4, $fn=8);

    cylinder(h = stick_h, d = stick_d, $fn=32);
  }
}


module bowl(){
  difference(){
    twisted_circle(start_r=lower_r, end_r=upper_r, h=height, layers=l_count, fn=circle_fn, deg=deg);
    translate([0,0,t])
    twisted_circle(start_r=lower_r-t, end_r=upper_r-t, h=height-t, layers=l_count, fn=circle_fn, deg=deg);
  }
}