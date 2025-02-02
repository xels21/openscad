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


thickness = 2;

d1_i=70;
d2_o=30;
d3_o=27;
h1=30;
h2=20;

d2_i=d2_o-2*thickness;
d3_i=d3_o-2*thickness;

fn=8;

// funnel(thickness=thickness,d1_i=d1_i,d2_i=d2_i,d3_i=d3_i,h1=h1,h2=h2,fn=fn);

// res = 96;
res = 16;
// vapo
vap_t=1;
vap_inner_d = 9;
vap_h=10;

boulder();

module vap(){
  funnel(
    thickness=vap_t,
    d1_i=30,
    d2_i=vap_inner_d-2*vap_t,
    d3_i=vap_inner_d-2*vap_t,
    h1=vap_h,
    h2=vap_h,
    fn=res
  );
}

module boulder(){
  boulder_t=1;

  funnel(
    thickness=boulder_t,
    d1_i=40,
    d2_i=12-2*boulder_t,
    d3_i=10-2*boulder_t,
    h1=15,
    h2=10,
    fn=res
  );
}

module stamp(){
  stamp_r=(vap_inner_d-2*vap_t-0.5)/2;
  // cylinder(d=9-2*vap_t-0.5,h=20,$fn=res);
  translate([d1_i/3,0,-vap_h])
  rotate_extrude($fn=res)

    polygon(points=
    [
      [0,0],
      [0,vap_h*3],
      [stamp_r+2,vap_h*3],
      [stamp_r+2,vap_h*2-6],
      [stamp_r,vap_h*2-8],
      [stamp_r,0]
    ]);
}

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

