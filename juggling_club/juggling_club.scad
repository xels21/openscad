use <../libs/openscad_xels_lib/round.scad>;
use <../libs/openscad_xels_lib/square.scad>;
use <../libs/Round-Anything/MinkowskiRound.scad>;

/*

   ______       _______
 /      |      |       \
|       |      |       |
|       |      |       |
|       |      |       |
\       |______|       |
 ´-,________________,-´

*/

inner_d = 18;
outer_d = 33;
h = 22;
thickness = 4;

r1 = 5;
r2 = 10;

helper = 10;
helper_2 = 5;

count = 3;
offset_fac = 1.2;
inner_d_plus = inner_d + 2;
plugger_x = inner_d - 1;
temp_fac = 0.6;
string_d = 6;

mount_h = 8;
stemp_depth = 2;
r_mount = 3;

$fn = 64;

juggling_club_mount(dual_hole=true);
// juggling_club_mount_2d();

module juggling_club_mount(dual_hole=true) {
  difference() {
    minkowskiOutsideRound(r_mount, $fn=24)
      linear_extrude(height=mount_h)
        juggling_club_mount_2d(dual_hole=dual_hole);

    translate([0, 0, mount_h - stemp_depth])for (i = [0:count]) {
      // ACTUAL HOLDER
      translate(
        [
          sin(i / count * 360) * inner_d_plus * offset_fac,
          cos(i / count * 360) * inner_d_plus * offset_fac,
          0,
        ]
      )
        scale(1.1)
          translate([0, 0, h])
            rotate([180, 0, 0])
              juggling_club(w_hole=false);
    }
  }
}

module juggling_club_mount_2d(dual_hole = dual_hole) {

  difference() {
    // BASE
    circle(d=inner_d_plus * offset_fac * 3.5, $fn=64);
    // STRING
    if (dual_hole) {
      rotate([0, 0, -30]) {
        
          rounded_square([1.8*string_d,string_d], r=string_d*.49, fn=8, center=true);
        // translate([-string_d / 2, 0, 0])
          // circle(d=string_d, $fn=8);
        // translate([string_d / 2, 0, 0])
          // circle(d=string_d, $fn=8);
      }
    } else {
      //single_hole
      circle(d=string_d, $fn=16);
    }
    for (i = [0:count]) {

      // ACTUAL HOLDER
      translate(
        [
          sin(i / count * 360) * inner_d_plus * offset_fac,
          cos(i / count * 360) * inner_d_plus * offset_fac,
          0,
        ]
      )
        union() {
          // INNER
          circle(d=inner_d_plus, $fn=32);
          // OUTER (DISABLES - just for visualization)
          %circle(d=outer_d);
        }

      // "PLUGGER"
      translate(
        [
          sin(i / count * 360) * inner_d_plus * offset_fac * 1.45,
          cos(i / count * 360) * inner_d_plus * offset_fac * 1.45,
          0,
        ]
      )
        rotate(( -i / count * 360))
          #union() {
            rotate(90)
              square_different_y(size=[15, plugger_x], y_different=plugger_x + 18, y_off=6, center=true, do_left=true, do_left=false);
          }

      // CIRCLE CUT OUT
      translate(
        [
          sin((i / count * 360) + 60) * inner_d_plus * offset_fac * 2.5,
          cos((i / count * 360) + 60) * inner_d_plus * offset_fac * 2.5,
          0,
        ]
      )
        #circle(d=inner_d_plus * 3.2, $fn=64);
    }
  }
}

module juggling_club(w_hole = true) {
  rotate_extrude($fn=64) {
    juggling_club_2d(w_hole=w_hole);
  }
}

module juggling_club_2d(w_hole = true) {
  intersection() {
    square([outer_d, h]);
    difference() {
      union() {
        square([5, h]);
        translate([0, helper_2])
          rounded_sqare(x=outer_d / 2, y=h - helper_2, r=r1, fn=10, center=false);

        translate([-helper, 0])
          rounded_sqare(x=outer_d / 2 + helper, y=h, r=r2, fn=10, center=false);
      }
      if (w_hole) {
        translate([0, thickness])
          square([inner_d / 2, h - thickness]);
        square([1.5, thickness]);
      }
    }
  }
}
