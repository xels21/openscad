soda_outer_d=63;
soda_inner_d=47;

plus=4;

height=1.5;

$fn=64;

linear_extrude(height = height) 
difference() {
  circle(d=soda_outer_d+plus);
  circle(d=soda_inner_d-plus);
}