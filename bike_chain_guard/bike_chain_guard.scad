use <../libs/openscad_xels_lib/round.scad>;
use <../libs/openscad_xels_lib\helper.scad>;

outer_d = 165;
inner_d=87;
screw_gap=103;
d_gap=20;
screw_d=10.5;
screw_h=11;
screw_d_1=14;
screw_h_1=2;
screw_d_2=18;
screw_d_3=40;
screw_h_3=14.5;
h=18;

pedal_l = 45;

rad=10;
res=128;


all();
// optic_diff_all();


module all(){
  difference(){
    case();
    all_screws();
    optic_diff_all();
    pedal();
    twenty_one_ring();
  }
}

module twenty_one_ring(){
  count = 40;
  depth=0.4;
  for(i=[0:count]){
      translate([sin(i/count*360)*outer_d*0.465
              ,cos(i/count*360)*outer_d*0.465
              ,0]) 
  rotate([0,0,-i/count*360])
  translate([0,0,h-depth])
  scale([d_gap/2,d_gap/2,1])
  translate([-0.4,-0.5,0])
  linear_extrude(1)
  twenty_one();
}
}

module optic_diff_all(){
  for(i=[0:4]){
  translate([sin((i+0.5)/4*360)*screw_gap*.4
            ,cos((i+0.5)/4*360)*screw_gap*.4
            ,0]) 
  cylinder(d=screw_gap*.45,h=h,$fn=res);
  }
}
// screw();
module pedal(){
  // cube([45,outer_d,h]);
  rotate([0,0,45])
  translate([-45/2,0,10])
  rounded_cube_x([45,outer_d,h*2],r=5,center=false);
}


module all_screws(){
  for(i=[0:4]){
    translate([sin(i/4*360)*screw_gap/2
              ,cos(i/4*360)*screw_gap/2
              ,0]) 
    // rotate([0,0,i/4*360 + 90])
    screw();
  }
}

module screw(){
  cylinder(d=screw_d,h=screw_h,$fn=res);
  translate([0,0,screw_h-screw_h_1])
  cylinder(d=screw_d_1,h=screw_h_1,$fn=res);
  translate([0,0,screw_h])
  cylinder(d=screw_d_2,h=h,$fn=res);
  translate([0,0,screw_h_3])
  cylinder(d=screw_d_3,h=h,$fn=res);
}

module case(){
  difference(){
    rotate_extrude($fn=res)
    offset(-rad)
    offset(rad)
    polygon(points=[
      [inner_d/2,0],
      [inner_d/2,screw_h],
      [inner_d/2 + screw_d_2-screw_d_1/2,screw_h],
      [outer_d/2 - d_gap/2,h],
      [outer_d/2,h],
      [outer_d/2,screw_h],
      [outer_d/2-d_gap/2,screw_h],
      [inner_d/2 + screw_d_2,0]
      ]
    );
  }
}