web_mount_d=10.3;
upper_tol=3;
slice=1.6;
thickness = 3;

res=80;

helper_w=35;
helper_h=15;

webcam_outer_d=web_mount_d+2*thickness;
webcam_stand=10;

slice_offset=1.4;

module webcam_mount_1(){
    difference(){
        union(){
            sphere(d=webcam_outer_d, $fn=res);
            helper();
        }
        translate([0,0,web_mount_d/2+upper_tol])cube([web_mount_d+2*thickness,web_mount_d+2*thickness,web_mount_d],center=true);
        translate([0,0,web_mount_d/2-slice_offset])cube([slice,web_mount_d+2*thickness,web_mount_d],center=true);
        translate([0,0,web_mount_d/2-slice_offset])cube([web_mount_d+2*thickness,slice,web_mount_d],center=true);
        sphere(d=web_mount_d, $fn=res);
    }
}



module webcam_mount_2(){
    translate([0,0,webcam_stand]){
        difference(){
            // cylinder(d=web_mount_d+2*thickness,h=web_mount_d+2*thickness, $fn=res,center=true);
            union(){
                sphere(d=webcam_outer_d, $fn=res);
                translate([0,0,-webcam_stand])
                cylinder(d=web_mount_d,h=webcam_stand, $fn=res);
            }
            translate([0,0,web_mount_d/2+upper_tol])cube([web_mount_d+2*thickness,web_mount_d+2*thickness,web_mount_d],center=true);
            translate([0,0,web_mount_d/2-slice_offset])cube([slice,web_mount_d+2*thickness,web_mount_d],center=true);
            translate([0,0,web_mount_d/2-slice_offset])cube([web_mount_d+2*thickness,slice,web_mount_d],center=true);
            sphere(d=web_mount_d, $fn=res);
        }
    }
}



module helper(){
    translate([0,0,-(web_mount_d+2*thickness)/2])
    scale([helper_h,helper_w,1])
    rotate([0,0,45])
    cylinder(d1=1,d2=0,h=(web_mount_d+2*thickness),$fn=4);
}