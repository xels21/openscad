use <../libs/Round-Anything/MinkowskiRound.scad>;

d = 177;
d_plus = 15;
d_max = d + 2*d_plus;

diff_t = 1;

span = 1.8; //each side
span_l = 30;
span_t = 3;

span_r = 5;

error("d is not diameter if $fn=8 (octagon) -> needs to be fixed")

rotate([0, 0, 45/2])
linear_extrude(height=diff_t)
offset(30)
offset(-30)
circle(d=d_max, $fn=8);

translate([0, 0, diff_t])
intersection(){
  translate([0, 0, span_l/2])
  union(){
    cube([d_max,    d_max*.3, span_l], center=true);
    cube([d_max*.3, d_max,    span_l], center=true);
  }
  rotate([0, 0, 45/2])
  difference(){
    cylinder(h=span_l+span_r, d1=d+2*span_t, d2=d-2*span+2*span_t, $fn=8);
    minkowskiOutsideRound(span_r)
    #cylinder(h=span_l+span_r, d1=d,d2=d-2*span, $fn=8);
  }
}
