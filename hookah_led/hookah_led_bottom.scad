include <parameter.scad>
use <..\libs\Round-Anything\MinkowskiRound.scad>;
use <..\libs\openscad_xels_lib\switch_case.scad>;      //to get functions
include <..\libs\openscad_xels_lib\switch_case.scad>;  //to get variables


fast_mode = true;
// fast_mode = false;


controller_x = 63;//62
controller_y = 77;//76
controller_z = 35;

controller_rad=6;

controller_left=-25;
controller_offset=5;
bat_left=43;
bat_y_offset=28;

thickness = 5;


bat_x=31;
bat_z=31;
bat_y=120;

bottom_h=3;


complete_h = max(bat_z,controller_z);
complete_step_h = hookah_outer_border_step_h+hookah_inner_border_step_h;//

sup_holder_w=10;


// translate([-2/5*hookah_d,hookah_d/3,0]) 
// rotate([0,0,2*180/6])
// gen_out_max();

// gen_support();
// translate([-switch_width/2,0,0])



module switch_stamp(){
    translate(
        [ hookah_d/6//-switch_width/2
        ,-hookah_d/2
        ,(0.5*(complete_h+hookah_outer_border_step_h-(switch_length+2*switch_stablizier_length)))
        ])
    // union(){
        switch_complete(25);
        // switch_helper_depth=10;
        // translate([0,switch_helper_depth,0])cube([switch_width,switch_helper_depth,switch_length]);
    // }
}

module sup_holder(){
    difference(){
        union(){
            translate([0,0,-bottom_h]) cylinder(d=sup_holder_w*3,h=complete_h+bottom_h,$fn=8);
            translate([0,0,complete_h])cylinder(d1=sup_holder_w*3,d2=0,h=complete_step_h,$fn=8);
        }
        translate([-sup_holder_w/2,-sup_holder_w/6,0])cube([sup_holder_w,sup_holder_w,complete_h+complete_step_h]);
        }
}

// cylinder(d=150,h=40);
// gen_out_max();
// switch_stamp();
// pot_stamp();
all();
// button_stamp();

module button_stamp(){

    button_w=6;
    button_depth=5;

    cylinder_helper = 15;

    leg_d=1.6;

    translate(
        [ 0//-switch_width/2
        ,-hookah_d/2+button_depth
        ,(0.5*(complete_h+hookah_outer_border_step_h))
        // ,bottom_h+(0.5*(complete_h+hookah_outer_border_step_h-(switch_length+2*switch_stablizier_length)))
    ])

union(){

translate([0,0,0])rotate([-90,0,0])cylinder(h=25,d=cylinder_helper,$fn=res);

translate([-button_w/2,-button_depth,-button_w/2])union(){
    cube([button_w,button_depth,button_w]);
    
    translate([0,0,leg_d/2])rotate([-90,0,0])cylinder(d=leg_d,h=button_depth, $fn=res);
    translate([0,0,button_w-(leg_d/2)])rotate([-90,0,0])cylinder(d=leg_d,h=button_depth, $fn=res);
    translate([button_w,0,leg_d/2])rotate([-90,0,0])cylinder(d=leg_d,h=button_depth, $fn=res);
    translate([button_w,0,button_w-(leg_d/2)])rotate([-90,0,0])cylinder(d=leg_d,h=button_depth, $fn=res);
}
}
}

module pot_stamp(){
    pot_d=7;
    pot_t=5;
    pot_out_d=17;
    pot_out_h=20;

    // translate([0,0,0])

    translate(
        [ -hookah_d/5//-switch_width/2
        ,-hookah_d/2+pot_d-2
        ,(0.5*(complete_h+hookah_outer_border_step_h))
        // ,bottom_h+(0.5*(complete_h+hookah_outer_border_step_h-(switch_length+2*switch_stablizier_length)))
    ])
        
    union(){
        rotate([-90,0,0])
        union(){
            translate([0,0,-pot_t]) cylinder(d=pot_d,h=pot_t,$fn=res);
            cylinder(d=pot_out_d,h=pot_out_h,$fn=res);
        };
        // translate([0,-pot_out_h,-pot_out_d/2+1]) 
        translate([0,0,-(pot_out_d-2)/2])
        cube([29,pot_out_h,pot_out_d-2]);
    }
}

module all(){
difference(){

union(){

//controller
intersection(){
    gen_out_max();
    translate([controller_left,controller_offset,complete_h/2])
    difference(){
        cube([controller_x+thickness*2,controller_y+thickness*2,complete_h],center=true);
        minkowskiOutsideRound(controller_rad)
        translate([0,0,controller_rad/2]) cube([controller_x,controller_y,complete_h+controller_rad],center=true);
    }
}

//bat
intersection(){
    gen_out_max();
    difference(){
        bat_outer();
        bat_inner();
    }
}

//bottom

translate([0,0,-bottom_h])
cylinder(h=bottom_h,d=hookah_d,$fn=res);

//bottom

difference(){
    translate([0,0,-bottom_h])
    gen_out_max();
    gen_in_max();
}

difference(){
    cylinder(h=complete_h+hookah_inner_border_step_h,d=hookah_d-hookah_outer_border_step_w*2,$fn=res);
    cylinder(h=complete_h+hookah_inner_border_step_h,d=hookah_d-hookah_outer_border_step_w*2-hookah_inner_border_step_w*2,$fn=res);
}

gen_support();

}

//correcture:


//controller clean
translate([-50,36,0])
cylinder(h=complete_h,d=16,$fn=res);

//controller cable
controller_cable(50);

bat_inner();

//switch
switch_stamp();

//pot
pot_stamp();

//button
button_stamp();

}
}


module gen_support(){
    xInvArr=[1,-1,-1,1];
    yInvArr=[1,1,-1,-1];
    rotInvArr=[-1,1,-1,1];
    difference(){
        for(i=[0:3]){
            // translate([xInvArr[i]*2/5*hookah_d,yInvArr[i]*hookah_d/3,0]) 
            translate([xInvArr[i]*44/100*hookah_d,yInvArr[i]*hookah_d*26/100,0]) 
            rotate([0,0,(i+3)*90+45+(15*rotInvArr[i])])
            sup_holder();
        }
        gen_out_max();
        bat_inner();
    }
}

module gen_out_max(){
    cylinder(h=bottom_h+complete_h+hookah_outer_border_step_h+hookah_inner_border_step_h,d=hookah_d+23,$fn=6);
}

module gen_in_max(){
    cylinder(h=complete_h+hookah_outer_border_step_h+hookah_inner_border_step_h,d=hookah_d-hookah_outer_border_step_w*2+tol*2,$fn=res);
}

module controller_cable(h){
    translate([controller_left,controller_offset-controller_rad,complete_h/2])
        translate([controller_x/4,controller_y/2,-2])
        rotate([270,54,0])
        cylinder(h=h,d=controller_x/2,$fn=5);
}


module bat_inner(){
     translate([bat_left,bat_y_offset,bat_z/2])
    union(){
        translate([0,-1/2*bat_y,2/9*bat_z])
        rotate([270,180/6,0])
        cylinder(h=bat_y,d=bat_x*1.15,$fn=6);
        
        cube([bat_x,bat_y,bat_z],center=true);
    }
}

module bat_outer(){
    translate([bat_left,bat_y_offset,complete_h/2])
    cube([bat_x+thickness*2,bat_y+thickness*2,complete_h],center=true);
}

