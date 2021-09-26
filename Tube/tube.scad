d=22;
thickness=2;
h=50;

res=64;

linear_extrude(50)
difference(){
  circle(d=d+thickness+2*thickness, $fn=res);
  circle(d=d, $fn=res);
}