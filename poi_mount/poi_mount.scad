use <../libs/openscad_xels_lib/round.scad>;
use <../libs/openscad_xels_lib/screw.scad>;
use <../libs/Round-Anything/MinkowskiRound.scad>;

// [10:500]
max_length = 120;

// [1:20]
string_gap = 8;

// [0:20]
min_poi_gap = 5;

// [1:30]
single_mount_t = 10;

// [1:30]
base_h = 7;

// [0:10]
rad = 3;

mount_x = 60;
mount_y_bottom_plus = 10;
mount_y_null = 15;
mount_y_top_holder_end_plus = 5;
mount_y_top_holder_minus = 5;
mount_y_top_base_support = 5;

mount_y_max = mount_y_bottom_plus + mount_y_null + mount_y_top_base_support - mount_y_top_holder_minus;

base_y_plus = 12;

max_y = mount_y_max + base_y_plus;

mount_pair_x_raw = single_mount_t + string_gap + single_mount_t;

mount_pair_x_pre = mount_pair_x_raw + min_poi_gap;

count = floor((max_length - min_poi_gap) / mount_pair_x_pre);

poi_gap = (max_length - count * mount_pair_x_raw) / (count - 1);

echo("");
echo("#################################");
echo("count: ", count);
echo("poi_gap: ", poi_gap);
echo("#################################");
echo("");

poi_mount();

module poi_mount() {
  difference() {
    minkowskiOutsideRound(rad) {
      translate([0, 0, -rad])
        cube([max_length, max_y, base_h + rad], center=false);
      all_mounts();
    }
    translate([0, 0, -rad])
      cube([max_length, max_y, rad], center=false);

    translate([1 / 5 * max_length, mount_y_max + base_y_plus / 2 - 1, base_h])
      #screw();

    translate([4 / 5 * max_length, mount_y_max + base_y_plus / 2 - 1, base_h])
      #screw();
  }
}

module all_mounts() {
  for (i = [0:count - 1]) {
    translate([(mount_pair_x_raw + poi_gap) * (i), 0, base_h])
      double_mount();
    // single_mount();
  }
}

module double_mount() {
  translate([2 * single_mount_t + string_gap, 0, 0])
    single_mount();
  translate([single_mount_t, 0, 0])
    single_mount();
}

module single_mount() {
  rotate([0, -90, 0])
    linear_extrude(height=single_mount_t)
      single_mount_2d();
}

module single_mount_2d() {
  polygon(
    points=[
      [0, 0],
      [0, mount_y_max],
      [mount_y_top_base_support, mount_y_max - mount_y_top_base_support],
      [mount_x - mount_y_top_holder_end_plus, mount_y_bottom_plus + mount_y_null],
      [mount_x - mount_y_top_holder_end_plus, mount_y_bottom_plus + mount_y_null + mount_y_top_holder_end_plus],
      [mount_x, mount_y_bottom_plus + mount_y_null + mount_y_top_holder_end_plus],
      [mount_x, mount_y_bottom_plus],
    ]
  );
  // square([single_mount_t, max_y + 10]);
}
