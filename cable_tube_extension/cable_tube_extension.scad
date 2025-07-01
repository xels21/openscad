use <../libs/openscad_xels_lib/round.scad>;

mount_x = 40;
mount_y = 15;
mount_z = 6;

extend_xy_1 = 8;
extend_xy_2 = 20;
extend_z_raw = 40;
extend_z = extend_z_raw + mount_z;
extend_xy_z = 20;

hole_y = 5.5;
hole_x = 10.5;
hole_r = 1;


cable_tube_extension();
module cable_tube_extension() {
  difference() {
    translate([0, 0, -extend_z_raw]) {
      translate([0, 0, extend_z / 2])
        rounded_cube_xyz(
          [
            mount_x + 2 * extend_xy_1,
            mount_y + 2 * extend_xy_1,
            extend_z,
          ], r=6, center=true
        );

      difference() {
        rounded_cube_xyz(
          [
            mount_x + 2 * extend_xy_2,
            mount_y + 2 * extend_xy_2,
            extend_xy_z * 2,
          ], r=16, center=true, $fn=1
        );

        translate([0, 0, -extend_xy_z])
          cube(
            [
              mount_x + 2 * extend_xy_2,
              mount_y + 2 * extend_xy_2,
              extend_xy_z * 2,
            ], center=true
          );
      }
    }

    // HOLE
    rounded_cube_z([hole_x, hole_y, extend_z * 2], r=hole_r, center=true);

    translate([0,0,mount_z/2]) 
    cube(
      [
        mount_x,
        mount_y,
        mount_z,
      ], center=true
    );
  }
}
