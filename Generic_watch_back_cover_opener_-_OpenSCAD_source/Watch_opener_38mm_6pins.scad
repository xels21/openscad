$fn=200;

tol=0.5;

diameter_back_cover = 44+2*tol;
diameter_pins = 2;
base_heigth = 2.5;
pins_heigth = 1.5;
radius_pins = 19+tol;
diameter_finger_cutout = 40;
distance_finger_cutout_to_center = 38;
diameter_cutout_cylinder_center = 30;

res=64;
stab=1;

// cube([1,38,10],center=true);

difference(){
  union(){
    // Base
    cylinder(d=diameter_back_cover,h=base_heigth,$fn=res);

    // Pins
    translate([0,0,base_heigth])
    for ( i = [0 : 5] ){
      // rotate( i * 60, [0, 0, 1])
      // translate([0, radius_pins, 0])
      // cylinder(d=diameter_pins,h=pins_heigth,$fn=res);
      rotate( i * 60, [0, 0, 1])
      translate([0, radius_pins+diameter_pins/2+stab/2, pins_heigth/2])
      cube([diameter_pins,diameter_pins+stab,pins_heigth],center=true);
    }
  }

  // Cutouts for fingers
  rotate(30,[0,0,1])
  for ( i = [0 : 5] ){
    rotate( i * 60, [0, 0, 1])
    translate([0, distance_finger_cutout_to_center, 0])
    cylinder(d=diameter_finger_cutout,h=base_heigth,$fn=res);
  }

  // Cutout in the middle
  cylinder(d=diameter_cutout_cylinder_center,h=base_heigth,$fn=res);
}
