use <../../libs/Round-Anything/MinkowskiRound.scad>;
use <../../libs/openscad_xels_lib/round.scad>;
height = 8;

holde_d=4;

res=64;

inner_sensor_d=7.5;
inner_sensor_h=3.5;

sensor_x=29.5;
sensor_y=14;

right_r=5;

left_holder_left=1.4;
left_holder_bottom=1.4;
left_holder_width=4;
left_holder_height=3.2;
left_holder_depth=1.4;

down_sensor = 2;
left_sensor = -sensor_x/2;



thickness = 4;

module gen_sensor(){
    intersection(){

        difference(){
            union(){
                minkowskiOutsideRound(3,1)
                cube([sensor_x+thickness*2,sensor_y+thickness*2,40],center=true);
                
                translate([0,0,height/2])
                import_stl("Ball_Guide.stl", convexity = 5);
            }
            
            translate([left_sensor,0,down_sensor])
            // scale([sensor_scale_fac,sensor_scale_fac,sensor_scale_fac])
            sensor();
        }
        translate([-500,-500,0])
        cube([1000,1000,height+6]);
    }
}

module sensor_mount_norm(wall=2){
    difference(){
        translate([-inner_sensor_d/2-wall,-(sensor_y+wall*2)/2,0])
        rounded_cube_z([sensor_x+wall*2,sensor_y+wall*2, 10], r=1, center=false);
        sensor_norm();
    }
}

module sensor_norm(){
    translate([-inner_sensor_d/2,0,inner_sensor_h])
    sensor();
}

module sensor(){
    union(){
        difference(){
            union(){
                translate([inner_sensor_d/2,0,-inner_sensor_h])
                cylinder(d=inner_sensor_d,h=inner_sensor_h, $fn=res);

                translate([0,-sensor_y/2,0])
                union(){
                cube([sensor_x-right_r,sensor_y,20]);
                translate([0,0,right_r])
                cube([sensor_x,sensor_y,20]);
                }

                translate([sensor_x-right_r,sensor_y/2,right_r])
                rotate([90,0,0])
                cylinder(h=sensor_y,r=right_r,$fn=res);
            }
            translate([left_holder_width/2+left_holder_left,0,left_holder_height/2+left_holder_bottom])
            union(){
                translate([0,sensor_y/2,0])
                minkowskiOutsideRound(0.5,1)
                cube([left_holder_width,left_holder_depth,left_holder_height],center=true);

                translate([0,-sensor_y/2,0])
                minkowskiOutsideRound(0.5,1)
                cube([left_holder_width,left_holder_depth,left_holder_height],center=true);
            }
        }
    }
}
