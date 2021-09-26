use <../libs/Round-Anything/MinkowskiRound.scad>;


thickness = 2;
car_t = 1;
car_l = 18;
span = 0.5;
holder_l = 10;
holder_l_plus = 2;
holder_t = 4;

width = 5;

minkowskiOutsideRound(1)
linear_extrude(width)
polygon(points=[
  [0,0],
  [0,thickness + car_t + thickness],
  [thickness + car_l,thickness + car_t + thickness-span],
  [thickness + car_l,thickness + car_t -span],
  [thickness,thickness + car_t],
  [thickness,thickness],
  [holder_l+holder_l_plus+thickness,thickness],
  [holder_l+holder_l_plus+thickness,thickness-holder_t-thickness],
  [0,-holder_t/2-0.5],
  [0,-holder_t/2+0.5],
  [holder_l,0],
]);
