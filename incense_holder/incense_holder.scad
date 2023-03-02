use <../libs/openscad_xels_lib/simple_models.scad>;

t=3;

upper_r=99.9/2;
lower_r=33.3;
deg=66.6;
height=40;

l_count=128;
circle_fn=9;

stick_d=2;
stick_h=22.2;
stick_lower_d=30;
stick_upper_d=15;


bowl();
stick_holder();

module stick_holder(){
  translate([0,0,t])
  difference(){
    twisted_cylinder(r1=stick_lower_d/2, r2=stick_upper_d/2, h=stick_h, layers=64, fn=circle_fn, deg=-360/circle_fn);

    translate([0,0,stick_h-5])
    cylinder(d1=stick_d,d2=stick_upper_d,h=5,$fn=9);

    cylinder(h = stick_h, d = stick_d, $fn=32);
  }
}


module bowl(){
  difference(){
    twisted_cylinder(r1=lower_r, r2=upper_r, h=height, layers=l_count, fn=circle_fn, deg=deg);
    translate([0,0,t])
    twisted_cylinder(r1=lower_r-t, r2=upper_r-t, h=height-t, layers=l_count, fn=circle_fn, deg=deg);
  }
}