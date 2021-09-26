use <..\libs\Round-Anything\MinkowskiRound.scad>;

spoke_b_raw = 3.4;
tol = 0.1;
spoke_b = spoke_b_raw+tol;

spoke_d=2.1;

spoke_h=7;



thick_d_1 = spoke_b + 10;
thick_d_2 = spoke_b + 20;


l_1 = 4;
l_2 = 8;

rad = 2.8;

difference(){
  outer();
  inner();
}

module outer(){
  minkowskiOutsideRound(rad,1)
  union(){
    cylinder(d=thick_d_1,h=l_1+l_2,$fn=32);
    translate([0,0,l_1])cylinder(d=thick_d_2,h=l_2,$fn=10);
  }
}

module inner(){
  union(){
    translate([-spoke_d/2,0,0])cube([spoke_d,thick_d_2,l_1+l_2]);
    cylinder(d=spoke_d, h=l_1+l_2, $fn=32);

    translate([0,0,spoke_h/2]) rotate([0,0,45]) cube([spoke_b,spoke_b,spoke_h],center=true);
    cylinder(d2=spoke_d, d1=spoke_b+2, h=1, $fn=16);
  }
}