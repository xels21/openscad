// use <../libs/MCAD/involute_gears.scad>;
// use <../libs/MCAD/gears.scad>;
use <../libs/Round-Anything/MinkowskiRound.scad>;


outer_d=82;
inner_d=72;
number_of_teeth=12;
tooth_b_raw=9;
tooth_b=tooth_b_raw+0.8;
stick_l=130;
stick_b=20;
stick_b_end=5;
height=10;
thickness=10;

res=128;
strick_round=30;
round_fn=4.5;

gear_tol=1.025;

// gear_2d();
all();

module all(){
  difference(){
    minkowskiOutsideRound(round_fn)
    wrench();
    linear_extrude(height)
    gear_2d();
  }
}

module wrench(){
  linear_extrude(height)
  wrench_2d();
}

module wrench_2d(){
  offset(1*strick_round*-1)
  offset(1*strick_round)
  wrench_2d_raw();
}

module wrench_2d_raw(){
  circle(d=outer_d+2*thickness, $fn=res/4);
  translate([0,-outer_d,0])
  
  union(){
    translate([0,-stick_l/2,0])
    circle(d=stick_b+stick_b_end, $fn=8);
    square(size=[stick_b, stick_l], center=true);
  }
}


module gear_2d(){
  scale(gear_tol)
  offset(1.5*-1)
  offset(1.5)
  gear_raw();
}

module gear_raw(){
  intersection(){
    circle(d=outer_d,$fn=res);
    union(){
      circle(d=inner_d,$fn=res);
      for(i=[0:number_of_teeth]){
        rotate([0,0,-i/number_of_teeth*360])
        polygon(points=[
        [tooth_b/2,0],
        [-tooth_b/2,0],
        [-tooth_b/2,outer_d],
        [tooth_b/2,outer_d]
        ]);
      }
    }
  }
}