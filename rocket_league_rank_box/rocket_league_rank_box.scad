
normed_xy=50;
normed_z=15;
// cube( [50,50,1]);
// cube( [50,50,15]);
// #Diamond_I();
// #Diamond_II();
// #Diamond_III();
// #Champion_I();
// #Champion_II();
// #Champion_III();




card_xy=50;
card_t=1;
card_r=2;
card_border_t=2;
card_border_w=2;
margin=1;

box_xy_plus=1;
box_z_plus=1;
box_t=2;
box_xy=card_xy+box_xy_plus+2*card_border_w;
box_z=card_xy+box_z_plus+card_border_w;

card_holder=2;

// card();
emblem();
// box();


module box(){
  difference(){
    linear_extrude(height=box_z)
    offset(1, $fn=32)
    offset(-1)
    square([box_xy,box_xy]);

    #translate([box_t,box_t,box_t])
    cube([card_xy+box_xy_plus,card_border_t+.5,card_xy+box_z_plus]);

    translate([box_t+card_holder,0,box_t+card_holder])
    cube([card_xy+box_xy_plus-2*card_holder,card_border_t,card_xy+box_z_plus-card_holder]);


    translate([box_t,box_t+card_border_t+box_t,box_t])
    cube([card_xy+box_xy_plus,box_xy-(box_t+box_t+card_border_t+box_t),card_xy+box_z_plus]);
  }
}

module emblem() {
  intersection(){
    // translate([card_border_w+margin,card_border_w+margin,0])
    // translate([0,0,card_t])
    cube([100,100,100]);
    translate([0,0,-1])
    scale([(card_xy-2*card_border_w-2*margin)/normed_xy,(card_xy-2*card_border_w-2*margin)/normed_xy,(5+1)/normed_z ])
    // #Diamond_I();
    // #Diamond_II();
    // #Diamond_III();
    Champion_I();
    // #Champion_II();
    // #Champion_III();
  }
}

module card(){
  difference(){
    linear_extrude(height=card_border_t)
    offset(card_r, $fn=32)
    offset(-card_r)
    square([card_xy,card_xy]);

    translate([card_border_w,card_border_w,card_border_t-card_t])
    linear_extrude(height=card_t)
    offset(card_r, $fn=32)
    offset(-card_r)
    square([card_xy-2*card_border_w,card_xy-2*card_border_w]);
  }
}


// NORMED with [50,50,15]
dia_scale_fac_xy=.765;
dia_scale_fac_z=1;
dia_x_off = -75.5;
dia_y_off=172;

module Diamond_I(){
  scale([dia_scale_fac_xy,dia_scale_fac_xy,dia_scale_fac_z])
  translate([dia_x_off,dia_y_off,0])
  rotate([90,0,0])
  import("./Diamond_I.stl");
}
module Diamond_II(){
  scale([dia_scale_fac_xy,dia_scale_fac_xy,dia_scale_fac_z])
  translate([dia_x_off,dia_y_off,0])
  rotate([90,0,0])
  import("./Diamond_II.stl");
}
module Diamond_III(){
  scale([dia_scale_fac_xy,dia_scale_fac_xy,dia_scale_fac_z])
  translate([dia_x_off,dia_y_off,0])
  rotate([90,0,0])
  import("./Diamond_III.stl");
}

module Champion_I(){
  champ_scale_fac_xy=.83;
  champ_scale_fac_z=1;
  champ_x_off = -130;
  champ_y_off=108.5;

  scale([champ_scale_fac_xy,champ_scale_fac_xy,champ_scale_fac_z])
  translate([champ_x_off,champ_y_off,0])
  rotate([90,0,0])
  import("./Champion_I.stl");
}

module Champion_II(){
  champ_scale_fac_xy=.83;
  champ_scale_fac_z=1;
  champ_x_off = -143;
  champ_y_off=94;

  scale([champ_scale_fac_xy,champ_scale_fac_xy,champ_scale_fac_z])
  translate([champ_x_off,champ_y_off,0])
  rotate([90,0,0])
  import("./Champion_II.stl");
}
module Champion_III(){
  champ_scale_fac_xy=.83;
  champ_scale_fac_z=.938;
  champ_x_off = -107.8;
  champ_y_off=138;

  scale([champ_scale_fac_xy,champ_scale_fac_xy,champ_scale_fac_z])
  translate([champ_x_off,champ_y_off,0])
  rotate([90,0,0])
  import("./Champion_III.stl");
}

// module Grand_Champion(){
  // import("./Grand_Champion.stl");
// }