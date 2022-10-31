length = 30;
height = 36;
thickness = 6;
inner_h = 7;
inner_w = 4;

triangle_r = 10;

// translate([4,0])
// square([43,4],center=true);

difference()
{
  linear_extrude(length) union()
  {
    difference()
    {
      circle(r = height + thickness, $fn = 3);
      // translate([ -thickness - triangle_r, 0 ])
      {
        offset(triangle_r) offset(-triangle_r) circle(r = height, $fn = 3);
      }
      translate([ -height * .8, 0 ])
        square([ height, height * 1.27 ], center = true);
    }
    translate([ inner_h / 2 + height - thickness - triangle_r, 0 ])
      square([ inner_h, inner_w ], center = true);
  }

  translate([ 0, -height * .55, length / 2 ])
  {
    rotate([ 90, 0, 30 ])
#cylinder(d2 = 3, d1 = 9, h = 5, $fn = 32);

    // rotate([ -90, 0, 0 ]) cylinder(d = 6, h = height, $fn = 32);
  }
}