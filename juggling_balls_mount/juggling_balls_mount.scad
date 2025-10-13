use <../libs/openscad_xels_lib/round.scad>;
use <../libs/openscad_xels_lib/screw.scad>;
use <../libs/Round-Anything/MinkowskiRound.scad>;

// [10:500]
max_wall_length = 120;

ball_amount = 3;
thickness = 5;
ball_d_raw = 65;
ball_d = ball_d_raw + thickness;

inner_x = ball_d * ball_amount;

inner_h = 15;

screw_helper_z = 15;

$fn = 64;

juggling_balls_mount();

module juggling_balls_mount() {
  difference() {
    union() {
      minkowskiOutsideRound(thickness/2-.1, $fn=32){
      translate([-max_wall_length / 2, ball_d / 2 - thickness, -inner_h])
        rounded_cube_x([max_wall_length, thickness, screw_helper_z + inner_h], r=inner_h - 1, center=false);
      translate([-max_wall_length / 2, 0, -inner_h])
        cube([max_wall_length, ball_d / 2, inner_h], center=false);
      }
      rotate([0, 0, 90])
        plate_inner();
    }
    difference() {
      translate([0, 0, 1.5 * thickness])
        rotate([0, 0, 90])
          #plate_inner();
      translate([0, 0, inner_h / 2])
        cube([ball_d * ball_amount + 2 * thickness, ball_d + 2 * thickness, inner_h], center=true);
    }
    translate([-max_wall_length / 3, ball_d / 2 - thickness, screw_helper_z / 2.5])
      rotate([90, 0, 0])
        screw();

    translate([max_wall_length / 3, ball_d / 2 - thickness, screw_helper_z / 2.5])
      rotate([90, 0, 0])
        screw();
  }
}

module plate_inner() {
  scale([ball_d, ball_d, inner_h * 2])
    rotate([-90, 0, 0])
      rotate_extrude(180) {
        combined_circles_norm();
      }
}

module combined_circles_norm(count = ball_amount) {
  intersection() {
    union() {
      translate([0, -1])
        circle(d=1);
      translate([0, 1])
        circle(d=1);
      square([1, (count - 1) * 1], center=true);
    }
    translate([0, -1 * count / 2, 0])
      square([1 / 2, 1 * count]);
  }
}
