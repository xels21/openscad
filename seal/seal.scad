d1=78;
d2=87;
h=2;

res=128;

linear_extrude(h)
difference(){
  circle(d=d2, $fn=res);
  circle(d=d1, $fn=res);
}