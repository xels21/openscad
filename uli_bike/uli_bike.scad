use <..\libs\Round-Anything\MinkowskiRound.scad>;

inner_d=8.35; // 1st ver. 8.1
thickness=5;
gap=21-4; //-correction
x_left_offset = 8;
x=20+x_left_offset+4*thickness+gap;
y=30+thickness;
z=inner_d+thickness*2;

res=64;

thin_mode();
// block_mode();

module thin_mode(){
    // inner_pipes();
    difference(){
        minkowskiOutsideRound(thickness+2)
        outer_cubes();
        inner_pipes();
    }
}

module block_mode(){
difference(){
    // cube([x,y,z/2]);
    
    // minkowskiOutsideRound(thickness)
    cube([x,y,z]);
    // translate([0,0,z/2])cube([x,y,z/2]);

    translate([0,inner_d/2+thickness,inner_d/2+thickness]) 
    inner_pipes();

}
}

module outer_cubes(){
    union(){
        //straight
        translate([0,-thickness-inner_d/2,-thickness-inner_d/2]) cube([x,inner_d+2*thickness,inner_d+2*thickness]);
        //orth
        translate([x_left_offset,inner_d,-thickness-inner_d/2]) cube([inner_d+2*thickness,y,inner_d+2*thickness]);
        //rot
        translate([x_left_offset+gap,inner_d*(0.82-0.4),-thickness-inner_d/2]) rotate([0,0,-35]) cube([inner_d+2*thickness,y*1.3,inner_d+2*thickness]);
    }
}

module inner_pipes(){
    
    union(){
        //straight
        rotate([0,90,0]) cylinder(d=inner_d,h=x*1.1,$fn=res);
        //orth
        translate([x_left_offset+inner_d/2+thickness,inner_d*0.6,0]) rotate([-90,0,0]) cylinder(d=inner_d,h=y*1.1,$fn=res);
        //rot
        translate([x_left_offset+inner_d+thickness+gap,inner_d*0.82,0]) rotate([-90,0,-35]) cylinder(d=inner_d,h=x,$fn=res);
    }
}