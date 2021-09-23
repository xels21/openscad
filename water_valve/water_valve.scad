include <../libs/Round-Anything/MinkowskiRound.scad>;


outer_d=8;
inner_d=6;
h1=4;
h2=3;
h_max=h1+h2;

cylinder_d=20;
cylinder_offset=14;
cylinder_inner_fac=1.5;

res=16;

count = 4;

difference(){
  outer();
  inner();
}

module inner(){
  intersection(){
    cube([inner_d,outer_d*2,h_max*2],center=true);
    union(){
      cylinder(d=outer_d,h=h1,$fn=res*2);
      cylinder(d=inner_d,h=h_max,$fn=res*2);
    }
  }
}

module outer(){
  minkowskiOutsideRound(2,1)
  union(){
    cylinder(h=h_max,d=cylinder_d*cylinder_inner_fac,$fn=res);

    for (i=[1:count]) {
      translate([sin(360*i/count)*cylinder_offset, cos(360*i/count)*cylinder_offset, 0 ])
      cylinder(h=h_max,d=cylinder_d,$fn=res);
    }
  }
}