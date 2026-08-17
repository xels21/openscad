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
// triangle_plus=0;
b_max = max(b1,b2,b3);
b_max_w_tri = b_max + 2*triangle_plus;

tube_v1_off=1;
tube_v1_d=3.2;

// form_3d();
form_3d_inner();


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

module form_3d_outer_diff(){
  difference(){
    form_3d_outer_wo();
    triangle_3d();
  }
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
  difference(){
    form_2d_inner_plus();
    form_2d_inner_minus_v2();
  }
}

module form_2d_inner_old(){
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
module form_2d_inner_plus(){
  form_2d_inner_single_plus();
  mirror([1,0,0])
  form_2d_inner_single_plus();
}
module form_2d_inner_single(){
  difference(){
    form_2d_inner_single_plus();
    // form_2d_inner_single_minus_v1();
    form_2d_inner_single_minus_v2();
  }
}

tube_d_v2_raw=2.3;
tube_d_v2=tube_d_v2_raw+.1;
tube_off_fac_x=.5;
tube_off_fac_y=.85;
tube_v2_rad_fac=.4;
module form_2d_inner_minus_v2(){
  offset(tube_d_v2*.4,99)
  offset(-tube_d_v2*.4,99)
  union(){
    form_2d_inner_single_minus_v2();
    mirror([1,0,0])
    form_2d_inner_single_minus_v2();
  }
}
module form_2d_inner_single_minus_v2(){
  // translate([0,tube_d_v2/2,0])
  translate([0,h2-(tube_d_v2*(1+tube_off_fac_y)), 0])

  // union(){
    // circle(r=tube_d_v2/2, $fn=64);
    // translate([tube_d_v2*tube_off_fac_x,tube_d_v2*tube_off_fac_y,0])
    // circle(r=tube_d_v2/2, $fn=64);
  // }
  #polygon(points=[
    [0,tube_d_v2*-tube_v2_rad_fac],
    [0,tube_d_v2*(1+tube_off_fac_y)],
    [tube_d_v2*(1+tube_v2_rad_fac),tube_d_v2*(1+tube_off_fac_y)],
  ]);
}

module form_2d_inner_single_minus_v1(){
  translate([0,h2-tube_v1_d/2-tube_v1_off, 0])
    union(){
      circle(r=tube_v1_d/2, $fn=64);
      translate([0,tube_v1_d/2+tube_v1_off/2, 0])
      square([tube_v1_d*.85, tube_v1_d+tube_v1_off], center=true);
    }
}

module form_2d_inner_single_plus(){
  polygon(points=[
    [0,0],
    [0,h2],
    [b2/2,h2],
    [b3/2,0],
  ]);
}
