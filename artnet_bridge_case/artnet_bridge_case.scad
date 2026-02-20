use <../libs/openscad_xels_lib/round.scad>;


esp_x_raw=55;
esp_y_raw=28;
esp_z_raw=13; //TODO
max485_x_raw=44;
max485_y_raw=15;
// max485_z_raw=13; 
max485_z_raw=15; // w/ "extension"
xlr_x_raw=24;
xlr_y_raw=24;
xlr_z_raw=27;


esp_x = esp_x_raw+0.3;
esp_y = esp_y_raw+1;
esp_z = esp_z_raw+1;
max485_x = max485_x_raw+1;
max485_y = max485_y_raw+1;
max485_z = max485_z_raw+1;
xlr_x = xlr_x_raw+1;
xlr_y = xlr_y_raw+1;
xlr_z = xlr_z_raw+1;

xlr_d=23;

t=2;

max_controller_x = max(esp_x, max485_x);
max_controller_y = max(esp_y, max485_y);

max_x = max_controller_x + t + xlr_x;
max_y = max(esp_y, max485_y, xlr_y);
max_z = max((esp_z + max485_z), xlr_z);

wall_cut=8;

close_x=1.2;
close_y=1.4;
close_z=1.2;

r=2;

log(str("##########max_x: ", max_x));


// all(with_ws2812=1);
lid(tol_x=0.2, tol_y=0.4, tol_z=0.4, with_help=1);

module all(with_ws2812=0) {
  difference(){
    case();
    xlr_cut();
    usb_cut();
    if(with_ws2812){
      #translate([0,max_y-r,t+2+r])
      rotate([0,90,0])
      cylinder(h=2*t, r=2, $fn=32);
    }
  }
}
// esp();
// max485();
// xlr();

// lid();

module lid(tol_x=0, tol_y=0, tol_z=0, with_help=0){
  x=t+max_x+close_x-tol_x;
  y=close_y-tol_y;
  z=2*close_z+max_z-tol_z;
  min_r=min(x,y,z);
  rounded_cube_xyz([x, y ,z], r=min_r*.49, $fn=1);
  if(with_help){
    translate([5,0,6])
      rounded_cube_xyz([2, close_y-tol_y+1.5, 2*close_z+max_z-tol_z-12], r=.5, $fn=1);
  }
}

module case(){
  color("white")
  difference(){
    outer_case();
    inner_case();
  }
  intersection(){
    walls();
    outer_case();
  }

  translate([0,-2*close_y,0])
  difference(){
    rounded_cube_x([max_x+2*t, 2*close_y+r, max_z+2*t], r=r, $fn=1);
    translate([0,0,t])
    #cube([max_x+t, 2*close_y, max_z]);

    translate([0,-r,])
    inner_case();

    translate([-r,close_y,t-close_y])
    lid(tol_x=-r);
  }

}

module outer_case(){
    rounded_cube_xyz([max_x+2*t, max_y+2*t, max_z+2*t], r=r, $fn=1);
}
module inner_case(){
  translate([t,t-9*t,t])
  rounded_cube_xyz([max_x, max_y+9*t, max_z], r=r, $fn=1);
}

module usb_cut(){
  // x=18;
  x=12;
  // y=12;
  y=8;
  // y_plus=10;

  // translate([0,t+max_y/2,t+esp_z/2+y_plus])
  #translate([t/2,t+max_y/2,t+esp_z-y/2])
  rounded_cube_y([t,x,y], r=2, center=true, fn=32);


  // translate([0,t+max_y/2,t+esp_z-y/2])
  // !rotate([0,90,0])
  // linear_extrude(height=t)
  // offset(2)
  // offset(-2)
  // #square(size=[y,x], center=true);
}

module xlr_cut(){
  translate([t+max_x,t+max_y/2,t+max_z/2])
  rotate([0,90,0])
  cylinder(h=t, d=xlr_d, $fn=64);
}

module walls(){
  color("yellow")
  translate([max_controller_x+t,wall_cut,0])
  cube([t, max_y+2*t-wall_cut, max_z+2*t]);

  color("orange")
  translate([0,wall_cut,esp_z+t])
  cube([max_controller_x+t, max_y+2*t-wall_cut, t]);
}

module esp(){
  color("red")
  translate([t,t,t])
  cube([esp_x, esp_y, esp_z]);
}

module max485(){
  color("green")
  translate([0,0,t])
  translate([t,t,t])
  translate([(max_controller_x-max485_x)/2, (max_controller_y-max485_y)/2, esp_z])
  cube([max485_x, max485_y, max485_z]);
}

module xlr(){
  color("blue")
  translate([t,0,0])
  translate([t,t,t])
  translate([max_controller_x, (max_controller_y-xlr_y)/2, 0])
  cube([xlr_x, xlr_y, xlr_z]);
}