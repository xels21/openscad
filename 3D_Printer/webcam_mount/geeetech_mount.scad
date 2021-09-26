use <webcam_mount.scad>
include <webcam_mount.scad>
use <..\..\libs\Poor_mans_openscad_screw_library\polyScrewThread_r1.scad>;

screw_gap = 33;
screw_top_d=5.2;
screw_bottom_d=3.0;
screw_top_h=2.5;

PI=3.141592;

step_offset=4;
step_h=4;
top_h=5;

offset=90;

res=64;

padding=3;

outer_x=screw_top_d/2 + padding  + screw_gap + padding;
outer_y=padding + screw_top_d + offset;

clip_screw_d_inner = 20;
clip_screw_h = 60;

screw_off=1;

// aligned = 0;         //left
// aligned = outer_x/2;    //centered
aligned = outer_x-(web_mount_d/2);  //right


mount();
// camera_adapter();

module camera_adapter(){
    camera_adapter_gap=6;

    // translate([10,0,0])
    // webcam_mount_2();

        difference(){
            // cylinder(d=web_mount_d+2*thickness,h=web_mount_d+2*thickness, $fn=res,center=true);
            translate([0,0,-webcam_outer_d*0.12])
            union(){
                cylinder(d=webcam_outer_d,h=webcam_outer_d/2, $fn=res, center=true);
                translate([(clip_screw_d_inner)/2,0,0])
                cube([clip_screw_d_inner,webcam_outer_d,webcam_outer_d/2], center=true);
                translate([(clip_screw_d_inner),0,0])
                cylinder(d=webcam_outer_d,h=webcam_outer_d/2, $fn=res, center=true);
            }
            // translate([0,0,web_mount_d/2+upper_tol])cube([web_mount_d+2*thickness,web_mount_d+2*thickness,web_mount_d],center=true);
            translate([0,0,web_mount_d/2-slice_offset*2])
            union(){
                cube([slice,web_mount_d+2*thickness,web_mount_d],center=true);
                cube([web_mount_d+2*thickness,slice,web_mount_d],center=true);
            }
            sphere(d=web_mount_d, $fn=res);

            translate([clip_screw_d_inner,0,-webcam_outer_d])
            screw(add_d=1.5);
        }

}

module screw(add_d=0){
    screw_thread(web_mount_d+2+add_d,   // Outer diameter of the thread
      4,   // Step, traveling length per turn, also, tooth height, whatever...
      55,   // Degrees for the shape of the tooth (XY plane = 0, Z = 90, btw, 0 and 90 will/should not work...)
      clip_screw_h,   // Length (Z) of the tread
      PI/2,   // Resolution, one face each "PI/2" mm of the perimeter, 
      0);  // Countersink style:
}



module mount(){


translate([outer_x/2,outer_y,step_h+top_h-webcam_stand/2])
if(false){
    webcam_mount_2();
}

if(true){

    
    translate([web_mount_d/2 + screw_off,outer_y,step_h+top_h-webcam_stand/2])
    screw();
  }


difference(){
    main_block_points=[[0,0]
        ,[0,step_offset + padding+screw_top_h/2]
        ,[0,outer_y]
        ,[web_mount_d/2+screw_off,outer_y+web_mount_d/2]
        ,[web_mount_d+2*screw_off,outer_y]
        ,[outer_x,step_offset + padding+screw_top_h/2]
        ,[outer_x,0]
        ];

    //main block
    union(){
        linear_extrude(step_h+top_h)
        polygon(points=main_block_points);
        translate([(web_mount_d+2*screw_off)/2,outer_y,0])
        cylinder(d=web_mount_d+2*screw_off, h=step_h+top_h, $fn=res);
    }

    linear_extrude(step_h+top_h)
    offset(3)
    offset(-10)
    polygon(points=main_block_points);

    // cube([padding*2 + screw_top_d/2*2 + screw_gap, padding + screw_top_d + offset, step_h+top_h]);
    //stepper diff
    cube([padding*2 + screw_top_d/2*2 + screw_gap, step_offset +padding+screw_top_h/2,step_h]);
    //under 'schraege''
    rotate([3.2,0,0])
    translate([0,0,-(step_h+top_h)])
    cube([outer_x, outer_y*2, step_h+top_h-1.5]);

    translate([padding+screw_top_h/2,padding+screw_top_h/2,step_h+top_h-1])
    screw_hole();

    translate([padding+screw_top_h/2+screw_gap,padding+screw_top_h/2,step_h+top_h-1])
    screw_hole();

    translate([outer_x/2,-outer_x/2+4,0])
    cylinder(d=outer_x, h=outer_y, $fn=res);

    }
}

module screw_hole(){
    cylinder(d=screw_top_d,h=screw_top_h,$fn=res);
    translate([0,0,-50])
    cylinder(d=screw_bottom_d,h=50,$fn=res);
}