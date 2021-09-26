use <../libs/Round-Anything/MinkowskiRound.scad>;

d=7;
d_h1=5;
d_h1_d_plus=1.5;
d_h2=10;

length=25;

d1=18;
d2=8;

lever_h=10;

res=32;

thickness=4;
d_h_max = d_h2+thickness;

minkowskiRound(thickness/3)
translate([0,0,-.12])
union(){
lever();
plate();
}
stick_round();
stick_additional();

module stick_additional(){
  translate([0,0,-(d_h1+d_h1_d_plus)])
  cylinder(d2=d+d_h1_d_plus, d1=d,h=d_h1_d_plus, $fn=res);

  minkowskiOutsideRound(1)
  translate([-2.5,-7,-d_h_max])
  cube([5,7,thickness]);
}

module stick_round(){
  translate([0,0,-d_h_max])
  cylinder(d=d,h=d_h_max,$fn=res);
}

module lever(){
translate([0,thickness/2,thickness])
  rotate([90,0,0])
  linear_extrude(thickness)
  polygon(points=[
    [-d1/2+2,0],
    [length,lever_h],
    [length+d2/2-2,0],
  ]);
  }

module plate(){
  cylinder(d=d1,h=thickness,$fn=res);
  translate([length,0,0])
  cylinder(d=d2,h=thickness,$fn=res);
  linear_extrude(thickness)
  polygon(points=[
    [0,d1/2],
    [length,d2/2],
    [length,-d2/2],
    [0,-d1/2],
  ]);
}