res=256;

belt(inner_r=(64/2), r_help=0.5,depth=3,outer_h=5,inner_h=3);

module belt(inner_r, r_help, depth, outer_h, inner_h){
  h_diff= outer_h-inner_h;
  // rotate_extrude($fn=res)
  translate([inner_r,0,0])
  polygon(points=[
    [depth,0],
    [depth-r_help,0],
    [0,h_diff/2],
    [0,h_diff/2+inner_h],
    [depth-r_help,outer_h],
    [depth,outer_h]
  ]);

}