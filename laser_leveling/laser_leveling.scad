laser_x = 181;
laser_y = 116+2; //screws back

holder_h=15;

t=3;

holder_insert_h_raw=12;
holder_insert_h=holder_insert_h_raw + t;

holder_rot_n=8;

d_raw = (holder_h+t);
d = (d_raw)*1.08;

inner_d = 12;
inner_d_tol=0.4;

dmx_cut_d=30;
dmx_x_off=33;
dmx_y_off=20;

leg_t=8;

holder_xy_off=d_raw/2;
holder_x_gap = t+laser_x+t-2*holder_xy_off;
holder_y_gap = t+laser_y+t-2*holder_xy_off;

box();
translate([holder_xy_off+holder_x_gap,-20,0])
leg(is_side_x=true);
translate([holder_xy_off,-20,0])
rotate([0,0,180])
leg(is_side_x=true);

!rotate([90,0,0])
leg(is_side_x=false);

module leg(is_side_x=true){
  w=inner_d-inner_d_tol;
  leg_gap=1;
  
  // translate([t+dmx_x_off, t+laser_y, t+dmx_y_off])
  // rotate([90,0,0])
  l = is_side_x ? holder_x_gap/2-leg_gap : holder_y_gap/2-leg_gap;
  // translate([0,0,leg_t])
  rotate([0,0,360/holder_rot_n/2,0])
  cylinder(h=holder_insert_h+leg_t,d=w,$fn=holder_rot_n, center=false);
  
  w_adj = w*.925;
  linear_extrude(height=leg_t)
  // translate([-l/2+w_adj/2,0,0])
  translate([-l,0,0])
  translate([0,-w_adj/2,0])
  offset(w_adj*.49)
  offset(-w_adj*.49)
  square([l+w_adj/2,w_adj], center=false);
}

module box(){
difference(){
  union(){
    box_raw();
    holder_insert(side=0);
    holder_insert(side=1);
    holder_insert(side=2);
    holder_insert(side=3);
    holder_insert(side=4);
    holder_insert(side=5);
    holder_insert(side=6);
    holder_insert(side=7);
  }
  holder_insert(side=0, is_inner=1);
  holder_insert(side=1, is_inner=1);
  holder_insert(side=2, is_inner=1);
  holder_insert(side=3, is_inner=1);
  holder_insert(side=4, is_inner=1);
  holder_insert(side=5, is_inner=1);
  holder_insert(side=6, is_inner=1);
  holder_insert(side=7, is_inner=1);

  translate([t+dmx_x_off, t+laser_y, t+dmx_y_off])
  rotate([90,0,0])
  #cylinder(h=2*t,d=dmx_cut_d,$fn=100, center=true);
  }
}



module holder_insert(side=0, is_inner=0){
  if(side==0){
    translate([holder_xy_off, t, 0])
    holder_insert_raw(is_inner);
  }
  if(side==1){
    translate([holder_xy_off+holder_x_gap , t, 0])
    holder_insert_raw(is_inner);
  }
  if(side==2){
    translate([holder_xy_off, laser_y+holder_insert_h+t, 0])
    holder_insert_raw(is_inner);
  }
  if(side==3){
    translate([holder_xy_off+holder_x_gap, laser_y+holder_insert_h+t, 0])
    holder_insert_raw(is_inner);
  }
  if(side==4){
    translate([t, d_raw/2, 0])
    rotate([0,0,-90])
    holder_insert_raw(is_inner);
  }
  if(side==5){
    translate([t+laser_x, d_raw/2, 0])
    rotate([0,0,90])
    holder_insert_raw(is_inner);
  }
  if(side==6){
    translate([t, holder_y_gap + holder_xy_off, 0])
    rotate([0,0,-90])
    holder_insert_raw(is_inner);
  }
  if(side==7){
    translate([t+laser_x, holder_y_gap + holder_xy_off, 0])
    rotate([0,0,90])
    holder_insert_raw(is_inner);
  }
}
module holder_insert_raw(is_inner=0){

  // translate([(holder_h+t)/2, 0, 0])
  translate([0, 0, (holder_h+t)/2])
  rotate([90,360/holder_rot_n/2,0])
  if(is_inner==1){
    cylinder(h=holder_insert_h, d=inner_d, $fn=holder_rot_n);
  }else{
    cylinder(h=holder_insert_h, d=d, $fn=holder_rot_n);
  }
}

module box_raw(){
  difference(){
    outer_box();
    translate([t,t,t])
    #inner_box();
  }
}

module inner_box(){
  cube([laser_x,laser_y,holder_h]);
}


module outer_box(){
  cube([laser_x+2*t,laser_y+2*t,holder_h+t]);
}