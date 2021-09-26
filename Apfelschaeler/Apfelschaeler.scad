//cylinder(h = height, r1 = BottomRadius, r2 = TopRadius, center = true/false);

//cube(size = [x,y,z], center = true/false);

difference() {
union() {
    translate([-8.5,-12.5,0]) cube(size = [17,25,2.5]);

translate([-2,-12,0]) cube(size = [4,24,17]);
}

translate([-8,0,0]) cylinder(h = 50, r = 4);
translate([8,0,0]) cylinder(h = 50, r = 4);

translate([-10,-3,5.4]) cube(size = [20,6,6.2]);

translate([-20,3,8.5]) rotate([0,90,0]) cylinder(h = 40, r = 3.1);

translate([-20,-3,8.5]) rotate([0,90,0]) cylinder(h = 40, r = 3.1);
 }