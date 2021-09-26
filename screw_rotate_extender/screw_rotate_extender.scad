use <../libs/Round-Anything/MinkowskiRound.scad>;


//M6
screw_size=11.05;
screw_d=6;
screw_tol=0.3;
// screw_fac = 1.155;

extender_h=6;
extender_bottom_offset=1;
extender_size_plus=15;

// cube([screw_size,screw_size,screw_h],center=true);

difference(){
  minkowskiOutsideRound(2){
    cylinder(h=extender_h,d=screw_size+extender_size_plus,$fn=6);
  }

  translate([0,0,extender_bottom_offset])
  cylinder(h=extender_h,d=screw_size+screw_tol,$fn=6);

  cylinder(h=extender_h,d=screw_d+screw_tol,$fn=128);
}