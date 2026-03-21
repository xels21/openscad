use <../libs/openscad_xels_lib/round.scad>;
use <../libs/openscad_xels_lib/cylinder.scad>;

pixel_rows = 16;
pixel_columns = 16;

pixel_size_xy = 5;
pixel_gap_xy = 5;
pixel_element_xy = pixel_size_xy + pixel_gap_xy;

padding = pixel_gap_xy/2;
max_tol = .4;

max_inner_led_x =  pixel_columns*pixel_element_xy-pixel_gap_xy+max_tol;
max_inner_x = 2*padding + max_inner_led_x;

max_inner_led_y =  pixel_rows*pixel_element_xy-pixel_gap_xy+max_tol;
max_inner_y = 2*padding + max_inner_led_y;

heat_gap_count_x = 4;
heat_gap_count_y = 4;
heat_gap_h = 2;
heat_gap_w = 8;
heat_gap_r = min(2, heat_gap_h*.99);


plate_t=1;

plate_border_t=2;
plate_border_h=11;

diffuser_h_neg=1;

electro_t=2;

electro_x_inner=110;
electro_x_outer=electro_x_inner+2*electro_t;
electro_y_inner=47;
electro_y_outer=electro_y_inner+electro_t+plate_border_t;
// electro_w_inner=27;
electro_w_inner=28;
electro_w_outer=electro_w_inner+electro_t;
// electro_r=0;
electro_r=4;
// electro_r=10;

electro_hold_h=heat_gap_h;
electro_hold_w=3;

max_electro_x_w_arms = electro_x_outer+2*electro_hold_w;
max_electro_y_w_arms = electro_y_outer+electro_hold_w;

// tol_fac=1.05;
// tol_fac=1.1;
// tol_fac=1.2;

switch_x = 20;
switch_y = 6;
switch_z = 3.5;
switch_screw_out_off_x = 2.5;
switch_screw_d = 1.5;
switch_small_x = 5.4+.5;
switch_small_y = 3.5;

// switch_x_off=120;
switch_x_off = 0;//screw_2_off_x + screw_d_all / 2 + 1;

esp_x=55+1;
esp_y=13+1;
esp_z=28;//+1;
esp_t=2;

esp_x_max = esp_x + esp_t + electro_t;


bat_x = 67;
bat_d = 19 + .5;

charger_x=28+1;
charger_y=5.5;
charger_z=18+1;
charger_t=2;

charger_x_max = charger_x + charger_t + electro_t;

switch_off_fac=.3;

wall_off=41;

usb_c_x=10 + .2;
usb_c_y= 4 + .2;

res=16;

echo("####################");
echo("max_inner_x: ", max_inner_x);
echo("####################");


// translate([30,0,3])
diffuser();
// case();
// electronic_case();
// usb_padding();

module usb_padding(){



  plus = 2;

  usbc_r1=1.5;
  usbc_r2=2;

  linear_extrude(height=2)
  difference(){
    offset(usbc_r2, $fn=32)
    offset(-usbc_r2)
    square([usb_c_x+2*plus, usb_c_y+2*plus], center=true);

    offset(usbc_r1, $fn=32)
    offset(-usbc_r1)
    #square([usb_c_x, usb_c_y], center=true);
  }
}

module electronic_case(){
  difference(){
    union(){
      difference(){
        electro_outer(outer=true);
        electro_outer(outer=false);

        // USB CHARGER LEFT SIDE
        // translate([0,electro_y_inner/2,-electro_w_inner/2])
        // #rounded_cube_y([2*electro_t, 20, 10], r=4, center=true);

      }
      // CHARGER RIGHT PLUS
      translate([2*electro_t + electro_x_inner - charger_x_max, 0,-electro_w_inner-electro_t])
      charger_pos(center=false);


      // ESP RIGHT PLUS
      translate([2*electro_t + electro_x_inner - esp_x_max, bat_d+esp_t*1,-electro_w_inner-electro_t])
      rounded_cube_x([esp_x_max, esp_y+2*esp_t, esp_z+esp_t], r=4);

      // SWITCH
      #translate([electro_x_outer-switch_z/2,electro_y_outer*switch_off_fac,electro_w_outer*-.35])
      rotate([90,90,90])
      switch_pos(center=true);

      // Battery
      translate([electro_x_inner-bat_x-charger_x-electro_t,0,-electro_w_inner])
      difference(){
        cube([bat_x+2*esp_t, bat_d+2*esp_t, bat_d*.66], center=false);
        translate([esp_t,esp_t,0])
        rounded_cube_y([bat_x, bat_d, 2*bat_d], r=bat_d*.499, $fn=32, center=false);
      }

      //  SEPERATOR
      // translate([electro_t+wall_off,0,-electro_w_inner])
      // rounded_cube_y([electro_t,electro_y_inner,electro_w_inner-8],r=3, center=false);
    }
    // CHARGER RIGHT NEG
    #translate([2*electro_t + electro_x_inner - charger_x_max + electro_t, esp_t*1,-electro_w_inner])
    difference(){
      rounded_cube_y([charger_x+electro_t, charger_y, charger_z+2], r=2);
      translate([charger_x, 0, 0])
      #cube([charger_t,charger_y,charger_z*.3]);
    }


    // ESP RIGHT NEG
    // #translate([2*electro_t + electro_x_inner - esp_x_max, bat_d+esp_t*1,-electro_w_inner-electro_t])
    translate([2*electro_t + electro_x_inner - esp_x_max + electro_t, bat_d+esp_t*2,-electro_w_inner])
    difference(){
      rounded_cube_y([esp_x+electro_t, esp_y, esp_z+2], r=2);
      translate([esp_x, 0, 0])
      difference(){
        cube([esp_t,esp_y,esp_z+10]);
        #translate([0,esp_y-usb_c_y,esp_z*.3])
        // !cube([esp_t, usb_c_y, usb_c_x]);
        mirror([1,0,0])
        rotate([0,-90,0])
        linear_extrude(height=esp_t)
        offset(.99,$fn=16)
        offset(-.99)
        square([usb_c_x, usb_c_y]);
      }
      // #cube([esp_t,esp_y,esp_z*.3]);
    }

    // esp_neg(center=false);

    // SWITCH NEG
    translate([electro_x_outer-switch_z/2,electro_y_outer*switch_off_fac,electro_w_outer*-.35])
    rotate([90,90,90])
    switch_neg(center=true);
  }
}



// !esp();
// module esp(center=false){
//   difference() {
//     esp_pos(center=center);
//     #esp_neg(center=center);
//   }
// }

module charger_pos(center=center){
  z_corr = center?-charger_t/2:0;
  translate([0, 0, z_corr])
  rounded_cube_x([charger_x_max, charger_y+2*charger_t, charger_z+charger_t], r=4, center=center);
}
module charger_neg(center=center, r=2){
  z_off=4;

  z_corr = center? max(r/2,z_off): max(r/2,z_off)+charger_t;
  x_off=center?electro_t/2:electro_t;
  y_off=center?0:charger_t;
  translate([x_off, y_off, z_corr])
  rounded_cube_y([charger_x+electro_t, charger_y, charger_z+r-z_off], r=r, center=center);
}

module esp_pos(center=center){
  z_corr = center?-esp_t/2:0;
  translate([0, 0, z_corr])
  rounded_cube_x([esp_x_max, esp_y+2*esp_t, esp_z+esp_t], r=4, center=center);


}
module esp_neg(center=center, r=2){
  z_off=8;

  z_corr = center? max(r/2,z_off): max(r/2,z_off)+esp_t;
  x_off=center?electro_t/2:electro_t;
  y_off=center?0:esp_t;
  translate([x_off, y_off, z_corr])
  rounded_cube_y([esp_x+electro_t, esp_y, esp_z+r-z_off], r=r, center=center);
}

module switch(center=false) {
  difference() {
    switch_pos(center=center);
    switch_neg(center=center);
  }
}
module switch_pos(center=false) {
  center_x=center?-switch_x/2:0;
  center_y=center?-switch_y/2:0;
  center_z=center?-switch_z/2:0;
  translate([center_x, center_y, center_z])
    cube([switch_x, switch_y, switch_z]);
}
module switch_neg(center=false) {
  center_x=center?-switch_x/2:0;
  center_y=center?-switch_y/2:0;
  center_z=center?-switch_z/2:0;
  translate([center_x, center_y, center_z]){
    #translate([(switch_x - switch_small_x) / 2, (switch_y- switch_small_y)/2, 0])
      cube([switch_small_x, switch_small_y, switch_z]);

    #translate([switch_screw_out_off_x, switch_y/2, 0])
      cylinder(h=switch_z, d=switch_screw_d, $fn=res);

    #translate([switch_x - switch_screw_out_off_x, switch_y/2, 0])
      cylinder(h=switch_z, d=switch_screw_d, $fn=res);
  }
}

module diffuser(){
  // diffuser_h=plate_border_h-heat_gap_h-plate_t;
  diffuser_t=1;
  diffuser_h_tol=.5;
  led_h=2.5;
  diffuser_element_h=plate_border_h-heat_gap_h-plate_t-diffuser_t-led_h-diffuser_h_tol-diffuser_h_neg;
  cylinder_correction_fac=1.4145;
  echo("diffuser_h: ", diffuser_element_h);
  // cube([max_inner_x, max_inner_y, diffuser_t]);
  cube([pixel_rows*pixel_element_xy, pixel_columns*pixel_element_xy, diffuser_t]);
  translate([pixel_element_xy/2, pixel_element_xy/2, 0 ])
  for(r=[0:pixel_rows-1]){
    for(c=[0:pixel_columns-1]){
      translate([c*pixel_element_xy, r*pixel_element_xy, 0])
      rotate([0,0,45])
      translate([0,0,diffuser_t])
      scale([cylinder_correction_fac,cylinder_correction_fac,1])
      // cylinder(d1=pixel_element_xy,d2=pixel_size_xy,h=diffuser_element_h,$fn=4);
      cylinder_xels(d1=pixel_element_xy,d2=pixel_size_xy,d2_fac=.7,h=diffuser_element_h,fn1=4, fn2=64);
    }
  }
}

module case(){
  difference(){
      union(){
        plate();

        plate_border();
      }

      // translate([(max_inner_x/2 - (electro_x_outer/2)*tol_fac), 0, 0])
      // scale(tol_fac)
      translate([(max_inner_x/2 - (electro_x_outer/2)), 0, 0])
      #electro_outer(xy_fac=1, z_fac=1);
  }
}

module plate_border(){
  border_holder_h = 1;
  border_holder_w = 10;
  linear_extrude(height=plate_border_h)
  difference(){
    translate([-plate_border_t, -plate_border_t, 0])
    square([max_inner_x+2*plate_border_t, max_inner_y+2*plate_border_t]);
    square([max_inner_x, max_inner_y]);
  }

  translate([0,0,plate_border_h])
  intersection(){
    union(){
      // CENTER Y
      translate([0,max_inner_y/2-(border_holder_w/2),-border_holder_h])
      cube([max_inner_x, border_holder_w, border_holder_h]);
      // BOTTOM Y
      translate([0,0,-border_holder_h])
      cube([max_inner_x, border_holder_w, border_holder_h]);
      // TOP Y
      translate([0,max_inner_y-(border_holder_w),-border_holder_h])
      cube([max_inner_x, border_holder_w, border_holder_h]);
    }

    union(){
      // LEFT X
      translate([0,0,-border_holder_h])
      cube([border_holder_w, max_inner_y, border_holder_h]);
      // CENTER X
      translate([max_inner_x/2-(border_holder_w/2),0,-border_holder_h])
      cube([border_holder_w, max_inner_y, border_holder_h]);
      // RIGHT X
      translate([max_inner_x-border_holder_w,0,-border_holder_h])
      cube([border_holder_w, max_inner_y, border_holder_h]);
    }

    // translate([0,0,border_holder_h])
    union(){
      // LEFT
      rotate([-90,0,0])
      cylinder(h=max_inner_y, r=border_holder_h, $fn=4);

      // RIGHT
      translate([max_inner_x, 0, 0])
      rotate([-90,0,0])
      cylinder(h=max_inner_y, r=border_holder_h, $fn=4);

      // BOTTOM
      rotate([0,90,0])
      cylinder(h=max_inner_x, r=border_holder_h, $fn=4);

      // TOP
      translate([0, max_inner_y, 0])
      rotate([0,90,0])
      cylinder(h=max_inner_x, r=border_holder_h, $fn=4);
    }
  }
}


module plate(){  
    cube([max_inner_x, max_inner_x, plate_t]);

    holder_plus_w=4;

    holder_x=max_electro_x_w_arms+ 2*holder_plus_w;
    holder_y=max_electro_y_w_arms+ holder_plus_w;

    temp_holder_cut=6;

    echo("holder_y: ", holder_y);

    translate([max_inner_x/2 - holder_x/2, -plate_border_t, 0])
    difference(){
      rounded_cube_xyz([holder_x, holder_y,plate_t+ heat_gap_h],$fn=1,r=plate_t, center=false);
      translate([temp_holder_cut, 0, 0])
      cube([holder_x-2*temp_holder_cut, holder_y-temp_holder_cut,plate_t+ heat_gap_h],$fn=1,r=plate_t, center=false);
    }

    translate([0,0,plate_t])
    heat_gap();
}

// module electro_inner(){
//   translate([0, -plate_border_t, -electro_w_outer])
//   intersection(){
//     translate([0,-electro_r, 0])
//     rounded_cube_xyz([electro_x_outer, electro_y_outer+electro_r, plate_t+electro_w_outer+electro_r], r=electro_r, center=false);
//     cube(            [electro_x_outer, electro_y_outer, plate_t+electro_w_outer]);
//   }
// }

module electro_outer(outer=true, xy_fac=.99, z_fac=.9){
  translate([((1-xy_fac)*max_electro_x_w_arms)/2,0,0])
  scale([xy_fac,xy_fac,z_fac])
  if(outer){
    translate([0,0, plate_t])
    intersection(){
      // x with arms
      translate([max_electro_x_w_arms- electro_hold_w, max_electro_y_w_arms-plate_border_t, 0])
      rotate([90,0,-90])
      linear_extrude(height=max_electro_x_w_arms)
        polygon(points=[
          [0,0],
          [heat_gap_h,heat_gap_h],
          [max_electro_y_w_arms,heat_gap_h],
          [max_electro_y_w_arms,0],
        ]);

      // y with arms
      translate([0, max_electro_y_w_arms-plate_border_t, 0])
      rotate([90,0,0])
      linear_extrude(height=max_electro_y_w_arms)
        polygon(points=[[-electro_hold_w,0],
          [-electro_hold_w+heat_gap_h,heat_gap_h],
          [+electro_hold_w+electro_x_outer-heat_gap_h,heat_gap_h],
          [+electro_hold_w+electro_x_outer,0],
        ]);
    }
  }
  x=outer?electro_x_outer:electro_x_inner;
  y=outer?electro_y_outer:electro_y_inner;
  z=outer?electro_w_outer:electro_w_inner+heat_gap_h;
  z_off=outer?0:heat_gap_h;
  xy_off=outer?0:electro_t;
  translate([xy_off,xy_off -plate_border_t, -z])
  intersection(){
    translate([0,-electro_r, z_off])
    rounded_cube_xyz([x, y+electro_r, plate_t+z+electro_r], r=electro_r, center=false);
    cube(            [x, y, plate_t+z+z_off]);
  }
}

module heat_gap(){
  heat_x_count = 2+heat_gap_count_x-1;
  heat_y_count = 2+heat_gap_count_y-1;
  intersection(){
    cube([max_inner_x, max_inner_y, heat_gap_h]);
    for(i=[0:heat_x_count]){
        translate([i*max_inner_x/heat_x_count, 0, 0])
        translate([-heat_gap_w/2, 0, heat_gap_h])
        rotate([-90,0,0])
        linear_extrude(height=max_inner_y)
        offset(heat_gap_r)
        offset(-heat_gap_r)
        square([heat_gap_w, heat_gap_h+heat_gap_r]);
    }
    for(i=[0:heat_y_count]){
        translate([0, i*max_inner_y/heat_y_count, 0])
        translate([0, heat_gap_w/2, heat_gap_h])
        rotate([-90,0,-90])
        linear_extrude(height=max_inner_x)
        offset(heat_gap_r)
        offset(-heat_gap_r)
        square([heat_gap_w, heat_gap_h+heat_gap_r]);
    }
  }
}