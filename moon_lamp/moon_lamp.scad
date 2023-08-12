log("NOT WORKING: stl merge within openscad. just use .afm file");
log("model from: https://www.thingiverse.com/thing:4654560");


mount_outer_d=100;//114;
mount_outer_r=mount_outer_d/2;

mount_offset=20;//10
mount_inner_r = mount_outer_r - mount_offset;

bottom_thickness=3;

res=128;

// translate([0,0,10])
// mount();

mount_inner();
// moon_lamp();

module moon_lamp(){
  union(){
    scale(1.08)
    moon();
    mount();
  }
}

module mount_inner_mask(w=15, h=bottom_thickness){
  translate([-mount_outer_r,-w/2,0])
  cube([mount_outer_d,w,h]);
}

module mount_inner(){
  sphere_r=23;
  difference(){
    union(){
      intersection() {
        cylinder(r = mount_outer_r*.9, h=bottom_thickness ,$fn=res);
        mount_inner_mask();
      }

      intersection() {
        sphere(r = sphere_r, $fn=res);
        mount_inner_mask(h=40);
      }
    }
    cylinder(r=3,h=sphere_r, $fn=res/2);
    translate([-1,0,0])
    cube([2,sphere_r,sphere_r]);
    sphere(r = 7, $fn=res);
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
