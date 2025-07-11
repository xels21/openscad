inner_d = 68;
inner_d_plus = 10;

outer_d = 180;

height = 60;
height_gap = 15;
height_min = 20;

ground_off_d = outer_d - height_gap;

$fn = 128;

difference() {
  union() {
    cylinder(h=height_min, d=outer_d);

    translate([0, 0, height_min])
      cylinder(h=height - height_min, d2=inner_d + inner_d_plus, d1=outer_d);
  }

  translate([0, 0, height_min])
    cylinder(h=height, d=inner_d);

  scale([1, 1, (2 * height_gap) / ground_off_d])
    sphere(d=ground_off_d);
}
