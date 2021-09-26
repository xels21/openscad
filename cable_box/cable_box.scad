use <../libs/openscad_xels_lib\round.scad>;

cable_d1 = 15;
cable_d2 = 2;
cable_d_gap = 15;

row_count = 2;
col_count = 3;

cable_margin = 10;

thickness=1.5;

rad = 15;

res=64;

z_plus = 7;

desk_holder_thickness = 3;
desk_holder_tol=0.2;
desk_holder_offset = 12;
desk_holder_d = 10;

x_max = 2 * thickness + (col_count)*(max(cable_d1,cable_d2)+cable_margin) - cable_margin + rad;
y_max = 2 * thickness + 2*rad + 25;
z_max = thickness+row_count*((cable_d1 + cable_d2)/2 + cable_d_gap) + z_plus;

// cable_hole();
// box_down();
// box_cap();
desk_holder();

module desk_holder(){
  desk_span = 1;
  desk_height = 29.5;

  desk_helper = 3;
  desk_l = 25;

  /*

  ,:#:,
 --  --
 _| |
 \  |
  | |
  | |,,,---```|
  |__,,,---```

  */

linear_extrude((x_max-thickness)/3)
union(){  polygon(points=[
    [0,0],

    [0,-desk_helper+ desk_holder_thickness + desk_height],
    [-desk_helper,desk_holder_thickness + desk_height],
    [0,desk_holder_thickness + desk_height],
    [0,desk_holder_thickness + desk_height + thickness + desk_holder_tol],
    [desk_holder_thickness,desk_holder_thickness + desk_height + thickness + desk_holder_tol],
    [desk_holder_thickness,desk_holder_thickness + desk_height],
    [desk_holder_thickness,desk_holder_thickness],
    [desk_holder_thickness + desk_l,desk_holder_thickness + desk_span],
    [desk_holder_thickness + desk_l - desk_span,desk_span],
    [desk_holder_thickness,0],
    ] 
  );

  translate([desk_holder_thickness/2,desk_holder_thickness + desk_height + thickness + desk_holder_tol,0])
  difference(){
    circle(d=desk_holder_d,$fn=res);
    translate([-desk_holder_d/2,-desk_holder_d])
    square(desk_holder_d);
  }}
}

module box_cap(){
  cap_tol=0.3;

  translate([0,0,3])
  rounded_cube_z([x_max,y_max,2], r=rad, center=false);
  
  translate([thickness+cap_tol/2,thickness+cap_tol/2,0])
  rounded_cube_z([x_max-2*thickness-cap_tol,y_max-2*thickness-cap_tol,3], r=rad-thickness-cap_tol/2, center=false);
}

module box_down(){
  difference(){
    rounded_cube_z([x_max,y_max,z_max], r=rad, center=false);
    
    translate([thickness,thickness,thickness])
    rounded_cube_z([x_max-2*thickness,y_max-2*thickness,z_max-thickness], r=rad-thickness, center=false);

    translate([0,thickness+ desk_holder_offset - desk_holder_tol/2,0])
    cube([x_max-thickness,desk_holder_thickness+desk_holder_tol,thickness]);

    translate([0,thickness+ desk_holder_offset+(desk_holder_thickness+desk_holder_tol)/2,thickness])
    rotate([0,90,0])
    difference(){
      cylinder(h=thickness,d=desk_holder_d+desk_holder_tol, $fn=res);
      translate([0,-(desk_holder_d+desk_holder_tol)/2,0])
      cube([desk_holder_d+desk_holder_tol,desk_holder_d+desk_holder_tol,thickness]);
    }

      for (i_col =[0:col_count-1]){
        for (i_row =[0:row_count-1]){
          if ((i_row % 2)!=1){
            cable_hole_looper(i_row=i_row,i_col=i_col);
          } 
          if ((i_row % 2)==1 && (i_col != col_count-1) ){
            translate([((cable_d1 + cable_d2)/2 + cable_d_gap)/2,0,i_row * (cable_d1 + cable_d2)/2 + cable_d_gap])
            cable_hole_looper(i_row=i_row,i_col=i_col);
          } 
          // Even(); else Odd();
        }
      }
  }
}

module cable_hole_looper(i_row=1,i_col=1){
          translate([i_col*(max(cable_d1,cable_d2)+cable_margin),0,0])
          translate([0,y_max,0])
          translate([max(cable_d1,cable_d2)/2 + thickness + rad/2 ,0,cable_d_gap+min(cable_d1,cable_d2)/2 + thickness])
          rotate([90,90,0])
          cable_hole(height=y_max);
}

module cable_hole(height=thickness){
  cylinder(d=cable_d1, h=height,$fn=res);
  translate([cable_d_gap,0,0])
  cylinder(d=cable_d2, h=height,$fn=res);
  linear_extrude(height)
  polygon(points=[
    [0,cable_d1/2],
    [cable_d_gap,cable_d2/2],
    [cable_d_gap,-cable_d2/2],
    [0,-cable_d1/2],
    ]);
  
}