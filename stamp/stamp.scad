include <../libs/openscad_xels_lib/helper.scad>




/*

-------,
|       \
|        |
|       /
|     /
|    |
|    \_
|       `-,
|          \
|___________|    stamp_r


*/



stamp_r=30;
rad=2;

h_1=rad+2;
r_1_off=2;
r_1=stamp_r-r_1_off;

h_2=h_1+5;
r_2=max(10,stamp_r*.5);

h_3=h_2+10;
r_3=r_2;

knob_r=max(15,stamp_r*.66);

h_4=h_3+knob_r*1/3;
h_5=h_4+knob_r*1/3;
h_6=h_5+knob_r*1/3;

r_4=knob_r;
r_5=knob_r;
r_6=r_2;

to_scale=r_2*1.5;
to_h=1;

difference(){
  stamp();

  translate([0,0,h_6-to_h])
  linear_extrude(to_h) 
  scale([to_scale,to_scale])
  translate([-0.35,-0.5,0])
  twenty_one();
}

module stamp(){
  rotate_extrude($fn=16)
  difference(){
    offset(r=rad)
    offset(delta=-rad) 
    polygon(points = [
      [-rad,0],
      [stamp_r,0],
      [stamp_r,rad],
      [r_1,h_1],
      [r_2,h_2],
      [r_3,h_3],
      [r_4,h_4],
      [r_5,h_5],
      [r_6,h_6],
      [-rad,h_6],
    ]);
    translate([-rad,0]) 
    square([rad,h_6]);
  }
  cylinder(h=rad,r=stamp_r,$fn=128);
}