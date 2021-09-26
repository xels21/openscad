use <../libs/openscad_xels_lib\round.scad>;


cable_d=5;
screw_d=3;
screw_d_x_tol=1;
screw_center_distance = 15.5;
// screw_distance_max=34.5;
// screw_distance_min=28;

padding_y=3;
padding_x=4;

thickness=1;

cable_h=15;

module cable_inner(){
  translate([0,0,-(padding_y+screw_d+padding_y)/2])
  union(){
    translate([-(cable_d)/2,0,0])
    cube([cable_d,cable_d/2+thickness,cable_h+(padding_y+screw_d+padding_y)/2]);
    cylinder(d=cable_d,h=cable_h+(padding_y+screw_d+padding_y)/2,$fn=32);
  }
}


module cable_outer(){
  translate([0,0,-(padding_y+screw_d+padding_y)/2])
  union(){
    translate([-(cable_d+thickness*2)/2,0,0])
    cube([cable_d+thickness*2,cable_d/2+thickness,cable_h+(padding_y+screw_d+padding_y)/2]);
    cylinder(d=cable_d+thickness*2,h=cable_h+(padding_y+screw_d+padding_y)/2,$fn=32);
  }
}

difference() {
  union(){
    rounded_cube_x([padding_x+screw_center_distance*2+screw_d+padding_x,
                thickness,
                padding_y+screw_d+padding_y,]
                r=4, center=true);
    translate([0,-(cable_d/2+thickness/2),0])
    cable_outer();
    }
    
    translate([0,-(cable_d/2+thickness/2),0])
    cable_inner();

    translate([-screw_center_distance,0,0])
    screw(d=screw_d,tol_x=screw_d_x_tol);

    translate([screw_center_distance,0,0])
    screw(d=screw_d,tol_x=screw_d_x_tol);
}

module screw(d,tol_x,h=100){
  translate([0,h/2,0])
  rotate([90,0,0])
  union(){
    translate([0,0,h/2])
    cube([tol_x,d,h],center=true);

    translate([-tol_x/2,0,0])
    cylinder(d=d,h=h,$fn=32);

    translate([tol_x/2,0,0])
    cylinder(d=d,h=h,$fn=32);
  };
}