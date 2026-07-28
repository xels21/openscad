/*

         . - ~ ~ - .
     . ' .--------. ' .
   /   .' ,.---.,  '   \
  |   |  |      |  |   |
  |   |  |      |  |   |
  |   |  |      |  |   |
   \   '. '----' .'   /
     ' . ' - - '   . '
         ' - ~ ~ - '

*/

h1=20;
h2=8;

h_sum = h1+h2;

outer_d=125;
inner_r=outer_d/2-h_sum;

b1=8;
b2=8;
b3=3;

triangle_plus=1;
b_max = max(b1,b2,b3);
b_max_w_tri = b_max + 2*triangle_plus;

form_3d();

module form_3d(){
  form_3d_outer();
  form_3d_inner();
}

module triangle_3d(){
  color("#ff8efb")
  intersection(){
    scale([1,1,2])
    form_3d_outer_wo();
    translate([0,outer_d/2,0])
    linear_extrude(height=b_max_w_tri , center=true)
    triangle_2d();
  }
}
module triangle_2d(){
  polygon(points=[
    [0,-h_sum],
    [h_sum*.7,0],
    [-h_sum*.7,0],
  ]);
}

module form_3d_outer(){
  triangle_3d();
  form_3d_outer_wo();
}
module form_3d_outer_wo(){
  color("#333")
  rotate_extrude($fn=128)
  translate([inner_r+h2,0,0])
  rotate([0,0,-90])
  form_2d_outer();
}
module form_3d_inner(){
  color("#03b5fc")
  rotate_extrude($fn=128)
  translate([inner_r,0,0])
  rotate([0,0,-90])
  form_2d_inner();
}

module form_2d_outer(){
  form_2d_outer_single();
  mirror([1,0,0])
  form_2d_outer_single();
}
module form_2d_inner(){
  form_2d_inner_single();
  mirror([1,0,0])
  form_2d_inner_single();
}

module form_2d_outer_single(){
  polygon(points=[
  [0,0],
  [0,h1],
  [b1/2,h1],
  [b2/2,0],
  ]);
}
module form_2d_inner_single(){
  polygon(points=[
  [0,0],
  [0,h2],
  [b2/2,h2],
  [b3/2,0],
  ]);
}