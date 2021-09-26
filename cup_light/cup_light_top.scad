height = 10;
realHeight = height/2;

diameterOuter = 44;
diameterInner = diameterOuter-4;

xOffset = 10;

xRes = 180/(diameterInner-xOffset)*2;

weight = 2;


holeD=4;

cubeVar=10;

difference(){
    union(){
        points = [ for (x = [0 : 1 : 180]) [ (xOffset/2)+x/xRes, realHeight+realHeight*cos(x) ] ];
        rotate_extrude($fn=100) polygon(concat(points, [[0, 0],[0, height]]));

        translate([0,0,-weight ]) cylinder(h=weight ,d1=diameterOuter,d2=diameterInner,$fn=100);
    }

//translate([16,-1.5,-cubeVar ]) cube([cubeVar,3,cubeVar]);

    translate([-diameterOuter/2,0,weight+1 ]) rotate([0,90,0]) cylinder(h=diameterOuter ,d=holeD,$fn=32);

}