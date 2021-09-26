thickness=3;
res=64;

d_top=8.1;

d1=8;
d2=16;

z1=12;
z2=8;
z3=8;
bottom_z = z1+z2+z3;

x1=10;
x2=15;
x3=d1/2;
x4=16;

max_x = 38;

max_y=thickness*2+d_top;

gap_fill=8;
gap=(max_x-(3*gap_fill))/2;

translate([0,0,bottom_z])
top();
bottom();

module bottom(){
    difference(){   
        translate([0,-max_y/2,0])
        cube([max_x,max_y, bottom_z]);

        translate([0,-d1/2,0])
        cube([x1+x2+x3-d1/2,d1, bottom_z]);

        translate([x1+x2,0,0])
        cylinder(d=d1,h=bottom_z,$fn=res);


        //left screw
        translate([x1,0,z1+z2])
        translate([0,max_y/2,0])
        rotate([90,0,0])
        cylinder(d=2, h=max_y, $fn=res);

        //right screw
        translate([x1+x2,0,z1])
        translate([0,max_y/2,0])
        rotate([90,0,0])
        cylinder(d=2, h=max_y, $fn=res);

        //right rotate
        translate([x1+x2,0,z1])
        translate([0,d1/2,0])
        rotate([90,0,0])
        cylinder(d=d2, h=d1, $fn=res);
    }
}

module top(){
    difference(){
        translate([0,0,max_y/2])
        rotate([0,90,0])
        difference(){
            union(){
                cylinder(d=max_y, h=max_x, $fn=res);
                translate([0,-max_y/2,0])
                cube([max_y/2,max_y,max_x]);
            }
            //inner
            cylinder(d=d_top, h=max_x, $fn=res);
            //top
            translate([-7,0,0])
            cylinder(r=6, h=max_x, $fn=64);
        }
        translate([gap_fill,-max_y/2, max_y/2])
        cube([gap,max_y, max_y]);

        translate([gap_fill+gap+gap_fill,-max_y/2, max_y/2])
        cube([gap,max_y, max_y]);
    }
}