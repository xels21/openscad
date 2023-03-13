
/*
 ____________
|    ____   |
| _/     \_ |
||         ||
||         ||
|_>       <_|
*/

inner_d=39;
lense_d=33;
lense_off=8;

inner_r=inner_d/2;
lense_r=lense_d/2;

t=1.5;

h=15;

h_max=h+lense_r+t;
x_max=2*t+inner_d;

span_r=0.2;

res=256;


rotate_extrude($fn=res) {
  difference(){
    polygon(points = [
      [0,0],
      [0,t+lense_r],
      [inner_r,t+lense_r],
      [inner_r,h_max],
      [inner_r+t,h_max],
      [inner_r+t,0],
    ]);
    translate([0,lense_r+t,0])
    circle(r = lense_r, $fn=res);
  }
  translate([inner_r,h_max-span_r,0],$fn=res/2)
  circle(r=span_r);
}