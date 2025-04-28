thickness=7;
d=19;
r=d/2;
max_d=d+2*thickness;
max_h=d+thickness;

extend=50;

$fn=64;

length=40;

screw_d=3.5;
screw_d2=7.5;
screw_r = screw_d/2;
screw_r2 = screw_d2/2;
screw_dh=4;


holder_3d();
// holder_2d();
// screw_2d();
// screw_3d();


module screw_3d(){
  rotate_extrude() {
    screw_2d();
  }
}

module screw_2d(){
  polygon(points = [
   [0,-100],
   [0,100],
   [screw_r2,100],
   [screw_r2,0+screw_dh],
   [screw_r,0],
   [screw_r,-100],
  ]);
}


module holder_3d(){
  difference(){
    translate([-r-extend/2,length/2,0]) 
    rotate([90,0,0,])
    linear_extrude(height = length) 
    holder_2d();

    translate([0,0,8]){
      translate([0,length/4,0])
      #screw_3d();
      translate([0,-length/4,0])
      #screw_3d();
    }
  }
}

module holder_2d(){
  polygon(points = [
    [r,0],
    [r,d],
    [r*.6,(d+thickness)*.961],
    // [r,d+thickness*.55],
    [extend,thickness],
    [extend,0],
  ], paths = paths, convexity = convexity);

  translate([0,d/2,0]) 

  difference(){
    union(){
      circle(d=max_d);
    }
    circle(d=d);

    translate([-max_d+r,-max_d]) 
    square(size = [max_d,max_d]);

    translate([-max_d,-max_d+r*.6]) 
    square(size = [max_d,max_d]);

    translate([0,-max_d-r]) 
    square(size = [max_d,max_d]);
  }
}