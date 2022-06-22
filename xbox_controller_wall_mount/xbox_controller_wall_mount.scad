use <../libs/Round-Anything/MinkowskiRound.scad>;
use <../libs/openscad_xels_lib/connector/vert_clip.scad>;

thickness = 8;

inner_w = 20;
outer_w = 60;
diff_w = outer_w - inner_w;

left = thickness / 2;      // left side
hold = thickness;          // lenght of the "middle" part
right = thickness;         // right side
hold_plus = thickness / 2; // amount of "hold" thats really holding
base = thickness;
tol = 0.1;
add = thickness / 2;

stab_support_h = 20;
xbox_height = 55;
height_plus = 35;

max_h = stab_support_h + xbox_height + height_plus;

stand_w = 55;

xbox_holder_h = 12;
xbox_holder_h_minus = 3;
xbox_holder_h_clip = 1;

xbox_down_w = 16;
xbox_down_rad = 2;

rad = 2;

max_w = thickness + stand_w + thickness;

points = [
  [ -2 * rad, 3.5 * thickness ],
  [ thickness * 1.7, thickness * 0.88 ],
  [ stand_w + thickness, stab_support_h ],
  [
    stand_w + thickness,
    stab_support_h + thickness + xbox_holder_h -
    xbox_holder_h_minus
  ],
  [ stand_w + xbox_holder_h_clip, stab_support_h + thickness + xbox_holder_h ],
  [ stand_w - xbox_holder_h_clip, stab_support_h + thickness + xbox_holder_h ],
  [ stand_w, stab_support_h + thickness + 0.4 * xbox_holder_h ],
  [ stand_w - xbox_down_w + xbox_down_rad, stab_support_h + thickness ],
  [
    stand_w - xbox_down_w - xbox_down_rad,
    stab_support_h + thickness +
    xbox_down_rad
  ],
  [ -rad, xbox_height + stab_support_h ],
  [ -2 * rad, max_h + 2 * rad ]
];

res = 64;

export_top = false;
export_mount = false;
export_bottom = false;

if (export_top) {
  top_mount();
}
if (export_mount) {
  xbox_controller_mount();
}
if (export_bottom) {
  bottom_mount();
}

module
bottom_mount()
{
  end_mount(is_top = false);
}
module
top_mount()
{
  end_mount(is_top = true);
}

module
end_mount(is_top = true)
{
  difference()
  {
    union()
    {
      // START HALF CIRCLE
      cube([ thickness, 2 * thickness, inner_w ]);
      translate([ 0, thickness * 2, inner_w / 2 ])
      {
        rotate([ 0, 90, 0 ]) linear_extrude(height = thickness)
        {
          intersection()
          {
            translate([ -inner_w / 2, 0 ]) square([ inner_w, inner_w ]);
            circle(r = inner_w / 2, $fn = res);
          }
        }
      }
      // END HALF CIRCLE
      if (is_top) {
        vert_clip_neg(height = inner_w,
                      left = left,
                      hold = hold,
                      hold_plus = hold_plus,
                      base = base,
                      tol = -tol,
                      add = add,
                      right = right);
      } else {
        mirror([ 0, 1, 0 ])
        {
          vert_clip_pos(height = inner_w,
                        left = left,
                        hold = hold,
                        hold_plus = hold_plus,
                        base = base,
                        tol = -tol,
                        add = add,
                        right = right);
        }
      }
    }
    // START SCREW
    union()
    {
      translate([ 0, thickness / 2 + inner_w / 2, inner_w / 2 ])
      {
        rotate([ 0, 90, 0 ])
        {
          cylinder(h = thickness, r = 2, $fn = res);
          translate([ 0, 0, 4 ])
            cylinder(h = thickness - 4, r1 = 2, r2 = 4, $fn = res);
        }
      }
    }
    // END SCREW
  }
}

module
xbox_controller_mount()
{
  intersection()
  {
    container();
    linear_extrude(outer_w)
    {
      xbox_controller_mount_2d();
    }
  }
}

module
container()
{
  translate([ 0, 0, diff_w ])
  {
    rotate([ 0, -90, -90 ])
    {
      linear_extrude(2 * max_h)
      {
        translate([ -diff_w, 0, 0 ])
        {
          polygon([[diff_w / 2, 0],
                   [0, max_w],
                   [outer_w, max_w],
                   [inner_w + diff_w / 2, 0]]);
        }
      }
    }
  }
}

module
xbox_controller_mount_2d()
{
  translate([ thickness, thickness, 0 ])
  {
    // UPPER CLIP
    translate([ -thickness, max_h, 0 ])
    {
      vert_clip_pos_2d(left = left,
                       hold = hold,
                       hold_plus = hold_plus,
                       base = base,
                       tol = -tol,
                       add = add);
    }

    // WALL_CONNECTOR
    translate([ 0, 2.5 * thickness, 0 ])
    {
      polygon([
        [ 0, 0 ],
        [ -thickness, 0 ],
        [ -thickness, max_h - 2.5 * thickness - tol ],
        [ 0, max_h - 2 * thickness ]
      ]);
    }

    // difference() {
    offset(rad)
    {
      offset(-rad)
      {
        polygon(points);
      }
    }

    // offset(1)
    // offset(-7)
    // polygon(points=points);

    // }

    translate([ -thickness, 2.5 * thickness, 0 ])
    {
      vert_clip_neg_2d(left = left,
                       hold = hold,
                       hold_plus = hold_plus,
                       base = base,
                       tol = -tol,
                       add = add,
                       right = right);
    }
  }
}

module
xbox_controller_mount_rounded()
{
  intersection()
  {
    container();
    linear_extrude(outer_w)
    {
      translate([ thickness, thickness, 0 ])
      {
        // UPPER CLIP
        translate([ -thickness, max_h, 0 ])
        {
          vert_clip_pos_2d(left = left,
                           hold = hold,
                           hold_plus = hold_plus,
                           base = base,
                           tol = -tol,
                           add = add);
        }

        // WALL_CONNECTOR
        translate([ 0, 2.5 * thickness, 0 ])
        {
          polygon([
            [ 0, 0 ],
            [ -thickness, 0 ],
            [ -thickness, max_h - 2.5 * thickness - tol ],
            [ 0, max_h - 2 * thickness ]
          ]);
        }

        // LOWER CLIP
        translate([ -thickness, 2.5 * thickness, 0 ])
        {
          vert_clip_neg_2d(left = left,
                           hold = hold,
                           hold_plus = hold_plus,
                           base = base,
                           tol = -tol,
                           tol = 0,
                           add = add,
                           right = right);
        }
      }
    }
  }

  minkowskiRound(2)
  {
    intersection()
    {
      container();
      linear_extrude(outer_w)
      {
        translate([ thickness, thickness, 0 ])
        {
          // difference() {
          offset(rad)
          {
            offset(-rad)
            {
              polygon(points);
            }
          }

          // offset(1)
          // offset(-7)
          // polygon(points=points);

          // }
        }
      }
    }
  }
}

module
helper_line_deg()
{
  translate([ 0, 90, 0 ])
  {
    rotate([ 0, 0, 42 ])
    {
      square([ 1, 100 ], center = true);
    }
  }
}