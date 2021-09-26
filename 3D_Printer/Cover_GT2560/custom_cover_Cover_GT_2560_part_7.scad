use <../libs/openscad_xels_lib\pattern.scad>;
use <../libs/Round-Anything/MinkowskiRound.scad>;



x1=35.4;
y1=31.6;

x_max_old = 113;
x_max_off=14;
x_max = 112.4-x_max_off;

y_max_old = 140.2;
y_off=2;
// y_off=0;
// y_max_off=2;
y_max_off=0;
y_max=y_max_old-y_off-y_max_off;

padding = 4;
screw_d=3;

height=3;
// height=5;
// height=2;
res=64;

fan_screw_d=4.2;
fan_screw_gap=70;
fan_d=80;

case_thickness=2;

  slider_height=2;
  slider_depth=2;
  slider_thickness=2;


// slider();
// plate();
top();


module top(){
  tol=0.2;
  top_h=21;
  rad=2;



  fan_screw_d=4.2;
  fan_screw_gap=71;
  fan_d=80;

    raw_point = [
    [0,0],
    [0,y1],
    [x1,y_max],
    [x_max,y_max],
    [x_max,0],
  ];
  difference(){
    union(){
  linear_extrude(top_h+case_thickness)
  offset(case_thickness-tol)
  polygon(points=raw_point);




translate([x_max+(case_thickness-tol),-(case_thickness-tol),0])
rotate([-90,0,0])
rotate([0,0,270])
linear_extrude(y_max+2*(case_thickness-tol))
polygon(points=[[0,0],[0,slider_height-tol],[slider_depth-tol,0]]);

translate([x1-(case_thickness-tol),y_max+(case_thickness-tol),0])
rotate([0,90,0])
rotate([0,0,90])
linear_extrude(x_max-x1+2*(case_thickness-tol))
polygon(points=[[0,0],[0,slider_height-tol],[slider_depth-tol,0]]);

translate([-(case_thickness-tol),-(case_thickness-tol),0])
rotate([0,90,0])
rotate([0,0,180])
linear_extrude(x_max+2*(case_thickness-tol))
polygon(points=[[0,0],[0,slider_height-tol],[slider_depth-tol,0]]);



  }
  translate([0,0,-rad])
  minkowskiOutsideRound(rad)
  linear_extrude(top_h+rad)
  polygon(points=raw_point);

translate([x1+(x_max-x1)/2,y_max+case_thickness*2,top_h/3*2])
union(){
rotate([90,0,0])
cylinder(h=case_thickness*3,d=13,$fn=6);
translate([-2.5,-case_thickness*3,-(top_h/3*2)])
cube([5,case_thickness*3,top_h/3*2]);
}

  translate([-case_thickness,-case_thickness,top_h+case_thickness-0.2])
  pattern_hexagon(x_size = x_max+2*case_thickness, y_size = y_max+2*case_thickness, hex_size=10, gap=2, height=height);

  translate([56,49,top_h-0.5])
  union(){
    intersection(){
      hex_size=24;
      cylinder(h=case_thickness+1,d=fan_d,$fn=res);
      translate([-fan_d/2,-fan_d/2-hex_size/5,0])
      pattern_hexagon(x_size = fan_d+hex_size, y_size = fan_d+hex_size, hex_size=hex_size, gap=2, height=case_thickness+1);
    }
    translate([fan_screw_gap/2,fan_screw_gap/2])
    cylinder(h=case_thickness+1,d=fan_screw_d,$fn=res);

    translate([-fan_screw_gap/2,fan_screw_gap/2])
    cylinder(h=case_thickness+1,d=fan_screw_d,$fn=res);

    translate([fan_screw_gap/2,-fan_screw_gap/2])
    cylinder(h=case_thickness+1,d=fan_screw_d,$fn=res);

    translate([-fan_screw_gap/2,-fan_screw_gap/2])
    cylinder(h=height,d=fan_screw_d,$fn=res);
  }

  }



}

module slider(  slider_height=2,
  slider_depth=2,
  slider_thickness=2){
  /*
    ____  
  /   /  
/   /    


  */
  


translate([-slider_thickness,0,0])
      polygon(points=[
      [0,0],
      [slider_depth,slider_height],
      [slider_depth+slider_thickness,slider_height],
      [slider_thickness,0],
      ]);



}
module plate(){

inner_trans_x = 11;
inner_trans_y = 23.6;
inner_trans_z = 0;



translate([inner_trans_x,inner_trans_y+y_off-slider_depth-case_thickness,height])
rotate([90,0,90])
linear_extrude(x_max+slider_thickness+case_thickness)
slider(  slider_height=slider_height,
  slider_depth=slider_depth,
  slider_thickness=slider_thickness);

// translate([inner_trans_x,inner_trans_y-slider_depth,height])
translate([x_max+inner_trans_x+slider_thickness+case_thickness,y_max+inner_trans_y+y_off+slider_depth+case_thickness,height])
rotate([90,0,-90])
linear_extrude(x_max-x1+slider_thickness+case_thickness)
slider(  slider_height=slider_height,
  slider_depth=slider_depth,
  slider_thickness=slider_thickness);

// translate([x_max+inner_trans_x+slider_thickness*2,y_max+inner_trans_y+slider_depth+case,height])
translate([x_max+inner_trans_x+slider_thickness+case_thickness,inner_trans_y-slider_thickness-case_thickness+y_off,height])
rotate([90,0,180])
linear_extrude(y_max+slider_thickness*2+2*case_thickness)
slider(  slider_height=slider_height,
  slider_depth=slider_depth,
  slider_thickness=slider_thickness);


// translate([inner_trans_x+x_max+2,inner_trans_y-slider_thickness,height])
// cube([slider_thickness,y_max+2*slider_thickness,slider_height/2]);



difference(){
  union(){
    translate([49,310,-42])
    import(".\\files\\Cover_GT_2560_part_7.stl");  

    translate([inner_trans_x,inner_trans_y,inner_trans_z])
    linear_extrude(height)
    polygon(points=[
      [0,0],
      [0,y1],
      [x1,y_max_old],
      [x_max_old,y_max_old],
      [x_max_old,0],
    ]);
  }
  translate([inner_trans_x,inner_trans_y+y_off,inner_trans_z])
  linear_extrude(height)
  polygon(points=[
    [0,0],
    [0,y1],
    [x1,y_max],
    [x_max,y_max],
    [x_max,0],
  ]);

translate([130,32,0])
cube([40,3,height]);


}

// difference(){
}