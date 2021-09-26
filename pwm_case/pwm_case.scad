

/*
       ________________
 _____|         ___    |
|_____|        | | |   |
      |        | | |   |
      |________|_|_|___|

*/
height = 17;
width = 32;
depth = 25;

pin_h=2.5;

thickness = 2;

twist_d = 7;
twist_y=7;
twist_z=7;
real_twist_z=twist_z+pin_h;

cable_width=3.5;


//getOnlyBottom();
getOnlyTop();




cable_enter_h_accurately=-1.5;//3.3;
cable_enter_h=height+thickness*2+cable_enter_h_accurately;
cable_enter_w=7;
screw_h=12;

module cable_enter_shell(){
    scale([2,1,1]) rotate(22.5,0,0) cylinder(h = 7, d1=cable_enter_h,d2=cable_width*3, $fn=8);
}

module cable_enter_holes(){
    translate([cable_width,0,0]) cylinder(h = cable_enter_w, d=cable_width, $fn=64);
    translate([-cable_width*1.8,screw_h/2,cable_enter_w/2]) rotate([90,0,0]) union(){
        cylinder(h = screw_h, d1=2 ,d2=0.8, $fn=64);
        translate([0,0,-3]) cylinder(h = 3, d1=6,d2=2 , $fn=64);
    }
    translate([cable_width,0,-2]) cylinder(h = 4, d1=cable_width*4,d2=cable_width, $fn=64);
}

module cable_enter_complete(){
    difference(){
    cable_enter_shell();
    cable_enter_holes();
    }
}

module getComplete(){
difference(){
    union(){
        translate([-thickness,-thickness,-thickness]) cube([width+thickness*2,depth+thickness*2,height+thickness*2]);
        translate([width/2,-thickness,-thickness+cable_enter_h/2-cable_enter_h_accurately/2]) rotate([90,0,0]) cable_enter_shell();
        translate([width/2,depth+thickness,-thickness+cable_enter_h/2-cable_enter_h_accurately/2]) rotate([-90,0,0]) cable_enter_shell();
    }
    
    union(){
        cube([width,depth,height]);
        translate([-thickness,twist_y,real_twist_z]) rotate([0,90,0]) cylinder(d=twist_d, h=10, $fn=64);
        translate([width/2,-thickness,-thickness+cable_enter_h/2-cable_enter_h_accurately/2]) rotate([90,0,0]) cable_enter_holes();
                translate([width/2,depth+thickness,-thickness+cable_enter_h/2-cable_enter_h_accurately/2]) rotate([-90,0,0]) cable_enter_holes();
    }
}
}


module getOnlyTop(){
    difference(){
        getComplete();
        getSliceCube();
    }
}

module getOnlyBottom(){
    intersection(){
        getComplete();
        getSliceCube();
    }
}

module getSliceCube(){
    translate([0,0,0])cube([100,100,height], center=true);
}