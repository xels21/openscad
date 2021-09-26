
/*

 /|
| |
| |____|\
|       |
|-------|
|-------|
|  ____ |
| |   |/
| |
| |
 \|

 _____
|    |
|    |
|__|\|


___
|  |/|
|    |
|____|

*/

res=64;

big_d_hole_raw=8;
big_r_hole=big_d_hole_raw/2+0.2;

big_hole_thickness=3;

clip=1;
clip_offset=4;
inner_w=2;
inner_l_plus=6;

box_t_raw=2;
box_t=box_t_raw+0.3;

clip_gap = 2;

tol_perc_raw=4;

tol_perc=1+tol_perc_raw/100;

translate([30,0,0])
inner(r_hole=big_r_hole, hole_thickness=big_hole_thickness);
outer(r_hole=big_r_hole, hole_thickness=big_hole_thickness);

module outer(r_hole,hole_thickness){
    max_y=clip_offset+clip;
    max_x=r_hole+hole_thickness+inner_l_plus;

    difference(){
      rotate_extrude($fn=res)
      polygon(points=[
        [0,0],
        [0,max_y],
        [max_x-max_y,max_y],
        [max_x,0],
      ]);

      cylinder(r=r_hole+hole_thickness, h=max_y);

      scale([tol_perc,tol_perc,tol_perc])
      translate([0,0,-(inner_w+box_t)])
      inner(r_hole=r_hole, hole_thickness=hole_thickness, cut=false);
    }
}

module inner(r_hole, hole_thickness, cut=true){
  max_y=inner_w + box_t + clip_offset+clip;
  max_x=r_hole+hole_thickness+inner_l_plus;

  difference(){
    rotate_extrude($fn=res)
    polygon(points=[
      [r_hole,0],
      [r_hole,max_y],
      [r_hole+hole_thickness,max_y],
      [r_hole+hole_thickness+clip,max_y-clip],
      [r_hole+hole_thickness,max_y-clip],
      [r_hole+hole_thickness,inner_w],
      [max_x,inner_w],
      [r_hole+hole_thickness+inner_l_plus-inner_w,0],
    ]
      );

    if(cut){
      translate([-max_x,0,inner_w+box_t])
      cube([max_x*2,clip,max_y]);

      rotate([0,0,90])
      translate([-max_x,0,inner_w+box_t])
      cube([max_x*2,clip,max_y]);
    }
  }
}