









res = 128;
// deg = 66.6;

four_pop_out();
two_pop_out();
translate([18,11.43,0])
#cube([7,6.65,1.5]);
rot_off=0;

module x_pop_out(svg_path, deg){
    //somehow stand needs to be added afterwards..
  // cube([ 79.7, 64, 1 ]);
  // translate([ 79.7, -22, 0 ])
  translate([ 0, 0, 0 ])
  {
    rotate([ 0, -90, 0 ])
    {
      rotate([ 0, 0, 90 - deg ])
      {
        rotate_extrude(angle = deg, $fn = res)
        {
          translate([ 0, 0, 0 ])
          {
            rotate([ 0, 0, -90 ])
            {
              import(svg_path);
            }
          }
        }
      }
    }
  }
}

module four_pop_out()
{
  x_pop_out(svg_path = "4.svg", deg = 50);
}

module two_pop_out()
{
  x_pop_out(svg_path = "2.svg", deg = 60);
}