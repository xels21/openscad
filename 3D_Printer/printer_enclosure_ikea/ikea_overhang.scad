use <..\..\libs\Round-Anything\MinkowskiRound.scad>;
use <..\..\libs\roundedcube.scad>;

//under parts
// max_h=40;
// min_h=7;

// upper parts
max_h=20;
min_h=0;

// upper_h=max_h-under_h;
under_off=6;

overhang_w=50;
overhang_inner_w=45;


plug_d1=40;
plug_d2=30;
plug_t=1.5;

res=128;
// translate([0,0,6])
// small_screw();

under_parts=false;
if(under_parts){
  under_overhang(with_screws=true, inner_plug=false);
  translate([0,-3,max_h-min_h])
  rotate([180,0,0])
  upper_overhang();
}


under_overhang();

// adapter(80);
// upper_parts=true;
// if(upper_parts){
  // under_overhang();
  // translate([overhang_w*1.2,0,0])
//   upper_overhang(with_screws=false, inner_plug=12);
// }

module adapter(h=10){

}

module under_overhang(with_outer_screws=false, with_inner_screws=true){
  translate([overhang_w/2,overhang_w/2,min_h])
  difference(){
  // union(){
  plug(plug_t);
  // cube([20,20,20]);
    if(with_inner_screws){
      translate([-overhang_w*0.15,-overhang_w*0.15,27])  
      rotate([180,0,0])
      union(){
        cylinder(h=max_h, d=10, $fn=res);
        translate([0,0,max_h-2*min_h])
        cylinder(h=3, d1=8, d2=5, $fn=res);
        translate([0,0,10])
        cylinder(h=max_h, d=4, $fn=res);
      }

      translate([overhang_w*0.15,overhang_w*0.15,27])  
      rotate([180,0,0])
      union(){
        cylinder(h=max_h, d=10, $fn=res);
        translate([0,0,max_h-2*min_h])
        cylinder(h=3, d1=8, d2=5, $fn=res);
        translate([0,0,10])
        cylinder(h=max_h, d=4, $fn=res);
      } 
    }
    if(with_outer_screws){
      roundedcube([overhang_w, overhang_w, min_h], false, 2, "z");
      translate([0,0,min_h-1])
      union(){
        translate([under_off,under_off,0])small_screw();
        translate([overhang_w-under_off,under_off,0])small_screw();
        translate([under_off,overhang_w-under_off,0])small_screw();
        translate([overhang_w-under_off,overhang_w-under_off,0])small_screw();
      }
    }
  }
}



module upper_overhang(with_screws=false, inner_plug=10){
  difference(){
    union(){
      roundedcube([overhang_w, overhang_w, max_h-min_h-inner_plug], false, 2, "z");
      translate([(overhang_w-overhang_inner_w)/2,(overhang_w-overhang_inner_w)/2,0])
      roundedcube([overhang_inner_w, overhang_inner_w, max_h-min_h], false, 2);
    }
    translate([overhang_w/2,overhang_w/2,0])
    plug(0);
    if(with_screws){
      translate([overhang_w*0.35,overhang_w*0.35,0])  
      union(){
        cylinder(h=max_h, d=4, $fn=res);
        translate([0,0,max_h-2*min_h])
        cylinder(h=3, d1=8, d2=5, $fn=res);
      }

      translate([overhang_w*0.65,overhang_w*0.65,0])  
      union(){
        cylinder(h=max_h, d=4, $fn=res);
        translate([0,0,max_h-2*min_h])
        cylinder(h=3, d1=8, d2=5, $fn=res);
      } 
    }
  }
}


module plug(tol=0){
  cylinder(d1=plug_d1-tol, d2=plug_d2-tol, h=max_h-2*min_h-tol, $fn=res);
}


module small_screw(){
    rotate([180,0,0])
    union(){
      translate([0,0,-1]) 
      cylinder(h = 1, d=6, $fn=res);
      translate([0,0,3]) 
      cylinder(h = 12, d1=2 ,d2=0.8, $fn=res);
      cylinder(h = 3, d1=6,d2=2 , $fn=res);
    }
}