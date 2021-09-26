offset = .5;

union() {

    translate([0,0,5.4]) cylinder(h=13, r1=4/2-offset, r2=4/2-offset,$fn=100);
    cylinder(h=5.4, r1=4/2-offset, r2=4/2-offset,$fn=6);
    translate([0,0,18.4])cylinder(h=5.4, r1=4/2-offset, r2=4/2-offset,$fn=6);
}