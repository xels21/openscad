use <../libs/openscad_xels_lib/round.scad>;

pixel_rows = 16;
pixel_columns = 16;

pixel_size_xy = 5;
pixel_gap_xy = 5;
pixel_element_xy = pixel_size_xy + pixel_gap_xy;

padding = pixel_gap_xy/2;

max_inner_led_x =  pixel_columns*pixel_element_xy-pixel_gap_xy;
max_inner_x = 2*padding + max_inner_led_x;

max_inner_led_y =  pixel_rows*pixel_element_xy-pixel_gap_xy;
max_inner_y = 2*padding + max_inner_led_y;

heat_gap_count_x = 4;
heat_gap_count_y = 4;
heat_gap_h = 2;
heat_gap_w = 8;
heat_gap_r = min(2, heat_gap_h*.99);


plate_t=1;

plate_border_t=2;
plate_border_h=10;

electro_t=2;

electro_x_inner=110;
electro_x_outer=electro_x_inner+2*electro_t;
electro_y_inner=47;
electro_y_outer=electro_y_inner+electro_t+plate_border_t;
electro_w_inner=27;
electro_w_outer=electro_w_inner+electro_t;
// electro_r=0;
electro_r=10;

electro_hold_h=heat_gap_h;
electro_hold_w=3;

max_electro_x_w_arms = electro_x_outer+2*electro_hold_w;
max_electro_y_w_arms = electro_y_outer+electro_hold_w;

// tol_fac=1.05;
// tol_fac=1.1;
// tol_fac=1.2;

echo("####################");
echo("max_inner_x: ", max_inner_x);
echo("####################");

difference(){
    union(){
      plate();

      plate_border();
    }
    
    // translate([(max_inner_x/2 - (electro_x_outer/2)*tol_fac), 0, 0])
    // scale(tol_fac)
    translate([(max_inner_x/2 - (electro_x_outer/2)), 0, 0])
    #electro_outer();
}

module plate_border(){
  linear_extrude(height=plate_border_h)
  difference(){
    translate([-plate_border_t, -plate_border_t, 0])
    square([max_inner_x+2*plate_border_t, max_inner_y+2*plate_border_t]);
    square([max_inner_x, max_inner_y]);
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

module electro_inner(){
  #translate([0, -plate_border_t, -electro_w_outer])
  intersection(){
    translate([0,-electro_r, 0])
    rounded_cube_xyz([electro_x_outer, electro_y_outer+electro_r, plate_t+electro_w_outer+electro_r], r=electro_r, center=false);
    cube(            [electro_x_outer, electro_y_outer, plate_t+electro_w_outer]);
  }
}

module electro_outer(){
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

  #translate([0, -plate_border_t, -electro_w_outer])
  intersection(){
    translate([0,-electro_r, 0])
    rounded_cube_xyz([electro_x_outer, electro_y_outer+electro_r, plate_t+electro_w_outer+electro_r], r=electro_r, center=false);
    cube(            [electro_x_outer, electro_y_outer, plate_t+electro_w_outer]);
  }
  // linear_extrude(height=plate_t+electro_w_outer)
  // offset(electro_r)
  // offset(-electro_r)
  // square([electro_x_outer, electro_y_outer+electro_r+plate_border_t], center=false);
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