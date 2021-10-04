use<../libs/Round-Anything/MinkowskiRound.scad>;
use<../libs/openscad_xels_lib/round.scad>;


MODE_E_GUITAR=0;
MODE_A_GUITAR=1;


// MODE = MODE_E_GUITAR;
MODE = MODE_A_GUITAR;



thickness = 12;

wall_gap = 24;
guitar_depth = MODE == MODE_E_GUITAR ? 42 : MODE == MODE_A_GUITAR ? 74 : 0;
inner_y = MODE == MODE_E_GUITAR ? 46 : MODE == MODE_A_GUITAR ? 54 : 0;


holder_x = 7;
holder_z = 5;


support = 30;
tilt = 13;
y_max = thickness + inner_y + thickness;

z_max = support + tilt + thickness + holder_z;

screw_d = 5.5;
screw_head_d = 12;
screw_head_l = 8;

res = 64;

// round = min([thickness,holder_x,holder_z])/2;
round = 4;
// round = thickness/2;
x_max = wall_gap + guitar_depth + holder_x;// + round;

/*
     _,-##
_,-#     |
        /
      /
    /
  /
/

*/
difference() {

  minkowskiRound(round,0)
  difference() {
    translate([ 0, y_max, 0 ]) {
      rotate([ 90, 0, 0 ]) {
        linear_extrude(y_max) {
          polygon(points = [
            [ 0, 0 ],
            [ -thickness, 0 ],
            [ -thickness, z_max - holder_z - tilt ],
            [ 0, z_max - holder_z - tilt ],
            [ x_max - holder_x, z_max - holder_z ],
            [ x_max - holder_x, z_max ],
            [ x_max, z_max ],
            [ x_max, z_max - thickness ],
          ]);
        }
      }
    }

    // inner
    translate([ wall_gap, thickness, -0.5*z_max ]) {
      rounded_cube_z([2*x_max,inner_y,2*z_max], r=15, center=false, fn=.11);
      // cube([ 2*x_max, inner_y, 2*z_max ]);
    }
  }
  // wall anti round
  translate([ -x_max, -1, -1 ]) cube([ x_max, y_max+2, z_max+2 ]);

  // screw
  translate([ wall_gap+0.12, y_max / 2, z_max / 2 ]) 
  // translate([1,0,0])
    rotate([ 0, -90, 0 ]) {
      cylinder(d1 = screw_head_d, d2 = 0, h = screw_head_l, $fn = res);
      cylinder(d = screw_d, h = x_max, $fn = res);
    }
}
