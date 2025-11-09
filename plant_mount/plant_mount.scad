/*
___      __
|  \    /  \
|  |    |  |
|  |    |  |
|  |    |  |
|  |____|  |
|_________/

*/

plant_t = 10;
h = 20;
extrude = 15;

t = 5;
r = t / 2 - .1;
// r = 2.4;

max_x = t + plant_t + t;
may_y = h + t;

$fn = 32;

linear_extrude(height=extrude)
  difference() {
    offset(r) offset(-r)
        difference() {
          translate([-r, 0])
            square(size=[max_x + r, may_y]);
          translate([t, t])
            offset((plant_t/2-.1)) offset(-(plant_t/2-.1))
                square(size=[plant_t, may_y + r]);
        }
    translate([-r, 0])
      square(size=[r, may_y]);
  }
