space_h=9;
d=4.1;
t=4;

res=64;

difference(){
  cylinder(d=d+2*t, h=space_h, $fn=res);
  cylinder(d=d, h=space_h, $fn=res);
  }