finger_d1 = 12;
finger_d2 = 16;

finger_h_upper=12;
finger_h = 19.5;


res=64;

difference(){
  scale(0.45)
  translate([53,-122,144])
  rotate([18,195,-36])
  import("Hand_Circle_150mm.stl", convexity = 2);

  // cube([1,1,1]);

  scale([finger_d2,finger_d1, 1])
  union(){
    cylinder(d=1, h=finger_h, $fn=res);

    translate([0,0,finger_h])
    scale([1,1, finger_h_upper])
    sphere(r=0.5, $fn=res);
  }
}