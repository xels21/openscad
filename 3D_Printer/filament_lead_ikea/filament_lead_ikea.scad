d=4;


res=64;
top_h=2;
bottom_h=52;
h=top_h + bottom_h;
thickness=3;

num=8;

inner_r=d+thickness+d/2;


// cylinder(d=d,h=h,$fn=res);

difference(){
  union(){
    cylinder(r2=inner_r+thickness+4,r1=inner_r+thickness+2, h=top_h, $fn=128);
    cylinder(r=inner_r+thickness/2, h=h, $fn=64);
  }
  union(){
    cylinder(d=d,h=h,$fn=res);
    for (i =[0:num]){
      outer_hole(i=i,offset = (i%2)*-d/2);
    }
  }
  translate([0,0,h])
  sphere(r=inner_r, $fn=32);
  // translate([0,0,-2.9])
  scale([1,1,0.3])
  sphere(r=inner_r, $fn=32);
}

module outer_hole(i=0, offset=0){
      rotate([0,0,i*(360/num)])
      translate([d+thickness+offset,0,0])
      cylinder(d=d,h=h,$fn=res);
}