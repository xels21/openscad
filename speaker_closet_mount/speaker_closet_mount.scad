use <../libs/openscad_xels_lib/round.scad>;
use <../libs/openscad_xels_lib/geometry.scad>;

positions = 16;
scale_fac = 1.34;

// border_height=15; //prev. 35
border_height=12; //prev. 35
closet_height = 10; //prev. 20

closet_plus_border_height = border_height + closet_height;

inner_rot_r = 66;

speaker_sony();
// speaker();
// closet();

module closet() {
  difference() {
    translate([0, 0, -(closet_plus_border_height / 2) + border_height])
      rounded_cube([inner_rot_r * 2.2, inner_rot_r * 2.2, closet_plus_border_height], center=true, r=8, fn=32);
    #translate([0, 0, -border_height / 2])
      rounded_cube_x([110, inner_rot_r * 3, border_height], center=true, r=2);

    translate([0, 0, -border_height])
      linear_extrude(height=border_height * 2)
        rotate([0, 0, .5 / positions * 360])
          circle(r=inner_rot_r + .5, $fn=positions);
  }
}

module speaker_sony() {

  sony_tol = 1;
  sony_x1 = 75 + sony_tol;
  sony_x2 = 58 + sony_tol;
  sony_h = 68 + sony_tol;

  difference() {
    linear_extrude(height=border_height)
      rotate([0, 0, .5 / positions * 360])
        circle(r=inner_rot_r, $fn=positions);

    translate([0, 6, 6.2])
      rotate([10, 0, 0])
        linear_extrude(height=2*border_height)
          trapezoid(x1=sony_x1, x2=sony_x2, h=sony_h, r=0, center=true);
    // #scale([scale_fac, scale_fac, 1])
    // translate([-38.5, -29])
    // import("speaker_closet_mount.svg");
  }
}

module speaker() {
  difference() {
    linear_extrude(height=border_height)
      rotate([0, 0, .5 / positions * 360])
        circle(r=inner_rot_r, $fn=positions);

    translate([0, 0, 14])
      rotate([20, 0, 0])
        linear_extrude(height=border_height + 1)
          #scale([scale_fac, scale_fac, 1])
            translate([-38.5, -29])
              import("speaker_closet_mount.svg");
  }
}
