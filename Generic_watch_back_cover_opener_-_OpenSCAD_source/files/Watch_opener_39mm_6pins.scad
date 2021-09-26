$fn=200;

diameter_back_cover = 43;
diameter_pins = 2;
pins_heigth = 1.5;
radius_pins = 19.5;
diameter_finger_cutout = 40;
distance_finger_cutout_to_center = 38;
diameter_cutout_cylinder_center = 30;

difference(){
  union(){
    // Base
    cylinder(d=diameter_back_cover,h=pins_heigth);

    // Pins
    translate([0,0,pins_heigth])
    for ( i = [0 : 5] ){
      rotate( i * 60, [0, 0, 1])
      translate([0, radius_pins, 0])
      cylinder(d=diameter_pins,h=pins_heigth);
    }
  }

  // Cutouts for fingers
  rotate(30,[0,0,1])
  for ( i = [0 : 5] ){
    rotate( i * 60, [0, 0, 1])
    translate([0, distance_finger_cutout_to_center, 0])
    cylinder(d=diameter_finger_cutout,h=pins_heigth);
  }

  // Cutout in the middle
  cylinder(d=diameter_cutout_cylinder_center,h=pins_heigth);
}
