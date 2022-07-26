length = 29;
height = 25;
thickness = 6;
inner_h = 5;
inner_w = 4;

triangle_r = 5;

difference()
{
  linear_extrude(length) union()
  {
    difference()
    {
      circle(r = height, $fn = 3);
      translate([ -thickness - triangle_r, 0 ])
      {
        offset(triangle_r) offset(-triangle_r)
          circle(r = height + triangle_r, $fn = 3);
      }
    }
    translate([ -inner_h / 2 + height - thickness - triangle_r, 0 ])
      square([ inner_h, inner_w ], center = true);
  }

  translate([ -height *.2, -height/2, length / 2 ])
  {
    rotate([ 90, 0, 30 ])
#cylinder(d2 = 3, d1=6, h = 5, $fn = 32);

    // rotate([ -90, 0, 0 ]) cylinder(d = 6, h = height, $fn = 32);
  }
}