use <../libs/openscad_xels_lib/round.scad>;


w_raw=28;
l_raw=55;

w=w_raw+0.2;
l=l_raw+0.5;

lower_h=2;
upper_h=5;

h_sum = lower_h+upper_h;


usb_w=10;

side_w=3;
v_side_offset=2;

v_w=18;
v_h=5;


thickness=3;

tol=0.04;

outer_w=w +2*thickness;
outer_l=l +2*thickness;
outer_h=h_sum     +2*thickness;

case_bottom();

translate([0,w+thickness*3,upper_h-lower_h])
rotate([180,0,0])
case_top();


module case_bottom(){
    difference(){
        union(){
            translate([0,0,-lower_h/2])
            difference(){
                translate([0,0,-thickness/2])
                rounded_cube_z([l+2*thickness,w+2*thickness,lower_h+thickness],r=thickness/2,center=true);
                // cube([l+2*thickness,w+2*thickness,lower_h+thickness],center=true);
                cube([l,w,lower_h],center=true);

            }
            connector(tol);

            
        }
        usb();
        
        if (1){
            side(1);
            side(-1);
        }

        if(0){
            extrea_pins();
        }
    }
}

module case_top(){
    difference(){
        translate([0,0,upper_h/2])
        difference(){
            translate([0,0,thickness/2])
            rounded_cube_z([l+2*thickness,w+2*thickness,upper_h+thickness],r=thickness/2, center=true);
            // cube([l+2*thickness,w+2*thickness,upper_h+thickness],center=true);
            cube([l,w,upper_h],center=true);

        }
        connector(-tol);
        usb(reverse=true);
        if (1){
            side(1);
            side(-1);
        }

        if(1){
            extrea_pins();
        }
    }
}

module side(converter=1){
    translate([0,converter/2*(w-side_w),0])
    rounded_cube_z([l-2*v_side_offset,side_w,2*(upper_h+lower_h+thickness)], r=1, center=true);
    // cube([l-2*v_side_offset,side_w,2*(upper_h+lower_h+thickness)],center=true);
}



module extrea_pins(){
    translate([l/2-v_h/2,0,0])
    rounded_cube_z([v_h,v_w,2*(upper_h+lower_h+thickness)], r=v_h*0.49, center=true);
    // cube([v_h,v_w,2*(upper_h+lower_h+thickness)],center=true);
}

module usb(reverse=false){
    r=1.5;
    r_mov = reverse?-r:r;
    translate([(l+thickness)/2,0,upper_h/2+r_mov/2])
    rounded_cube_y([thickness,usb_w,upper_h+r], r=r, center=true);
    // cube([thickness,usb_w,upper_h],center=true);
}

module connector(tol){
    translate([0,0,upper_h/2])
    difference(){
        rounded_cube_z([l+thickness-tol*2,w+thickness-tol*2,upper_h],r=thickness/2,center=true);
        // cube([l+thickness-tol*2,w+thickness-tol*2,upper_h],center=true);
        cube([l,w,upper_h],center=true);
    }
}