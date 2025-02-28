use <../libs/Round-Anything/MinkowskiRound.scad>;
use <../libs/openscad_xels_lib/connector/vert_clip.scad>;

thickness = 8;

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
ps4_holder_h = 16;
xbox_holder_h_minus = 3;
xbox_holder_h_clip = 1;

xbox_down_w = 16;
ps4_down_w = 30;
xbox_down_rad = 2;

rad = 2;

max_w = thickness + stand_w + thickness;



res = 64;

// export_top_hanger = true;
export_top_hanger = false;

// export_top = true;
export_top = false;

// export_mount = true;
export_mount = false;

export_mount_ps4 = true;
// export_mount_ps4 = false;

// export_bottom = true;
export_bottom = false;

inner_w = 20;
outer_w = export_mount_ps4 ? 70 /*PS4*/ : 60; /*XBOX*/
diff_w = outer_w - inner_w;

if (export_top_hanger) {
  top_hanger_mount();
}
if (export_top) {
  top_mount();
}
if (export_mount) {
  controller_mount(is_xbox=true);
}
if (export_mount_ps4) {
  controller_mount(is_xbox=false);
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
top_hanger_mount()
{
  end_mount(is_top = true, is_hanger=true);
}

module
top_mount()
{
  end_mount(is_top = true);
}

module
end_mount(is_top = true, is_hanger=false)
{
  difference()
  {
    union()
    {
      if (is_hanger) {
        hanger_w=59.5;
        hanger_l=25;
        translate([-(hanger_w+thickness),0,0]) 
        difference(){
          cube([hanger_w+2*thickness, hanger_l+thickness, inner_w]);
          translate([thickness,0,0]) 
          cube([hanger_w, hanger_l, inner_w]);
        }
        

      }else{
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
      }
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
    if(!is_hanger){
    // START SCREW
      union()
      {
        translate([ 0, thickness / 2 + inner_w / 2, inner_w / 2 ])
        {
          rotate([ 0, 90, 0 ])
          {
            cylinder(h = thickness, r = 2, $fn = res);
            translate([ 0, 0, 6 ])
              cylinder(h = thickness - 6, r1 = 2, r2 = 4, $fn = res);
          }
        }
      }
    // END SCREW
    }
  }
}

module
controller_mount(is_xbox=true)
{
  intersection()
  {
    container();
    linear_extrude(outer_w)
    {
      controller_mount_2d(is_xbox);
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
controller_mount_2d(is_xbox=true)
{
  down_w = is_xbox ? xbox_down_w : ps4_down_w;
  holder_h = is_xbox ? xbox_holder_h : ps4_holder_h;
  holder_h_fac=is_xbox ? 0.4 : 0.2;
  points = [
    [ -2 * rad, 3.5 * thickness ],
    [ thickness * 1.7, thickness * 0.88 ],
    [ stand_w + thickness, stab_support_h ],
    [
      stand_w + thickness,
      stab_support_h + thickness + holder_h -
      xbox_holder_h_minus
    ],
    [ stand_w + xbox_holder_h_clip, stab_support_h + thickness + holder_h ],
    [ stand_w - xbox_holder_h_clip, stab_support_h + thickness + holder_h ],
    [ stand_w, stab_support_h + thickness + holder_h_fac * holder_h ],
    [ stand_w - down_w + xbox_down_rad, stab_support_h + thickness ],
    [
      stand_w - down_w - xbox_down_rad,
      stab_support_h + thickness +
      xbox_down_rad
    ],
    [ -rad, xbox_height + stab_support_h ],
    [ -2 * rad, max_h + 2 * rad ]
  ];

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