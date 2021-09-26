use <../libs/Round-Anything/MinkowskiRound.scad>;

gap = 42;
desk_h=22;
desk_h_under_offset = 5;
desk_h_under_offset_helper = 3;
desk_x_under_offset = 3;
thickness=7;
clamp=13;
span=.6;

max_x=gap+clamp;
max_y=thickness+desk_h+thickness;

z=40;
// z=5;

do(version=2);

module do(version=1){

  points_block = [
    [gap,0],
    [0,0],
    [0,max_y],
    [gap,max_y]
  ];

  points_upper=[
    [max_x,max_y-span],
    [max_x,max_y-span-thickness],
    [gap,max_y-thickness]
  ];

  points_v1 = [
    [gap,thickness],
    [gap+desk_x_under_offset,thickness],
    [gap+desk_x_under_offset,thickness+desk_h_under_offset-desk_h_under_offset_helper],
    [max_x-clamp/3,thickness+desk_h_under_offset],
    [max_x,      thickness+desk_h_under_offset],
    [max_x,desk_h_under_offset]
  ];
  


  points_v2 = [
    [gap,thickness],
    [gap+desk_x_under_offset,thickness],
    [gap+desk_x_under_offset,thickness+desk_h_under_offset-desk_h_under_offset_helper],
    [max_x,thickness+desk_h_under_offset-desk_h_under_offset_helper],
    [max_x,desk_h_under_offset-desk_h_under_offset_helper],
    [gap+desk_x_under_offset,0]
  ];


  points_bottom = version == 1 ? points_v1:
                  version == 2 ? points_v2:
                  [];


  minkowskiRound(3)
  linear_extrude(z)
  polygon(points=concat(    
    points_block,
    points_upper,
    points_bottom
  ));
}