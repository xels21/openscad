// include <../libs/Round-Anything/MinkowskiRound.scad>;
include <../libs/openscad_xels_lib/round.scad>

thickness=2;
// lense_d_wt=thickness+lense_d+thickness
lense_d=19;
lense_d_inner=15;
lense_depth=4;
padding=4;
depth=20;

r_outer=2;

res=128;

x_max = padding+lense_d+lense_d+padding;
z_max = padding+lense_d+thickness;
y_max = thickness+depth+thickness;


lense_x_max = 2*thickness+ 2*lense_d;
lense_y_max = lense_depth;
lense_z_max = padding+lense_d+lense_d/2;
lense_translate=[-lense_x_max/2,-lense_y_max,-lense_d/2-lense_d/2];//-lense_z_max + lense_d/2+ thickness];

// translate(lense_translate)
// difference(){



all();

module all(){
  difference(){
    case();
    inner_camera();

    cable=6;
    translate([x_max/6,y_max/2,-z_max/2-2*cable])
    rounded_cube_x([x_max,y_max,4*cable], r=cable*0.999, fn=res);
  }
}
module inner_camera(){
  translate(lense_translate)
  translate([thickness,thickness,-thickness])
  rounded_cube_x(size=[2*lense_d, lense_y_max, lense_z_max-thickness], r=lense_d/2, center=false, fn=res);

  translate([lense_d/2,0,0])
  rotate([90,0,0])
  cylinder(d=lense_d_inner,h=lense_y_max, $fn=res);
}

module case(){
  translate([0,0,-lense_d/2])
  difference(){
    // minkowskiOutsideRound(r_outer)
    translate([-x_max/2,0,0])
    rounded_cube_z([x_max,y_max,z_max], r=thickness);

    translate([-x_max,thickness,-thickness])
    cube([2*x_max,depth,z_max]);
  }


  translate(lense_translate)
  difference(){
    rounded_cube_x(size=[lense_x_max, lense_y_max, lense_z_max],  r=lense_d/2, center=false, fn=res);
    cube([lense_x_max, lense_y_max, lense_d/2]);
  }
}
// rounded_cube_z([x_max,y_max,z_max]);