









res = 128;
deg = 66.6;

dasha_pop_out();

module
dasha_pop_out()
{
  //somehow stand needs to be added afterwards..
  // cube([ 79.7, 64, 1 ]);
  translate([ 79.7, -22, 0 ])
  {
    rotate([ 0, -90, 0 ])
    {
      rotate([ 0, 0, 90 - deg ])
      {
        rotate_extrude(angle = deg, $fn = res)
        {
          translate([ 20, 82, 0 ])
          {
            rotate([ 0, 0, -90 ])
            {
              import("dasha.svg");
            }
          }
        }
      }
    }
  }
}