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



// d1 = 200;
// d2 = 160;
// d3 = 140;

h1=30;
h2=8;

h_sum = h1+h2;

b1=3;
b2=10;
b3=4;

outer_d=200;

inner_r=outer_d/2-h_sum;

rotate_extrude($fn=64)
translate([inner_r,0,0])
// translate([10,0,0])
// square([b1,h_sum], center=false);
rotate([0,0,-90])
// form_2d_single();
form_2d();


module form_2d(){
  form_2d_single();
  mirror([1,0,0])
  form_2d_single();
}
module form_2d_single(){
  polygon(points=[
  [0,0],
  [0,h_sum],
  [b1,h_sum],
  [b2,h2],
  [b3,0],
  ]);
}