// include <parameter.scad>
// use <parameter.scad>

use <..\..\libs\Round-Anything\MinkowskiRound.scad>;


plexi_t=3.85;

plexi_holder_h=10;
plexi_holder_inner_h_off=2;
plexi_holder_t=2;


screw_r1=1;
screw_r2=3;
screw_r_t=2;
screw_r_off=1.5;
screw_h=2.5;

side_corr=0; //needs to be ckecked

ikea_inner_w=456;

res=32;
only_screw=(screw_r2+screw_r_t)*2;
// gen_holder( only_screw, true);

abs_h=plexi_holder_h+plexi_holder_t;
echo(abs_h);
offset=10;

ide_corr=0;
upper_corr=0;


upper_l_raw=450;
side_l_raw=440;
upper_l = upper_l_raw/2-offset-abs_h-upper_corr;
echo(upper_l);
side_l=side_l_raw/2-side_corr-plexi_holder_t;
echo(side_l);


// gen_holder(292/2, plexi_holder_inner_h_off=0);
// gen_holder(208, plexi_holder_inner_h_off=0);
// door_upper();
// door_bottom();
side_all();
module side_all(){
translate([-220,60,0])
bottom();
translate([0,60,0])
upper();
side_upper_right();
translate([-10,0,0])
side_upper_left();
translate([0,40,0]){
  side_botom_left();
  translate([-10,0,0])
  side_botom_right();
}
}

module door_upper(){
  gen_holder(w=side_l_raw/2, plexi_holder_inner_h_off=0);
  gen_corner(left=true, z_offset=20-offset-plexi_holder_t, plexi_holder_inner_h_off=0);
  translate([side_l_raw/2, 2*plexi_holder_t +plexi_t,0])
  rotate([0,0,180])
  gen_corner(left=true);
}

module door_bottom(){
  gen_holder(w=side_l_raw/2, plexi_holder_inner_h_off=0);
  gen_corner(left=true, z_offset=40-offset-plexi_holder_t, plexi_holder_inner_h_off=0);
  translate([side_l_raw/2, 2*plexi_holder_t +plexi_t,0])
  rotate([0,0,180])
  gen_corner(left=true);
}


module upper(){
  gen_corner();
  gen_holder(upper_l, with_screw_left=true, with_screw_right=true);
}

module bottom(){
  gen_holder(upper_l);
}

module side_upper_right(){
  gen_corner( bottom_screw=true, left=true, z_offset=offset, corner_screw=true);
  gen_holder(side_l, with_screw_left=true, with_screw_right=true, left_screw_offset=offset);
}

module side_upper_left(){
  mirror([1,0,0])
  side_upper_right();
}


module side_botom_left(){
  gen_corner( bottom_screw=true,left=true, z_offset=offset);
  gen_holder(side_l, with_screw_left=true,with_screw_middle=true, with_screw_right=true, left_screw_offset=offset);
}

module side_botom_right(){
  mirror([1,0,0])
  side_botom_left();
}


// for(i = [0 : 7]){ 
  // translate([0,i*16,0])
  // gen_holder(ikea_inner_w / 2, true);
// }

// for(i = [0 : 7]){ 
//   translate([0,i*16,0])
//   gen_holder(225, true);
// }

module gen_corner(bottom_screw=false, left=false, right=false, z_offset=0, corner_screw=false, plexi_holder_inner_h_off=plexi_holder_inner_h_off){
  if(left){
    translate([0,0,abs_h+z_offset])
    rotate([0,90,0])
    gen_holder(only_screw+z_offset, with_screw_left=corner_screw, with_screw_right=false, plexi_holder_inner_h_off=plexi_holder_inner_h_off);
  }

}

module gen_holder(w, with_screw_left=false,with_screw_middle=false, with_screw_right=false , left_screw_offset=0, plexi_holder_inner_h_off=plexi_holder_inner_h_off){
  minkowskiOutsideRound(plexi_holder_t/2)
  difference(){
    cube([w,plexi_t+2*plexi_holder_t, abs_h]);
    translate([0,plexi_holder_t,plexi_holder_t])
    cube([w,plexi_t, plexi_holder_h]);
    translate([0,0,plexi_holder_t+plexi_holder_h-plexi_holder_inner_h_off])
    cube([w,plexi_holder_t, plexi_holder_h]);
  }
  cube([w,plexi_t+2*plexi_holder_t, plexi_holder_t]);

  if(with_screw_left){
    translate([screw_r2+screw_r_t+left_screw_offset,0,0])
    add_screw();
  }

  if(with_screw_middle){
    translate([w/2,0,0])
    add_screw();
  }

  if(with_screw_right){
    translate([w-(screw_r2+screw_r_t),0,0])
    add_screw();
  }
}

module add_screw(){
    translate([0,-(screw_r2+screw_r_t),0])
    difference(){
      union(){
        cylinder(h=screw_h, r=screw_r2+screw_r_t, $fn=res);
        translate([-((screw_r2+screw_r_t)),0,0])
        cube([(screw_r2+screw_r_t)*2, screw_r2+screw_r_t+plexi_holder_t, screw_h]);
      }
      cylinder(h=screw_h, r1=screw_r1, r2=screw_r2, $fn=res);
    }
}

