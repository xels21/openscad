/*

_____________________
\                   /
 \                 /
  \               /
   \             /
    |           |
    |           |
    |___________|


*/


thickness = 1.5;

d1_i=70;
d2_i=30;
d3_i=27;
h1=30;
h2=20;

fn=100;

funnel(thickness=thickness,d1_i=d1_i,d2_i=d2_i,d3_i=d3_i,h1=h1,h2=h2,fn=fn);

module funnel(thickness=thickness,d1_i=d1_i,d2_i=d2_i,d3_i=d3_i,h1=h1,h2=h2,fn=fn){
  h_max = h1+h2;

  r1_i=d1_i/2;
  r2_i=d2_i/2;
  r3_i=d3_i/2;

  r1=r1_i+thickness;
  r2=r2_i+thickness;
  r3=r3_i+thickness;

rotate_extrude($fn=fn)

  polygon(points=
  [
    [r3_i,0],
    [r2_i,h2],
    [r1_i,h_max],
    [r1,h_max],
    [r2,h2],
    [r3,0],
  ]);
}

