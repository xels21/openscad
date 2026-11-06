use <../libs/openscad_xels_lib/round.scad>;

x=44;
y=23.8;
z_raw=14;

battery_z=12;

t=1;
r=11;

cut_x=21;
cut_z=8;
cut_r=5;

cable_x=4;
cable_y=2;

screw_x_plus=8;
screw_z_plus=3;
screw_d=2.5;

// cablecut=.5;
cablecut=1.2;

$fn=64;

switch_x=6;
switch_plus_x=10;
switch_y=20;
switch_gap_y=10;

esp_x=18;
esp_h=3.3;
esp_x_cut=10.2;



esp_x_sum = esp_x+2*t;
esp_h_sum = esp_h+2*t;

x_sum = x+2*t;
y_sum = y+2*t;

// digital_box(z_plus=1, w_esp=true);
// digital_box(battery_count=1, with_cablecut=true, with_screw=true, with_switch=true, z_plus=0);

module digital_box(battery_count=1,
                   with_cablecut=false,
                   with_screw=false,
                   with_switch=false,
                   z_plus=0,
                   w_esp=false,
                   center=false){
  z = z_raw+((battery_count-1)*battery_z)+z_plus;
  z_sum = z+t;
  if(center){
    translate([-x_sum/2,-y_sum/2,-z_sum/2])
    _digital_box(z=z, with_cablecut=with_cablecut, with_screw=with_screw, with_switch=with_switch, z_plus=z_plus, w_esp=w_esp, center=center);
  } else {
    _digital_box(z=z, with_cablecut=with_cablecut, with_screw=with_screw, with_switch=with_switch, z_plus=z_plus, w_esp=w_esp, center=center);
  }
  // _digital_box(z=z, with_cablecut=with_cablecut, with_screw=with_screw, with_switch=with_switch, z_plus=z_plus, w_esp=w_esp, center=center);
}


module _digital_box(z=1, with_cablecut=false, with_screw=false, with_switch=false, z_plus=0, w_esp=false){
  z_sum = z+t;
  difference(){
    union(){
      if(with_screw){
        translate([-screw_x_plus,0,z+t-screw_z_plus])
        difference(){ 
          rounded_cube_z([x+2*t+2*screw_x_plus,y+2*t,screw_z_plus], r=r);
          translate([0,(y+2*t)/2,0])
          {
            translate([screw_x_plus/2,0,0])
            #cylinder(h=screw_z_plus,d=screw_d);
            
            translate([screw_x_plus/2+x+2*t+screw_x_plus,0,0])
            #cylinder(h=screw_z_plus,d=screw_d);
          }
        }
      }
      #if(with_switch){
        translate([-switch_x,((y+2*t)-switch_y)/2,0])
        difference() {
          ounded_cube_z([switch_x+switch_plus_x,switch_y,z+t], r=2);
          translate([0,(switch_y-switch_gap_y)/2,0])
          cube([switch_x+switch_plus_x,switch_gap_y,z+t]);
        }
      }
      if(w_esp){
        translate([(x_sum-esp_x_sum)/2,y+t,0])
        rounded_cube_z([esp_x_sum,esp_h_sum,z_sum], r=1);
      }
      rounded_cube_z([x_sum,y_sum,z_sum], r=r);
    }
    translate([t,t,0]) 
    rounded_cube_z([x,y,z], r=r);

    translate([t+(x-cut_x)/2,0,-cut_z]) 
    rounded_cube_x([cut_x,t,2*cut_z], r=cut_r);

    translate([t+(x-cable_x)/2,y-cable_y,0]) 
    rounded_cube_z([cable_x,cable_y,2*z], r=.8);
    if(with_cablecut){
      translate([t+(x-cablecut)/2,y,0]) 
      cube([cablecut,2*t,2*z]);
    }
    #if(w_esp){
      translate([(x_sum-esp_x)/2,y+t+t,-t])
      rounded_cube_z([esp_x,esp_h,z_sum], r=1);

      translate([(x_sum-esp_x_cut)/2,y+t+t+t,0])
      cube([esp_x_cut,esp_h,z_sum], r=1);
    }
  }
}