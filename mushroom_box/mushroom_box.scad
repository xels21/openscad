use <../libs/openscad_xels_lib/round.scad>;
use <../libs/openscad_xels_lib/pattern.scad>;

include <../libs/dotSCAD/src/ptf/ptf_rotate.scad>;
include <../libs/dotSCAD/src/bezier_curve.scad>;
include <../libs/dotSCAD/src/rounded_extrude.scad>;





/*
   ____________
 ,*            *,
|               |
 -____________- 

*/



l = 110+1.5;
h = 28+0.5;
h2 = 24;  //height in the middle. used for holder


bottom_thickness=1.5;
thickness=1.5;
depth=10; //is 20

end_plus=2;
$fn = 64;

round_r=4;


// #cube([l,h,h],center=true);
// #cube([h2,h2,h2],center=true);
// form_2d(l,h);

close();
// close_w_holes();

module close_w_holes(){
  difference(){
    close();
    translate([0,0,-bottom_thickness*2]) 
    linear_extrude(bottom_thickness*2) 
    holes();
  }
}

module holes(){
  intersection() {
    translate([-l/2,-h/2,0]) 
    pattern_hexagon_2d(x_size = l, y_size = h, hex_size=8, gap=1.5, height=10);
    form_2d(l-2*round_r,h-2*round_r);
  }
}

module close(){
  translate([0,0,-bottom_thickness])
  linear_extrude(height = bottom_thickness)
  form_2d(l+2*end_plus,h+2*end_plus);

  difference() {
    linear_extrude(height = depth, scale=[1.01,1.05])
    form_2d(l,h);

    translate([0,0,round_r])
    rotate([180,0,0])
    linear_extrude(height = round_r, scale=[.95,.8])
    form_2d(l-2*thickness,h-2*thickness);
    // rounded_extrude([l*1.1, h*0.8], round_r=round_r)
    // form_2d(l-2*thickness-2*round_r,h-2*thickness-2*round_r);

    translate([0,0,round_r])
    linear_extrude(height = depth, scale=[1.01,1.05])
    form_2d(l-2*thickness,h-2*thickness);
  }
}

module form_2d(l,h){
  radius = h/2;
  leng = l-h;
  t_step = 0.05;
  tangent_angle = 20;

  two_connected_circles(
      radius, leng, tangent_angle, t_step
  );
}

module two_connected_circles(radius, dist, tangent_angle, t_step) {
    half_dist = dist / 2;

    p1 = ptf_rotate([0, -radius], tangent_angle) + [-half_dist, 0];
    p2 = ptf_rotate([radius * tan(tangent_angle), -radius], tangent_angle) + [-half_dist, 0];

    p3 = [-p1[0], p1[1]];
    p4 = [-p2[0], p2[1]];

    curve_pts = bezier_curve(t_step, [p1, p2, p4, p3]);
    leng_pts = len(curve_pts);

    upper_curve_pts =
        [
            for(i = [0:leng_pts - 1])
                curve_pts[leng_pts - i - 1]
        ];
    lower_curve_pts =
        [
            for(pt = curve_pts)
                [pt[0], -pt[1]]
        ];
   
    translate([-half_dist, 0])
        circle(radius);
    translate([half_dist, 0])
        circle(radius);
       
    polygon(
        concat(
            upper_curve_pts,
            lower_curve_pts
        )
    );
}

module first_try(){
  translate([0,0,-thickness/2])
  rounded_cube_z([l+2*end_plus,h+2*end_plus,thickness],r=(h+2*end_plus)/2-0.1,center=true, fn=res);
  translate([0,0,depth/2]) 

  difference() {
    rounded_cube_z([l,h,depth],r=h/2-0.1,center=true, fn=res);
    rounded_cube_z([l-2*thickness,h-2*thickness,depth],r=(h-2*thickness)/2-0.1,center=true, fn=res);
  }
}
