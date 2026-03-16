bread_w = 22;
bread_h = 43;

hole_d_raw = 5;

gole_n = 3;
hole_gap = 13;

hole_padding = (bread_h-(gole_n-1)*hole_gap)/2;

margin=1;

blade_t=0.2;

t_base=4;
t=t_base+blade_t;

bread_lame(is_bottom=true);
translate([40,0,0])
bread_lame(is_bottom=false);


module bread_lame(is_bottom=true){
  if(is_bottom){
    base();
    holes(is_bottom=is_bottom);
  } else {
    difference(){
      base();
      holes(is_bottom=is_bottom);
    }
  }
}

module base(){
  linear_extrude(height=t_base/2)
  offset(margin, $fn=32)
  square([bread_w, bread_h], center=true);
  // #square([bread_w, bread_h], center=true);
}

module holes(is_bottom=true) {
  hole_d = is_bottom ? hole_d_raw : hole_d_raw + .1;

  cylinder(d=hole_d, h=t, $fn=64);
  translate([0, hole_gap, 0])
  cylinder(d=hole_d, h=t, $fn=64);
  translate([0, -hole_gap, 0])
  cylinder(d=hole_d, h=t, $fn=64);
}