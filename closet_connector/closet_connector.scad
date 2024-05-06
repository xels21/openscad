/*

 ______________              ______________
|            /               \            |
|           /_________________\           |
|_________________________________________|

*/


// angle = 45;
angle = 30;

w_small = 31;
w_big = 52;
w_length = 460;

wedge_depth = 11;

thickness = 13;

simple();

module simple(wedge_width=45, extrude=10){
  linear_extrude(extrude) 
  simple_2d(wedge_width);
}

module simple_2d(wedge_width=40){
  half_simple_2d(wedge_width);
  mirror([1,0,0]) 
  half_simple_2d(wedge_width);
}

module half_simple_2d(wedge_width=40){
  polygon(points = [
    [0,0],
    [0,thickness],
    [wedge_width,thickness],
    [wedge_width-tan(angle)*wedge_depth,thickness+wedge_depth],
    [wedge_width+1.5*thickness,thickness+wedge_depth],
    [wedge_width+1.5*thickness,0]
  ]);
}