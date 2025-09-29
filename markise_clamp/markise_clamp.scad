/*

 ______________
|  _________   |
| |         |  |
| |         |  |
| |         |  |
| |         |  |
| |         |  |
| |         |  |
| |         |  |
| |        /  /
| |__    /  /
|____|  |_/

*/

x_max_small = 21;
y_max_small = 36;
x_2_small = 12;
y_2_small = 6;

x_max_big = 23.5;
y_max_big = 40.5;
x_2_big = 14;
y_2_big = 6.5;

tol = .8;

x_hold = 2.5;

length = 20;

r = 3.5;
t = 6;

linear_extrude(height=length)
  clamp_2d_small();
  // clamp_2d_big();

module clamp_2d_big() {
  clamp_2d(
    x_max=x_max_big + tol,
    y_max=y_max_big + tol,
    x_2=x_2_big,
    y_2=y_2_big,
    x_hold=x_hold,
    t=t,
    r=r
  );
}

module clamp_2d_small() {
  clamp_2d(
    x_max=x_max_small + tol,
    y_max=y_max_small + tol,
    x_2=x_2_small,
    y_2=y_2_small,
    x_hold=x_hold,
    t=t,
    r=r
  );
}

module clamp_2d(x_max, y_max, x_2, y_2, x_hold, t, r) {
  difference() {
    offset(t)
      clamp_2d_raw(x_max=x_max, y_max=y_max, x_2=x_2, y_2=y_2, x_hold=x_hold, r=r);
    clamp_2d_raw(x_max=x_max, y_max=y_max, x_2=x_2, y_2=y_2, x_hold=x_hold, r=r);

    translate([(x_hold), -.5 * y_max])
      #square([x_max - 2 * x_hold, y_max]);
  }
}

module clamp_2d_raw(x_max, y_max, x_2, y_2, x_hold, r) {
  offset(r)
    offset(-r)
      polygon(
        points=[
          [0, 0],
          [0, y_max],
          [x_max, y_max],
          [x_max, y_2],
          [x_2, 0],
        ]
      );
}
