arduino_w=18.5;
arduino_l=44.5;//43;
arduino_lower_h=3;
arduino_upper_h=4;

h_sum = arduino_lower_h+arduino_upper_h;


usb_w=8;

side_w=3;
v_side_offset=2;

v_w=8;
v_h=6;


arduino_thickness=2;

tol=0.05;

arduino_outer_w=arduino_w +2*arduino_thickness;
arduino_outer_l=arduino_l +2*arduino_thickness;
arduino_outer_h=h_sum     +2*arduino_thickness;

// arduino_case_bottom();

// translate([0,arduino_w+arduino_thickness*3,arduino_upper_h-arduino_lower_h])
// rotate([180,0,0])
// arduino_case_top();

PIN_TOP=1;
PIN_EXTRA_TOP=0;

module arduino_case_bottom(PIN_TOP){
    difference(){
        union(){
            translate([0,0,-arduino_lower_h/2])
            difference(){
                translate([0,0,-arduino_thickness/2])
                cube([arduino_l+2*arduino_thickness,arduino_w+2*arduino_thickness,arduino_lower_h+arduino_thickness],center=true);
                cube([arduino_l,arduino_w,arduino_lower_h],center=true);
            }
            connector(tol);

            
        }
        usb();
        
        if (PIN_TOP){
            side(1);
            side(-1);
        }

        if(PIN_EXTRA_TOP){
            extrea_pins();
        }
    }
}

module arduino_case_top(){
    difference(){
        translate([0,0,arduino_upper_h/2])
        difference(){
            translate([0,0,arduino_thickness/2])
            cube([arduino_l+2*arduino_thickness,arduino_w+2*arduino_thickness,arduino_upper_h+arduino_thickness],center=true);
            cube([arduino_l,arduino_w,arduino_upper_h],center=true);
        }
        connector(-tol);
        usb();
        if (!PIN_TOP){
            side(1);
            side(-1);
        }

        if(!PIN_EXTRA_TOP){
            extrea_pins();
        }
    }
}

module side(converter=1){
    translate([0,converter/2*(arduino_w-side_w),0])
    cube([arduino_l-2*v_side_offset,side_w,2*(arduino_upper_h+arduino_lower_h+arduino_thickness)],center=true);
}



module extrea_pins(){
    translate([-arduino_l/2+v_h/2,0,0])
    // translate([-arduino_l/2+v_h/2,0,-(arduino_upper_h+arduino_thickness)])
    cube([v_h,v_w,2*(arduino_upper_h+arduino_lower_h+arduino_thickness)],center=true);
}

module usb(){
    translate([(arduino_l+arduino_thickness)/2,0,arduino_upper_h/2])
    cube([arduino_thickness,usb_w,arduino_upper_h],center=true);
}

module connector(tol){
    translate([0,0,arduino_upper_h/2])
    difference(){
        cube([arduino_l+arduino_thickness-tol*2,arduino_w+arduino_thickness-tol*2,arduino_upper_h],center=true);
        cube([arduino_l,arduino_w,arduino_upper_h],center=true);
    }
}