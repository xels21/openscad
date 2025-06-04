/*

     ,----,
  ,*       *.
 |           |
 |           |
 |           |
 |           |
 |           |
 |           |
 |           |
 |           |
 |___________|
*/

plate=40;

x_plate = 0.5;
x_gap = 2.0;
x_holder = 2.0;

x_max = x_plate + x_gap + x_holder;

y_holder =  15;
y_inner = 7;

z_holder = 16;
z_plus = 5;
z_max = z_holder + z_plus;

$fn = 64;

holder();
// holder_neg();

module holder_neg(){
  translate([0,0,x_plate])
  linear_extrude(x_gap) 
  difference() {
    translate([-(y_holder/2),z_plus,0])
    square([y_holder,z_holder]);

    translate([-(y_inner/2),z_plus,0])
    square([y_inner,z_holder]);

    translate([0,5,0])
    #circle(d=10 ,$fn=6);
  }
}

module holder(){
  difference(){
    linear_extrude(x_max) {
      translate([0,z_max-(y_holder/2),0])
      circle(d=y_holder);
      translate([-(y_holder/2),0,0])
      square([y_holder,z_max-y_holder/2]);
    }
  
  holder_neg();
  }

  translate([-plate/2,-plate/2+z_max/2,0])
  cube([plate,plate,x_plate]);

}
