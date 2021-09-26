box_x=13;
box_y=10;
box_z=8;

wall_width=2;

max_box_x=box_x+wall_width*2;
max_box_y=box_y+wall_width;
max_box_z=box_z+wall_width*2+3;

    toleranze=0.2;


difference() {
    

    

    union(){
        cube(size = [max_box_x,max_box_y,max_box_z]);
        translate([max_box_x/2,0,box_z/2+.5]) rotate([90,90,0]) cylinder(h = 5, r1 =7,r2=4.5, $fn=6);    
    }

    translate([max_box_x/2,box_y/2+wall_width,box_z/2+.5]) rotate([90,0,0]) cylinder(h = 100, r =3.1, $fn=100);

    translate([max_box_x/2,box_y/2+wall_width,0])cylinder(h = 100, r = 1.5, $fn=100);
    translate([max_box_x/2,box_y/2+wall_width,0])cylinder(h = box_z+3.5, r = 3.55, $fn=100);
    
    translate([wall_width-toleranze/2,wall_width-toleranze/2,0])cube(size = [box_x+toleranze,box_y+toleranze,box_z+1]);

    translate([-50,-50,-max_box_z])cube(size = [100,100,max_box_z]);
}