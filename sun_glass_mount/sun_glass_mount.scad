use <..\libs\openscad_xels_lib\connector\vert_clip.scad>;
res=64;

z       =10;      //height
left    = 2;      //left side
hold    = 4;      //lenght of the "middle" part
right   =4;      //right side
hold_plus = 3;      //amount of "hold" thats really holding
base    =4;
tol     =0.13;
add     =2;


min_len = 50;

// sun_glass_top();
sun_glass_middle();
// sun_glass_mount();
// sun_glass_bottom();
// test_clip();


module sun_glass_mount(rad=1.5, side_cor=3, height = z){

    /***

       ___
      |   |
      |   |   __
x0|y1 |   |__| |
______|        |
               | (x4|y1)
         _____/
    ____/
__/    
(x0|y0)

    ***/


    x0=0;
    x1=16;
    x2=26;
    x3=35;
    x4=39;

    y0=0;
    y1=15;
    y2=22;
    y3=30;
    y4=40;
    y5=45;

    side_fin=rad*2+side_cor;

    points=[
        [x0,y0-(side_fin)],
        [x0+side_cor,y0],
        [x4,y2],
        [x4,y4],
        [x3,y4],
        [x3,y3],
        [x2,y3],
        [x2,y5],
        [x1,y5],
        [x1,y1+5],
        [x0+side_cor,y1],
        [x0,y1+side_fin],
    ];
    add_points=[
        [x0-(side_fin),y1+side_fin],
        [x0-(side_fin),y0-(side_fin)]
    ];

    out_points = concat(points,add_points);

linear_extrude(height)
difference(){
    offset(rad)
    offset(-rad)
    polygon(points=out_points);
    
    offset(1)
    offset(-5.3)
    polygon(points=points);

    polygon(points=[
        [x0,y5],
        [-x4,y5],
        [-x4,-y5],
        [-x0,-y5],
    ]);
}
}

module sun_glass_middle(){
    translate([base,4,0])
    sun_glass_mount();

    translate([0,min_len,0])
    vert_clip_pos(  height  = z,
                    left    = left,
                    hold    = hold,
                    hold_plus = hold_plus,
                    base    =base,
                    tol     =-tol,
                    add     =add);


    cube([base,min_len,z]);


    vert_clip_neg(  height  = z,
                    left    = left,
                    hold    = hold,
                    hold_plus = hold_plus,
                    base    =base,
                    tol     =-tol,
                    tol     =0,
                    add     =add,
                    right=right);

}








module sun_glass_bottom(){
    translate([0,-1/2*z,z/2])
    rotate([0,90,0])
    union(){
        cylinder(h=base,d=z,$fn=res);
        translate([-1/2*z,0,0]) cube([z,1/2*z,base]);
    }
    vert_clip_pos(  height  = z,
                    left    = left,
                    hold    = hold,
                    hold_plus = hold_plus,
                    base    =base,
                    tol     =-tol,
                    add     =add);
}

module sun_glass_top(){
    translate([0,z,z/2])
    rotate([0,90,0])
    difference(){
    union(){
        cylinder(h=base,d=z,$fn=res);
        translate([-1/2*z,-z,0]) cube([z,z,base]);
    }
    cylinder(h=z,d=3,$fn=res);
    translate([0,0,z/2+base-1],$fn=res)sphere(d=z);
    }
    vert_clip_neg(  height  = z,
                    left    = left,
                    hold    = hold,
                    hold_plus = hold_plus,
                    base    =base,
                    tol     =0,
                    add     =add,
                    right=right);
}

// vert_clip_neg();