use <../libs/openscad_xels_lib\pattern.scad>;
use <../libs/Round-Anything/MinkowskiRound.scad>;


raspberry_x=86;
raspberry_z=30;
raspberry_y=58;

raspberry_gap=3;

mos_fet_padding=4.5;
mos_fet_y_cable_gap=10-raspberry_gap;
mos_fet_x_screw=43;
mos_fet_x=mos_fet_x_screw+2*mos_fet_padding;
mos_fet_y_screw=51;
mos_fet_y=mos_fet_y_screw+2*mos_fet_padding;
mos_fet_z=30;

thickness=2;

stepper_y=35;
minus_y=0;

res=64;

y_raw=170;
x_raw=114;

y=y_raw-stepper_y;
x=x_raw;
z=44;

cap_thickness=2;
cap=thickness+2*cap_thickness;
hex_size=13;
hex_gap=5;

// case();
case_cover();
// translate([0,mos_fet_y_cable_gap,0])
// mos_fet();
// translate([mos_fet_x+2,mos_fet_y_cable_gap,0])
// mos_fet();
// translate([0,mos_fet_y+mos_fet_y_cable_gap+3,0])
// raspberry();

module case_cover(){
  tol=0.4;
  difference(){
    minkowskiOutsideRound(thickness/3)
    cube([x-thickness,y-2*thickness-tol,thickness-tol]);
    // translate([thickness*5,thickness*5,0])
    // cube([x-2*thickness-10*thickness-tol,y-thickness-10*thickness-tol,thickness-tol]);

    translate([thickness*5,thickness*5,0])
    pattern_hexagon(x_size=x-thickness-10*thickness ,y_size=y-2*thickness-tol-10*thickness, height=thickness-tol,hex_size=18, gap=5);
  }
}

module case(){

  case_cap();

  difference(){
    minkowskiOutsideRound(thickness)
    cube([x,y,z]);

    translate([0,0,z-cap])
    cube([x,y,cap]);


    //front pattern
    translate([4*thickness,0,z-cap-2*thickness])
    rotate([-90,0,0])
    pattern_hexagon(x_size = x-6*thickness, y_size = z-cap-4*thickness, hex_size=hex_size, gap=hex_gap, height=y);

    //side pattern
    translate([0,4*thickness,z-cap-2*thickness])
    rotate([0,90,0])
    pattern_hexagon(x_size = z-cap-4*thickness, y_size = y-6*thickness, hex_size=hex_size, gap=hex_gap, height=y);



    translate([thickness,thickness,thickness])
    minkowskiOutsideRound(thickness*4)
    cube([x-2*thickness,y-2*thickness,z+thickness*4]);
  }

  //raspberry
  translate([(x-2*thickness)/5+thickness,mos_fet_y+mos_fet_y_cable_gap+raspberry_gap,0])
  cube([(x-2*thickness)/5,thickness,z/2]);//-cap+cap_thickness]);

  translate([3*(x-2*thickness)/5+thickness,mos_fet_y+mos_fet_y_cable_gap+raspberry_gap,0])
  cube([(x-2*thickness)/5,thickness,z/2]);//-cap+cap_thickness]);

  //mosfet
  translate([thickness+mos_fet_padding+3,thickness+mos_fet_y_cable_gap+mos_fet_padding,thickness])
  mosfet();
  translate([x-thickness-mos_fet_padding-3-mos_fet_x_screw,thickness+mos_fet_y_cable_gap+mos_fet_padding,thickness])
  mosfet();
}

module mosfet(){

mosfet_screw();
translate([mos_fet_x_screw,0,0])
mosfet_screw();
translate([mos_fet_x_screw,mos_fet_y_screw,0])
mosfet_screw();
translate([0,mos_fet_y_screw,0])
mosfet_screw();

}

module mosfet_screw(){
  screw_h=8;
  screw_inner_d=2.3;
  screw_thickness=2;
  difference(){
    cylinder(d=screw_inner_d+2*screw_thickness, h=screw_h,$fn=res);
    cylinder(d=screw_inner_d, h=screw_h,$fn=res);
  }
}

module case_cap(){
difference(){
  translate([0,0,z-cap-thickness])
  minkowskiOutsideRound(thickness)
  cube([x,y,cap+thickness]);

  translate([0,thickness+cap_thickness,z-cap-thickness])
  cube([x-thickness-cap_thickness,y-2*thickness-2*cap_thickness,cap+thickness]);

  translate([0,thickness,z-cap+cap_thickness])
  cube([x-thickness,y-2*thickness,thickness]);
}
translate([0,0,z-cap])
cube([thickness,y,cap_thickness]);
}

module mos_fet(){
  cube([mos_fet_x,mos_fet_y,mos_fet_z]);
}

module raspberry(){
  cube([raspberry_x,raspberry_y,raspberry_z]);
}