log("NOT WORKING: stl merge within openscad. just use .afm file");
log("model from: https://www.thingiverse.com/thing:4654560");


mount_outer_d=114;
mount_outer_r=mount_outer_d/2;

mount_offset=10;
mount_inner_r = mount_outer_r - mount_offset;

bottom_thickness=3;

res=128;

mount();
// moon_lamp();

module moon_lamp(){
  union(){
    scale(1.08)
    moon();
    mount();
  }
}

module mount(){
  // translate([0,0,1])
  rotate_extrude($fn=res) 
  polygon(points = [
    [mount_inner_r,0],
    [mount_outer_r,0],
    [mount_outer_r,bottom_thickness],
    [mount_inner_r,bottom_thickness],
    ]);
}

module moon(){
  model_cut_off=12;
  difference(){
    translate([0,0,-model_cut_off])
    import("../models/Moon_Lamp_4654560/files/moonLamp_FADO_cutted.stl", convexity = 10);
    translate([0,0,-model_cut_off])
    cube([200,200,2*model_cut_off], center=true);
  }
}
