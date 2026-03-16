bread_w = 22;
bread_h = 43;

hole_d_raw = 5;

gole_n = 3;
hole_gap = 13;

hole_padding = (bread_h-(gole_n-1)*hole_gap)/2;

margin=1.5;

blade_t=0.2;

t_base=4;
t=t_base+blade_t;

bread_lame(is_bottom=true);
translate([30,0,0])
bread_lame(is_bottom=false);


module bread_lame(is_bottom=true){
  if(is_bottom){
    // base(is_bottom=is_bottom);
    difference(){
      linear_extrude(height=t)
      offset(margin, $fn=32)
      square([bread_w, bread_h-2*margin], center=true);
      translate([0, 0, t/2])
      blade(is_bottom=is_bottom);
    }
    holes(is_bottom=is_bottom);
  } else {
    difference(){
      blade(is_bottom=is_bottom);
      #holes(is_bottom=is_bottom);
    }
  }
}

module blade(is_bottom=true){
  bread_w_corr = is_bottom ? bread_w+.1 : bread_w ;

  translate([-bread_w_corr/2, -(bread_h)/2, 0])
  cube([bread_w_corr, bread_h, t/2+.001], center=false);
}

module holes(is_bottom=true) {
  hole_d = is_bottom ? hole_d_raw : hole_d_raw + .1;

  cylinder(d=hole_d, h=t, $fn=64);
  translate([0, hole_gap, 0])
  cylinder(d=hole_d, h=t, $fn=64);
  translate([0, -hole_gap, 0])
  cylinder(d=hole_d, h=t, $fn=64);
}