//cylinder(h = height, r1 = BottomRadius, r2 = TopRadius, center = true/false);

weight=3.2;
innerD=7.2;
height=10;


gapWidth=2.4;
//cube(size = [x,y,z], center = true/false);


res = 64;

difference() {
    cylinder(h = height, d = innerD+weight, center = true, $fn=res);  
    cylinder(h = height, d = innerD, center = true, $fn=res);  
    
    translate([0,-gapWidth/2,-height/2]) cube(size = [20,gapWidth,height], center = false);
}
