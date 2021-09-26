include <../libs/openscad_xels_lib\round.scad>
include <../libs/openscad_xels_lib\helper.scad>

stick_h=5;
stick_offset=2;
outer_h=5;

stick_r_raw=3;
stick_r=stick_r_raw+0.5;
stick_cut_l_raw=4;
stick_cut_l=stick_cut_l_raw+0.6;

strick_cover_r_raw=6;
strick_cover_r=strick_cover_r_raw-0.6;
strick_cover_gap_r_raw=8;
strick_cover_gap_r=strick_cover_gap_r_raw+0.6;

outer_r=12;

thickness=1.5;

knob_round_1=2.6;
knob_round_2=1.5;

stamp_depth=0.2;

res=128;

// stamp();
all();

module all(){
  difference(){
    union(){
      outer();
      stick_cover();
    }
    stamp();
  }
}

module stamp(){
  scale_fac=outer_r*1.45;

  translate([-0.35*scale_fac,0.48*scale_fac,-thickness+stamp_depth])
  scale(scale_fac)
  rotate([180,0,0])
  linear_extrude(1)
  twenty_one();
}
module outer(){


  difference(){
    translate([0,0,-thickness])
    rounded_cylinder(r=outer_r, h=outer_h+thickness, n=knob_round_1, fn=12);

    rounded_cylinder(r=strick_cover_gap_r, h=outer_h*2, n=knob_round_2, fn=res);
  }
  // cylinder(r=outer_r, h=stick_h+thickness,$fn=res);
}


module stick_cover(){
  difference(){
    cylinder(r=strick_cover_r, h=stick_h+stick_offset,$fn=res);
    translate([0,0,stick_offset])
    stick();
  }
}

module stick(){
  intersection(){
    cylinder(r=stick_r, h=stick_h+stick_offset,$fn=res);
    translate([stick_r*2-stick_cut_l,0,0])
    cube([stick_r*2,stick_r*2,(stick_h+stick_offset)*2], center=true);
  }
}