use <..\..\libs\Round-Anything\MinkowskiRound.scad>;

base_h=3;
top_h=12;

screw_d=5;
screw_padding=2.5;

base_x=screw_d+2*screw_padding;
base_y=20;

mount_x=6;
mount_y=10;

difference(){
  minkowskiOutsideRound(1)
  union(){
    cube([base_x,base_y,base_h]);
    translate([1,0,0])
    cube([base_x-2.4,mount_y,base_h+2]);
  }
  translate([screw_padding+screw_d/2,mount_y+screw_d/2+screw_padding ,0])
  cylinder(d=screw_d,h=base_h,$fn=64);
}

intersection(){
  translate([1,0,top_h+base_h])
  translate([12.3,-0.7,-42.5])
  rotate([0,90,0])
  import_stl("4.stl", convexity = 5);

  cube([50,50,top_h+base_h]);
}