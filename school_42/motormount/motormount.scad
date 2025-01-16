fn=64;
$fn=fn;


motor_d=36;
motor_l=60;


plate_screw_d   = 3;
plate_screw_off = 25/2;
plate_gear_hole_d = 13.5;
plate_gear_hole_l = 16;

bottom_screw_1_gap_y = 20;
bottom_screw_2_gap_y = 15;
bottom_screw_1_gap_x = 4;
bottom_screw_2_gap_x = 37;



bottom_t = 7;
front_t = 4;

motor_case_d = motor_d+front_t*2;

translate([motor_l,motor_case_d/2,motor_case_d/2])
rotate([0,90,0])
plate(plate_h=4);



difference(){
  motor_case();

  translate([0,front_t,bottom_t])
  motor();

  translate([0,front_t,bottom_t-3])
  bottom_screws();

  #translate([0,0,motor_case_d/2]) 
  cube([motor_l-18, motor_case_d,motor_case_d/2]);
}

module motor_case(){
  translate([0,motor_case_d/2,motor_case_d/2])
  rotate([0,90,0])
  cylinder(d=motor_case_d,h=motor_l);
  cube([motor_l,motor_case_d,motor_case_d/2]);
}

module bottom_screws(){
  translate([bottom_screw_1_gap_x,(motor_d-bottom_screw_1_gap_y)/2,0])
  {
    screw();
    translate([0,bottom_screw_1_gap_y,0])
    screw();
  }

  translate([bottom_screw_2_gap_x,(motor_d-bottom_screw_2_gap_y)/2,0])
  {
    screw();
    translate([0,bottom_screw_2_gap_y,0])
    screw();
  }
}


module screw(d1=8,d2=5, l2=20, l1=50){
  cylinder(d=d1,h=l1,$fn=fn/4);
  translate([0,0,-l2])
  cylinder(d=d2,h=l2,$fn=fn/4);
}

module motor(){
  translate([0,motor_d/2,motor_d/2])
  rotate([0,90,0])
  union(){
    // translate([0,0,plate_gear_hole_l])
    cylinder(d=motor_d,h=motor_l);
    cylinder(d=plate_gear_hole_d,h=motor_l+plate_gear_hole_l);
  }
}

module plate(plate_h=1.5, plate_off_x_plus=1,plate_off_y_plus=14){


  // translate([-29,0,18.5])
  rotate([0,0,180])

  difference(){
    linear_extrude(height = plate_h) 
    difference(){
      circle(d=motor_case_d);
      circle(d=plate_gear_hole_d);

      // START SCREW HOLES
      translate([plate_screw_off,0,0])
      circle(d=plate_screw_d,$fn=fn/8);

      translate([-plate_screw_off,0,0])
      circle(d=plate_screw_d,$fn=fn/8);

      translate([0,plate_screw_off,0])
      circle(d=plate_screw_d,$fn=fn/8);

      translate([0,-plate_screw_off,0])
      circle(d=plate_screw_d,$fn=fn/8);
      // END SCREW HOLES
    }

    translate([-motor_case_d/2,motor_case_d/2-plate_off_y_plus,plate_off_x_plus])
    cube([motor_case_d,motor_case_d,plate_h]);
  }
}

