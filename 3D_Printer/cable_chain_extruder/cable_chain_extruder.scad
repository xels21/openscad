use <../../libs/openscad_xels_lib/round.scad>;
use <../3D_fillament_sensor/3D_fillament_sensor.scad>;

chain_x=13.5;
chain_z=22.4;

thickness_side=2;
thickness_other=4.5;
thickness=3;

h_z_clip=2.4;

// rounded_cube_z([10,30,50], r=2);
// rounded_cube_x([10,30,50], r=2);
// rounded_cube_y([10,30,50], r=2);

// rounded_cube();
// left_side();
// cable_chain_left();

// gen_sensor();
// right_side(with_sensor=true);
rotate([-90,0,0])
right_side(with_sensor=false);
// cable_chain();

module right_side(with_sensor=false){
  sensor_y=25-thickness;

  if(with_sensor){
    translate([0,-sensor_y,0])
    rotate([0,0,90])
    sensor_mount_norm();
  }

  screw_gap = 30;
  screw_x_off=6;
  screw_y_off=3;
  screw_r=1.7;

  mount_gap=8;

  cable_chain_y=0;

  x_mount_ges=2*screw_x_off+2*screw_r+screw_gap;
  z_mount_ges=2*screw_y_off+2*screw_r;

  difference(){
    union(){
      translate([-x_mount_ges/2,0,-z_mount_ges/2])
      rounded_cube_x([x_mount_ges,thickness,z_mount_ges], r=1);

      translate([x_mount_ges/2-chain_x,0,0])
      rounded_cube_x([chain_x,thickness,chain_z+mount_gap], r=1);
    }

    rotate([-90,0,0])
    translate([-screw_gap/2,0,0])
    cylinder(r=screw_r,h=thickness, $fn=64);

    rotate([-90,0,0])
    translate([screw_gap/2,0,0])
    cylinder(r=screw_r,h=thickness, $fn=64);

  }

  translate([x_mount_ges/2-chain_x,-cable_chain_y,mount_gap])
  difference(){
    cable_chain_right(cable_chain_y);
    translate([0,4,4.15])
    rounded_cube_y([cable_chain_y,cable_chain_y-6,cable_chain_y-6], r=6);
  }
}

module cable_chain_right(y=50){ 
  difference(){
    union(){
      difference(){
        translate([chain_x,0,0])
        rotate([0,0,180])
        cable_chain();
        // cylinder(d=10,h=100);
        translate([0,0,-1])
        cube([100, 100, 100]);
      }
      rounded_cube_x([chain_x,y,chain_z], r=1);
    }
    translate([thickness_side,0,thickness_other])
    rounded_cube_x([chain_x-2*thickness_side,y,chain_z-2*thickness_other], r=3);
  }
}



module left_side(){
  block_x=50;
  block_y=20;
  block_z=2.5;

  screw_r=1;
  screw_off=4;
  screw_gap=9;

  difference(){
    union(){
      translate([0,3,0])

      translate([0,0,block_z-h_z_clip])
      cable_chain_left(7);

      translate([0,-block_y/2,0])
      rounded_cube_z([block_x+chain_x,block_y,block_z], r=2);
    }
    translate([block_x+chain_x-screw_off,screw_gap/2,0])
    cylinder(r=screw_r,h=block_z, $fn=64);

    translate([block_x+chain_x-screw_off,-screw_gap/2,0])
    cylinder(r=screw_r,h=block_z, $fn=64);
  }
}

module cable_chain_left(y=50){ 
  difference(){
    union(){
      difference(){
        cable_chain();
        cube([100, 100, 100]);
      }
      cube([chain_x, y, chain_z]);
    }
    translate([thickness_side,0,thickness_other])
    rounded_cube_x([chain_x-2*thickness_side,y,chain_z-2*thickness_other], r=3);
  }
}

module cable_chain(with_infill=true){
  if(with_infill){
    translate([6.9,6.8,4.7])
    union(){
      h=13;
      d=12.7;
      cylinder(d=d,h=h, $fn=40);
      translate([-d/2,-d/2,0])
      cube([d,d/2,h]);
    }
  }
  translate([0,0,11.2])
  rotate([90,90,90])
  import("../../models/Cable_Chain/CableChain.stl",convexity=10);  
}

