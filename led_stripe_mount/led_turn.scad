use <../libs/Round-Anything/MinkowskiRound.scad>;
use <../libs/dotSCAD/src/bend.scad>;

led_w=10.2;
led_h=2.5;

thickness=1.5;
bottom_thickness=0.8;

holder = 2.5;

h=50;



res=256;

rad_l=50;

rot_plus=8;
rot_plus_corr=2;
poly_corr_fac=0.675;


straight(80);

// complete();

module straight(length){
  rotate([90,0,0])
  linear_extrude(length)
  mount_part(internal_led_h = led_h*0.6, internal_holder = holder*0.5, bottom_plus=1);
}

module complete(){
  max_x=thickness+led_w+thickness;
  max_y=bottom_thickness + led_h+thickness;

  difference(){
    union(){
    points=[
        [0,0,0],//0
        [-h,rad_l*poly_corr_fac-max_x,0],//1
        [-h,rad_l*poly_corr_fac,0],//2
        [0,rad_l*0.55,0],//3
        [rad_l*0.55,0,0],//4
        [rad_l*poly_corr_fac,-h,0],//5
        [rad_l*poly_corr_fac-max_x,-h,0],//6
        [0,rad_l*0.55,max_x],//7
        [rad_l*0.55,0,max_x],//8
    ];

    polyhedron(
      points = points,
      faces =[
            [0,1,7],
            [0,1,3],
            [0,3,7],
            [1,3,7],
      ]
    );

    polyhedron(
      points = points,
      faces =[ //1=6  //3=4  //7=8
            [0,6,8],
            [0,6,4],
            [0,4,8],
            [6,4,8],
      ]
    );

    linear_extrude(bottom_thickness)
    polygon(points=[
      [0,0],
      [-h,rad_l*poly_corr_fac-max_x],
      [-h,rad_l*poly_corr_fac],
      [0,rad_l*0.6],
      [rad_l*0.6,0],
      [rad_l*poly_corr_fac,-h],
      [rad_l*poly_corr_fac-max_x,-h],
    ]);

    rotate_extrude(angle = 90, $fn=res/4, convexity = 2)
      polygon(points=[
        [0,0],
        [rad_l*0.55,max_x],
        [rad_l*0.55,0],
      ]);

    bend(size = [rad_l,max_x,max_y], angle = 90, frags = 90)
    translate([0,(thickness+led_w+thickness)/2,0])
    rotate([90,0,90])
    linear_extrude(height = rad_l, convexity = 10)
    mount_part();

    rotate([rot_plus,0,0])
    translate([rad_l*0.54,-h*0.5+rot_plus_corr/2,max_x/2])
    rotate([90,90,0])
    linear_extrude(height = h+rot_plus_corr, convexity = 10, twist = -90, center=true, $fn=res)
    mount_part();

    rotate([0,-rot_plus,0])
    translate([-rad_l*0.5+rot_plus_corr/2,h*0.54,max_x/2])
    rotate([-90,180,-90])
    linear_extrude(height = h+rot_plus_corr, convexity = 10, twist = 90, center=true, $fn=res)
    mount_part();
  }

  translate([0,0,-50])
  cube([100,100,100],center=true);
}
}

module mount_part_complete(h=50){
  translate([led_w*0.81,led_w*0.65,0]){
    translate([0,0,3/4*h])
    linear_extrude(height = h/2, convexity = 10, twist = 90, center=true)
    rotate([0,0,90])
    mount_part();

    translate([0,0,h/4])
    linear_extrude(height = h/2, convexity = 10, twist = -90, center=true)
    mount_part();
  }
}



module mount_part(internal_led_h = led_h, internal_holder = holder, bottom_plus=0){
  mount_half_part(internal_led_h = internal_led_h, internal_holder = internal_holder, bottom_plus=bottom_plus);
  mirror([1,0,0])
  mount_half_part(internal_led_h = internal_led_h, internal_holder = internal_holder, bottom_plus=bottom_plus);
}

module mount_half_part(internal_led_h = led_h, internal_holder = holder, bottom_plus=0){
  max_x=thickness+led_w+thickness;
  max_y=bottom_thickness + internal_led_h + thickness;

  translate([-max_x/2,0,0])
  polygon(points=[
    [-bottom_plus,0],
    [0,max_y-thickness],
    [internal_holder/2+thickness,max_y],
    [thickness+internal_holder,max_y],
    [thickness+internal_holder,max_y-thickness],
    // [thickness+internal_holder-1,max_y-thickness],
    [thickness,max_y-thickness-internal_holder/2],
    [thickness,max_y-thickness],
    [thickness,bottom_thickness],
    [max_x/2,bottom_thickness],
    [max_x/2,0],
  ]);

}
