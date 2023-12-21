use <..\libs\roundedcube.scad>;

x = 190;
y = 90;
z = 30;

r = 8;
t = 1.5;
res = 64;

x_max = t + x + t;
y_max = t + y + t;
z_max = t + z;

difference()
{
  roundedcube([ x_max, y_max, z_max + r ], center = false, radius = r);
  translate([ t, t, t ])
    roundedcube([ x, y, z + r ], false, r);
  translate([ 0, 0, z_max ])
    cube([ x_max, y_max, r ]);
}