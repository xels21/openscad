
use <../libs/Round-Anything/MinkowskiRound.scad>;
use <../libs/openscad_xels_lib/round.scad>;

windows_outside_height = 15;
windows_outside_t = 4;

window_top_w = 15; //version 1
// window_top_w = 17; //version 2
window_top_t = 6;

windows_inside_t = 7;
windows_inside_h = 30;
windows_inside_h_trans = 10;

string_d = 6;
string_plus = 6;
string_max = 2 * string_plus + string_d;

windows_inside_x_max = windows_inside_t + string_max;

// plant_window_hanger_2d();
plant_window_hanger_3d();

module plant_window_hanger_3d() {
  r1=3;
  r2=2;
  difference() {
    minkowskiOutsideRound(r1)
      linear_extrude(height=string_max)
        plant_window_hanger_2d();
        translate([-window_top_w, -windows_inside_h-r2]) 
    #rounded_cube_z([window_top_w, windows_inside_h, string_max], r=r2);
    translate([string_max / 2, window_top_t, string_max / 2])
    rotate([90, 0, 0])
    #cylinder(d=string_d, h=windows_inside_h + window_top_t, $fn=32);
  }
}
module plant_window_hanger_2d() {
  r1 = 2;
  r2 = .5;
  // difference() {
  // offset(r1)
  // offset(-r1)
  polygon(
    points=[
      // [0, 0],
      // [-window_top_w, 0],
      [-window_top_w, -windows_outside_height],
      [-window_top_w - windows_outside_t, -windows_outside_height],
      [-window_top_w - windows_outside_t, window_top_t],
      [windows_inside_t, window_top_t],
      [string_max, -windows_inside_h_trans],
      [string_max, -windows_inside_h],
      [0, -windows_inside_h],
    ]
  );
  // #translate([-window_top_w, -windows_inside_h - r2])
  // offset(r2)
  // offset(-r2)
  // square([window_top_w, windows_inside_h + r2]);
  // }
}
