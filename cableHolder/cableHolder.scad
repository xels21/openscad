//cylinder(h = height, r1 = BottomRadius, r2 = TopRadius, center = true/false);

width=2;
cableHeight=15;
cablewidth=10;
holderLength=25;

weight=5;

//cube(size = [x,y,z], center = true/false);

difference() {
    cube(size = [width+cablewidth,holderLength+cableHeight+width*2,weight]);
    translate([width,0,0]) cube(size = [width+cablewidth,holderLength,weight]);
    translate([0,width+holderLength,0]) cube(size = [cablewidth,cableHeight,weight]);
    translate([9,-5,0]) rotate([0,0,75]) cube(size = [10,10,weight]);
}
