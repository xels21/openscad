axis_inner_d = 5;
axis_thickness = 1.5;
axis_w = 26;

scale_fac=0.6;

axis_trans_z=4.8;
axis_trans_offset_y=6;

axis_front_x_=66.5;

res = 64;
// res = 8;

// difference(){
union(){
difference(){

    scale([scale_fac,scale_fac,scale_fac])
    // translate([-16,-68,-10])
    // translate([,100,12])
    translate([60,32,0])

    // translate([-4.8,1.5,-6])
    // rotate([-90,0,0])
    // union(){
    //     translate([0,0,-3])
    //     import("base.stl",convexity=3);
    //     mirror([0,0,1]) import("base.stl",convexity=3);
    // }

    translate([10.5,0,-6])
    scale(0.98)
    import("Octane_Fixed.stl",convexity=3);

    //rear model tire diff
    translate([15.5,-2.2,axis_trans_z])
    translate([0,33.9,0])
    rotate([-90,0,0])
    cylinder(d=20,h=8.9);

    translate([15.5,-2.2,axis_trans_z])
    rotate([-90,0,0])
    cylinder(d=20,h=8.9);

    //front model tire diff
    translate([axis_front_x_,0,axis_trans_z-1])
    translate([0,30.3,0])
    rotate([-90,0,0])
    cylinder(d=20,h=8);

    translate([axis_front_x_,0,axis_trans_z-1])
    rotate([-90,0,0])
    cylinder(d=20,h=8);



    // scale([scale_fac,scale_fac,scale_fac])
    // translate([-30,-68,0])
    // translate([60,32,12])
    // union(){
    //     import("Octane_B.stl",convexity=10);
    //     import("Octane_U.stl",convexity=10);
    // }

    //rear diff
    translate([15.5,-1,axis_trans_z])
    rotate([-90,0,0])
    cylinder(d=axis_inner_d+2*axis_thickness,h=axis_w*2,$fn=res);

    //front diff
    translate([axis_front_x_,0,axis_trans_z-1])
    rotate([-90,0,0])
    cylinder(d=axis_inner_d+2*axis_thickness,h=axis_w*2,$fn=res);
}

difference(){
    //rear solid
    translate([15.5,axis_trans_offset_y,axis_trans_z])
    rotate([-90,0,0])
    cylinder(d=axis_inner_d+2*axis_thickness,h=axis_w,$fn=res);
    //rear inner diff
    translate([15.5,0,axis_trans_z])
    rotate([-90,0,0])
    cylinder(d=axis_inner_d,h=axis_w*2,$fn=res);
}
difference(){
    translate([axis_front_x_,2.2+axis_trans_offset_y,axis_trans_z-1])
    rotate([-90,0,0])
    cylinder(d=axis_inner_d+2*axis_thickness,h=axis_w-4,$fn=res);

    translate([axis_front_x_,0,axis_trans_z-1])
    rotate([-90,0,0])
    cylinder(d=axis_inner_d,h=axis_w*2,$fn=res);
    }
}
