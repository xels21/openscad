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
all_d = 38;
all_r = all_d / 2;

string_d = 7;
string_r = string_d / 2;
string_h = 8;

knot_d = 16;
knot_r = knot_d / 2;
knot_h = all_h - string_h;

// $fn=16;
$fn = 128;

led_d = 10;
led_h = 5.4;
led_switch_h = 6;
led_h_top = 1.5;
led_h_bottom = 1.5;
led_r_plus = 4;

led_h_max = led_h_top + led_h + led_h_bottom;
led_d_max = led_d + led_r_plus * 2;

pullout_helper = 3;

pin_hold_d = 1;
pin_hold_x = 3;
pin_hold_h = 3;

button_pusher_d = 5;
button_pusher_x = led_d + 4;
pin_tol=.2;

cut_tol = 0.4;

// translate([50, 0, 0])
  // poi_knob();
poi_knob(w_led=true);

// poi_knob_w_led();
// rotate([0, -90, 0])
// poi_knob_led();

module pin_hold() {
  linear_extrude(height=pin_hold_h)
    pin_hold_2d();
}
module pin_hold_2d(tol=0) {
  pin_hold_x = pin_hold_x + tol;
  pin_hold_d = pin_hold_d + tol;
  intersection() {
    circle(d=led_d_max + 2 * pin_hold_d);
    translate([-pin_hold_x / 2, -(led_d_max + 2 * pin_hold_d) / 2])
      square([pin_hold_x, led_d_max + 2 * pin_hold_d]);
  }
}

module pin_hold_2d_other_side(tol=0) {
  // translate([0, pin_hold_x / 2])
  square([led_d_max / 2 + pin_hold_d+tol, pin_hold_x+tol]);
}

module poi_knob_led() {

  difference() {
    union() {
      cylinder(h=led_h_max, d=led_d_max);

      // PIN HOLD
      pin_hold();

      // BUTTON PUSHER
      // translate([button_pusher_x/2-button_pusher_d/2,0,led_h_max]) 
      // cylinder(d=button_pusher_d-2,h=.2);
    }

    translate([0, 0, led_h_max - led_h_top])
      linear_extrude(height=led_h_top)
        difference() {
          roundedSquare([button_pusher_x + cut_tol, button_pusher_d + cut_tol], r=(button_pusher_d + cut_tol) * .49);
          // roundedSquare([button_pusher_x, button_pusher_d], r=button_pusher_d * .49);

          translate([-50 - button_pusher_x / 2 + button_pusher_d / 2, 0, 0])
            square([100, 100], center=true);
        }

    // CUTOUTS FOR PULL-OUT HELPERS
    translate([-led_d_max / 2, led_d_max / 2 - pullout_helper, led_h_max - pullout_helper])
      cube([led_d_max, pullout_helper, pullout_helper]);
    translate([-led_d_max / 2, -led_d_max / 2, led_h_max - pullout_helper])
      cube([led_d_max, pullout_helper, pullout_helper]);

    translate([2, -3 / 2, led_h_bottom])
      cube([led_d_max / 2, 3, led_switch_h]);

    // LED HOLDER
    translate([0, 0, led_h_bottom])
      linear_extrude(height=led_h)
        union() {
          circle(d=led_d);
          translate([0, -led_d / 2])
            square(size=[led_d_max, led_d]);
        }

    // BOTTOM PULLOUT HELPER
    linear_extrude(height=led_h + led_h_bottom)
      translate([-led_d / 2, 0])
        union() {
          circle(d=pullout_helper);
          translate([0, -pullout_helper / 2])
            square(size=[led_d_max, pullout_helper]);
        }
  }
  translate([0, 0, led_h_max - led_h_top + .238])
    rotate([0, -3, 0])
      linear_extrude(height=led_h_top)
        difference() {
          // roundedSquare([button_pusher_x + cut_tol, button_pusher_d + cut_tol], r=(button_pusher_d + cut_tol) * .49);
          roundedSquare([button_pusher_x, button_pusher_d], r=button_pusher_d * .49);

          translate([-50 - button_pusher_x / 2 + button_pusher_d / 2, 0, 0])
            square([100, 100], center=true);
        }
}

module poi_knob(w_led = false) {
  difference() {
    rotate_extrude() {
      poi_knob_2d(w_led=w_led);
    }
    if (w_led) {
      deg_length=45;
      #translate([0, 0, all_h - led_h_max])
        #union() {
          linear_extrude(led_h_max)
            pin_hold_2d(pin_tol);

          rotate([0, 0, 90-deg_length])
            union() {
              mirror([1, 0, 0])
                rotate_extrude(-deg_length)
                  pin_hold_2d_other_side(pin_tol);
              rotate_extrude(deg_length)
                pin_hold_2d_other_side(pin_tol);
            }
        }
      // translate([0,0,all_h-led_h_max])
      // poi_knob_led();
    }
  }
}
module poi_knob_2d(w_led = false) {
  knot_r = w_led ? led_d_max / 2+.2 : knot_r;
  difference() {
    complexRoundSquare(
      size=[all_r, all_h],
      // rads1 = [ 5, 1 ],
      rads2=[7, 7],
      rads3=[10, 17],
      // rads4 = [ 0, 0 ],
      center=false
    );

    square(size=[string_r, all_h]);
    translate([0, string_h])
      complexRoundSquare(
        size=[knot_r, knot_h],
        rads1=[0, 0],
        rads2=[2, 2],
        rads3=[0, 0],
        rads4=[0, 0],
        center=false
      );
  }
  cylinder(h=all_h, d=all_d);
  // %cylinder(h=all_h, d=all_d);
}
