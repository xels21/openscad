/*
     __--__
   /    |   \
 /       >    \  
/       |__v__ \
(___^___|      )
 \     <     /
   \____|___/

*/



// inner_r = 100; //big 
inner_r = 125/2; 

outer_wall = 5;
inner_wall = 4;

led_h = 10;
led_w = 2.2;

top_stamp_h1=1;
top_stamp_h2=1.7;
top_stamp_r_off1=2.5;
top_stamp_r_off2=1.5;

res = 256;

floor_h=2;
tol_top=0.1;

tol_inner_plate=0.1;

r_complete = inner_r+inner_wall+led_w+outer_wall;
h_complete = floor_h+led_h+top_stamp_h1+top_stamp_h2;

puzzle_peace_w = 15;
puzzle_peace_h = 3;
puzzle_peace_tol = 0.2;
puzzle_corn = 10;

inner_plate_h=2;

// with_arduino = false;
with_arduino = true;

// with_hole=false;
with_hole=true;

with_top_stamp=true;
// with_top_stamp=false;

arduino_rad_fac = 0.78;


// use <..\arduino_nano_case\arduino_nano_case.scad>;
include <..\arduino_nano_case\arduino_nano_case.scad>;

main();

// translate([0,0,h_complete-top_stamp_h1-top_stamp_h2])
// top_stamp_r_off(tol=0);


// rotate([180,0,0])
// intersection(){
    // top_stamp_r_off();
    // translate([-inner_r*2,-inner_r*2,0.6])
    // cube([inner_ r*4,inner_r*4,inner_r*4]);
   // // puzzle();
// }

module main(){
intersection(){
    union(){
        difference(){
            plate(with_top_stamp=with_top_stamp);
            if(with_arduino){
                translate([r_complete*arduino_rad_fac,r_complete*arduino_rad_fac,h_complete/2+arduino_lower_h+arduino_thickness])
                rotate([0,0,-45])
                cube([arduino_outer_l+1,arduino_outer_w+1,h_complete],center = true);

                translate([r_complete*arduino_rad_fac,r_complete*arduino_rad_fac,h_complete/2])
                rotate([0,0,-45])
                cube([arduino_outer_l,arduino_outer_w,h_complete],center = true);
            }
            if(with_hole){
                translate([0,0,h_complete/2])
                rotate([0,90,25])

                union(){
                    cable_d=2;
                    hole_d=5;
                    translate([-h_complete,-hole_d/4,0])
                    difference(){
                        cube([h_complete,cable_d,r_complete]);
                        cube([h_complete,cable_d,inner_r+inner_wall]);
                    }

                    difference(){
                        cylinder(h=r_complete,d=hole_d,$fn=res);
                        cylinder(h=inner_r+inner_wall,d=hole_d,$fn=res/4);
                    }
                }
            }
        }

        if(with_arduino){
            translate([r_complete*arduino_rad_fac,r_complete*arduino_rad_fac,arduino_lower_h+arduino_thickness])
            rotate([0,0,-45])// rotate([0,0,45])
            arduino_case_bottom();
            // arduino_nano_mount();
        }
    // plate(with_top_stamp=true);
    // top_stamp_r_off();
    // inner_plate();
    }

    
    // puzzle();
    // cube([r_complete,r_complete,h_complete]);
}
}

// module arduino_nano_mount(){
    // temp = 0.68;
    // translate([r_complete*temp,r_complete*temp,7])
    // rotate([0,90,45])
    // translate([4.25,5.5,0])
    // import_stl("Arduino-Nano-Mount.stl", convexity = 5); 
// }

module arduino_nano_simple(){
    translate([0,0,6.6/2])
    cube([20.5,45,6.6],center=true);
}

puzzle_points=[
        [0,0],                  //bottom - left

        [0,inner_r*1/5-puzzle_peace_tol],
        [puzzle_peace_w+puzzle_peace_tol,inner_r*1/5-puzzle_peace_tol-puzzle_peace_h],
        [puzzle_peace_w+puzzle_peace_tol,inner_r*2/5+puzzle_peace_tol+puzzle_peace_h],
        [0,inner_r*2/5+puzzle_peace_tol],

        [0,inner_r*3/5],
        [-puzzle_peace_w,inner_r*3/5-puzzle_peace_h],
        [-puzzle_peace_w,inner_r*4/5+puzzle_peace_h],
        [0,inner_r*4/5],

        [0,r_complete-puzzle_corn],
        [puzzle_corn,r_complete],         //top    - left
        [r_complete,r_complete],//top    - right
        [r_complete,-puzzle_corn],          //bottom - right
        [r_complete-puzzle_corn,0],          //bottom - right

        [inner_r*4/5+puzzle_peace_tol,0],
        [inner_r*4/5+puzzle_peace_tol+puzzle_peace_h,puzzle_peace_w+puzzle_peace_tol],
        [inner_r*3/5-puzzle_peace_tol-puzzle_peace_h,puzzle_peace_w+puzzle_peace_tol],
        [inner_r*3/5-puzzle_peace_tol,0],

        [inner_r*2/5,0],
        [inner_r*2/5+puzzle_peace_h,-puzzle_peace_w],
        [inner_r*1/5-puzzle_peace_h,-puzzle_peace_w],
        [inner_r*1/5,0],
    ];

module puzzle(){
    linear_extrude(h_complete*2)
    polygon(points=puzzle_points);
}

module plate(with_top_stamp=false){
    //floor
    linear_extrude(floor_h)
     circle(r=r_complete, $fn=res);
    // union()
    // difference(){
    //     circle(r=r_complete, $fn=res);
    //     intersection(){
    //         offset(-5)
    //         polygon(points=puzzle_points);
    //         circle(r=r_complete, $fn=res);
    //     }
    // }


    difference(){
        linear_extrude(h_complete)
        union() {
            //outer wall
            difference(){
                circle(r=r_complete, $fn=res);
                circle(r=r_complete-outer_wall, $fn=res);
            }

            //inner wall
            difference(){
                circle(r=inner_r+inner_wall, $fn=res);
                circle(r=inner_r, $fn=res);
            }
        }
        
        if(with_top_stamp){
            translate([0,0,h_complete-top_stamp_h1-top_stamp_h2])
            top_stamp_r_off(tol=tol_top);
        }
    }
}

module inner_plate(){
    linear_extrude(inner_plate_h)
    offset(-tol_inner_plate)
    circle(r=inner_r, $fn=res);
}

module top_stamp_r_off(tol=0){
    translate([0,0,top_stamp_h2])
    linear_extrude(top_stamp_h1)
    difference(){
        circle(r=r_complete-outer_wall+top_stamp_r_off1+tol, $fn=res);
        circle(r=inner_r+inner_wall-top_stamp_r_off1-tol, $fn=res);
    }

    translate([0,0,0])
    linear_extrude(top_stamp_h2)
    difference(){
        circle(r=r_complete-outer_wall+top_stamp_r_off2+tol, $fn=res);
        circle(r=inner_r+inner_wall-top_stamp_r_off2-tol, $fn=res);
    }
}