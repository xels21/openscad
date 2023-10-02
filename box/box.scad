use <../libs/openscad_xels_lib/round.scad>;
use <..\libs\MCAD\boxes.scad>

box_for_step_down_converter();

module box_for_step_down_converter(){
    box_plus_lid(x = 55, y = 21, z = 14, t = 1.3, rad = 1.5, cut_away = 8, $fn = 32);
}

module box_for_step_up_converter(){
    box_plus_lid(x = 40, y = 18, z = 10, cut_away = 9);
}

module box_plus_lid(x = 40, y = 18, z = 10, t = 1.3, rad = 1.5, lid_scale_fac = .97, cut_away = 9, $fn = 32)
{
    box(x, y, z, t, rad, cut_away);
    translate([ 0, y * 1.5 ]) scale(lid_scale_fac) lid(x + t, y + 2 * t, t);
}

module box(x, y, z, t, rad, cut_away)
{
    max_x = 2 * t + x;
    max_y = 4 * t + y;
    max_z = t + z + t + t;

    difference()
    {
        roundedCube([ max_x, max_y, max_z ], rad);
        translate([ t, 2 * t, t ]) cube([ x, y, z * 2 + t ]);
        translate([ t, t, t + z ]) lid(x + t, y + 2 * t, t);
        translate([ 0, (max_y - cut_away) / 2, t ]) rounded_cube_y([ max_x, cut_away, max_z ], r = rad, center = false);
    }
}

module lid(x, y, z)
{
    difference()
    {
        cube([ x, y, z ]);
        translate([ 2 * z, 0, 0 ]) cylinder(r = t, h = z);
        translate([ 2 * z, y, 0 ]) cylinder(r = t, h = z);
    }
    translate([ x - 1 * z, z, z ]) rotate([ -90, 0, 0 ]) cylinder(h = y - 2 * z, r = z);
}