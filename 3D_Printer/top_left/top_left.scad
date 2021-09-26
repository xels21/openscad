/*
Requirements:
- bearing
- cable chain
- bowden
- (screw)
- (bowden distance)
- (bowden dyn height)
*/

use <../3D_fillament_sensor/3D_fillament_sensor.scad>
include <../3D_fillament_sensor/3D_fillament_sensor.scad> // to use inner_sensor_d

h=8.0;
thickness=3;
res=64;

guide_r=11;

template_wo_gear();
// template();
// cable_chain();
// guide1();
// guide2();
// guide3();
// bowden_mount(true);

// bowden_mount_raw();

bowden_x=45;
bowden_y=48;
bowden_z=46;

sensor_off=3;

module sensor_mount(){
  sensor_z_off=9;
  sensor_x_off=-18;

  translate([bowden_x+sensor_x_off,0,bowden_z+inner_sensor_d/2+sensor_z_off])
  rotate([0,90,-90])
  translate([-left_sensor,0,0])
  gen_sensor();

  // translate([bowden_x+sensor_x_off,0,bowden_z+inner_sensor_d/2+sensor_z_off])
  // rotate([0,90,-90])
  // sensor();
}

module bowden_mount(with_sensor = true){
  translate([29,16,h])
  rotate([0,0,180])
  bowden_mount_raw(with_sensor);
  
}

module bowden_mount_raw(with_sensor = true){
  bowden_mount_raw_x=45;
  bowden_mount_raw_y=48;
  bowden_mount_raw_z=46;
  bowden_mount_raw_t=3;
  difference(){
    union(){
      import("../Nema_17_support_for_Geeetech_I3_Acrylic/files/Gearbox_holder.STL", convexity = 5);
      // translate([0,44,0])
      cube([45,bowden_mount_raw_t,46]);
    }
    translate([0,48,0])
    cube([45,50,100]);
  }
  if(with_sensor){
    sensor_mount();
  }
}



module template(){
  translate([0,0,-19])
  import("Geeetech_prusa_i3_pro_B_z-axis_top_mounts/files/Geeetech_top_mount_left.stl", convexity = 5);
}


module template_wo_gear(){
  difference(){
    union(){
      translate([15,61,-19])
      import("Geeetech_prusa_i3_pro_B_z-axis_top_mounts/files/Geeetech_top_mount_left.stl", convexity = 5);
      cylinder(r=15, h=8, $fn=128);
    }
    cylinder(r=11.5, h=100, $fn=64);
  }
}

module guide1(){
  translate([-30,0,0])
  difference(){
    cylinder(r=guide_r+thickness, h=h, $fn=res);
    cylinder(r=guide_r, h=h, $fn=res);
    translate([0,0,h/2])
    rotate([0,0,30])
    cube([5,(guide_r+thickness)*2,h],center=true);
  }
}

module guide2(){
  difference(){
    translate([-30,-10,h])
    rotate([90,0,0])
    difference(){
      cylinder(r=guide_r+thickness, h=h, $fn=res);
      cylinder(r=guide_r, h=h, $fn=res);
      translate([0,0,h/2])
      cube([5,(guide_r+thickness)*2,h],center=true);
    }
    translate([0,0,-100])
    cube([200,200,200],center=true);
  }
}

module guide3(){
  difference(){
    translate([-27,-37,h])
    rotate([90,0,45])
    difference(){
      cylinder(r=guide_r+thickness, h=h, $fn=res);
      cylinder(r=guide_r, h=h, $fn=res);
      translate([0,0,h/2])
      cube([5,(guide_r+thickness)*2,h],center=true);
    }
    translate([0,0,-100])
    cube([200,200,200],center=true);
  }
}

module cable_chain(){
  translate([-15.85,-55,5.5])
  union(){
    translate([2.6,17.5,0])
    cube([13,5.5,13.2]);
    difference(){
      cable_chain_raw();
      cube([10.5,50,50]);
    }
  }
}

module cable_chain_raw(){
  translate([13.2,11.3,0])
  rotate([0,0,-90])
  import("../../../Cable_Chain/CableChain.stl");
}

// module cable_chain_raw(){
//   translate([69.5,64,13.5])
//   rotate([0,180,90])
//   import("../../../Cable_Chain/cable_chain_clipped.stl");
// }