esp_x=55;
esp_y=28;
esp_z=13; //TODO

max485_x=44;
max485_y=15;
max485_z=13; //TODO

xlr_x=24;
xlr_y=24;
xlr_z=27;
xlr_d=23;

t=2;

max_controller_x = max(esp_x, max485_x);
max_controller_y = max(esp_y, max485_y);

max_x = max_controller_x + t + xlr_x;
max_y = max(esp_y, max485_y, xlr_y);
max_z = max((esp_z + max485_z), xlr_z);

wall_cut=8;

close_t=1.2;

log(str("##########max_x: ", max_x));


difference(){
  case();
  xlr_cut();
  usb_cut();
}
// esp();
// max485();
// xlr();

module case(){
  color("white")
  difference(){
    cube([max_x+2*t, max_y+2*t, max_z+2*t]);
    translate([t,t-9*t,t])
    cube([max_x, max_y+9*t, max_z]);
  }
  walls();

  translate([0,-2*close_t,0])
  difference(){
    cube([max_x+2*t, 2*close_t, max_z+2*t]);
    translate([0,0,t])
    #cube([max_x+t, 2*close_t, max_z]);

    translate([0,close_t,t-close_t])
    cube([t+max_x+close_t, close_t, 2*close_t+max_z]);
  }

}

module usb_cut(){
  x=18;
  y=12;
  y_plus=0;

  translate([0,t+max_y/2,t+esp_z/2+y_plus])
  rotate([0,90,0])
  linear_extrude(height=t)
  offset(2)
  offset(-2)
  #square(size=[y,x], center=true);
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