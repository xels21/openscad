include <../libs/MCAD/2Dshapes.scad>;

/*
|        ____
|      |    `-,
|      |       `,
|      |        \
|      |        |
|  ____|       ,'
| |________,-*
*/

all_h = 24;
all_d = 34;
all_r = all_d / 2;

string_d = 7;
string_r = string_d / 2;
string_h = 8;

knot_d = 16;
knot_r = knot_d / 2;
knot_h = all_h - string_h;

// $fn=16;
$fn=128;

// poi_knob();
poi_knob_led();


module poi_knob_led(){
  led_d=10;
  led_h=6;
  led_h_top = 2;
  led_h_bottom = 3;
  led_r_plus = 4;

  led_h_max = led_h_top + led_h + led_h_bottom;
  led_d_max = led_d + led_r_plus*2;

  pullout_helper = 3;

  difference(){
    cylinder(h = led_h_max,d = led_d_max);

    translate([0,0,led_h_bottom]) 
    linear_extrude(height = led_h) 
    union(){
      circle(d = led_d);
      translate([0,-led_d/2])
      square(size = [led_d_max,led_d]);
    }

    linear_extrude(height = led_h+led_h_bottom) 
    translate([-led_d/2,0])
    union(){
      circle(d = pullout_helper);
      translate([0,-pullout_helper/2])
      square(size = [led_d_max,pullout_helper]);
    }
  }

}

module poi_knob(){
  rotate_extrude() {
    poi_knob_2d();
  }
}
module poi_knob_2d()
{
    difference() {
      complexRoundSquare(size = [ all_r, all_h ],
        // rads1 = [ 5, 1 ],
        rads2 = [ 7, 7 ],
        rads3 = [ 10, 17 ],
        // rads4 = [ 0, 0 ],
        center = false);

      square(size = [string_r,all_h]);
      translate([0,string_h])
      complexRoundSquare(size = [knot_r,knot_h],
          rads1 = [ 0, 0 ],
          rads2 = [ 2, 2 ],
          rads3 = [ 0, 0 ],
          rads4 = [ 0, 0 ],
          center = false
      );
    }
    %cylinder(h=all_h, d=all_d);
}