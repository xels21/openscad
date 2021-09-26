use <../libs/openscad_xels_lib\pattern.scad>;

// translate([49,310,-42])
// translate([610.5,-117,-43.5])
// import(".\\files\\Cover_GT_2560_part_8.stl");  

x1=35.4;
y1=30.4;

x_max = 112;
y_max = 139;

padding = 4;
screw_d=3;

height=3;
// height=2;
res=64;

fan_screw_d=4.2;
fan_screw_gap=71;
fan_d=80;

difference(){

  linear_extrude(height)
  polygon(points=[
    [0,0],
    [0,y1],
    [x1,y_max],
    [x_max,y_max],
    [x_max,0],
  ]);
// cube([5,5,5]);

translate([0,0,height-0.3])
pattern_hexagon(x_size = x_max, y_size = y_max, hex_size=15, gap=3, height=height);

  translate([padding,padding,0])
  cylinder(h=height,d=screw_d,$fn=res);

  translate([x1+padding,y_max-padding,0])
  cylinder(h=height,d=screw_d,$fn=res);

  translate([x_max-padding,y_max-padding,0])
  cylinder(h=height,d=screw_d,$fn=res);

  translate([x_max-padding,padding,0])
  cylinder(h=height,d=screw_d,$fn=res);


  translate([64,52,0])
  union(){
    intersection(){
      hex_size=24;
      cylinder(h=height,d=fan_d,$fn=res);
      translate([-fan_d/2,-fan_d/2-hex_size/5,0])
      pattern_hexagon(x_size = fan_d+hex_size, y_size = fan_d+hex_size, hex_size=hex_size, gap=2, height=height);
    }
    translate([fan_screw_gap/2,fan_screw_gap/2])
    cylinder(h=height,d=fan_screw_d,$fn=res);

    translate([-fan_screw_gap/2,fan_screw_gap/2])
    cylinder(h=height,d=fan_screw_d,$fn=res);

    translate([fan_screw_gap/2,-fan_screw_gap/2])
    cylinder(h=height,d=fan_screw_d,$fn=res);

    translate([-fan_screw_gap/2,-fan_screw_gap/2])
    cylinder(h=height,d=fan_screw_d,$fn=res);
  }


}
