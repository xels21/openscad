height = 7;
//org 82
diameter1= 84.2;//old 84.5;
diameter2= 82.2;//old 82.5;

//weight = 2.4;
weightBottom = 1.5;
weightDiameter= 3;

cableWidth=4; //old3.5;

res = 128;

height21=1;

points21 = [[0.311,0],
[0.574,0.263],
[0.311,0.526],
[0.473,0.526],
[0.653,0.345],
[0.653,0.871],
[0.524,1],
[0.524,0.655],
[0,0.655 ],
[0.392 ,0.263],
[0.311,0.182],
[0.182,0.311],
[0,0.311],
[0.311,0]];


difference(){

union(){

difference(){
    cylinder(h=height ,d1=diameter1+weightDiameter,d2=diameter2+weightDiameter,$fn=res);
    
    union(){
        //translate([0,0,-weight+0.5]) rotate([180,0,0]) linear_extrude(height = 1)text(text="21", size=diameter1/2, font="Arial",halign="center",valign="center");  

        cylinder(h=height ,d1=diameter1,d2=diameter2,$fn=res);
        cylinder(h=3 ,d1=diameter1+0.4,d2=diameter1-0.3,$fn=res);
    }
}
difference(){
    translate([0,0,-cableWidth-weightBottom])cylinder(h=cableWidth+weightBottom ,d=diameter1+weightDiameter,$fn=res);
    translate([0,0,-cableWidth])cylinder(h=cableWidth ,d=diameter1,$fn=res);
    translate([-diameter1*2/7,-diameter1*2/5,-cableWidth-weightBottom-0.8 ]) scale([diameter1*0.8,diameter1*0.8,1]) linear_extrude(height = height21) polygon(points21);
    
    
}
}

//cable gap
union(){
    translate([0,0,-cableWidth/2]) rotate([0,90,0]) cylinder(h=100 ,d=cableWidth,$fn=res);
    translate([0,-cableWidth/2+0.6,-cableWidth/2]) cube([100,cableWidth-1.2,100]);
}

}

translate([0,0,-cableWidth])    
intersection(){
    
    difference(){
        cylinder(h=cableWidth ,d=diameter1,$fn=res);
        cylinder(h=cableWidth ,d=diameter1-2.4,$fn=res);
    }
    translate([0,0,+cableWidth/2])  union(){
    rotate([0,0,45]) cube([30,100,cableWidth],center=true);
    rotate([0,0,-45]) cube([30,100,cableWidth],center=true);
    }
}
/*
height = 10;
realHeight = height/2;

diameterOuter = 44;
diameterInner = diameterOuter-4;

xOffset = 10;

xRes = 180/(diameterInner-xOffset)*2;

weight = 2;


holeD=4;
difference(){
    union(){
        points = [ for (x = [0 : 1 : 180]) [ (xOffset/2)+x/xRes, realHeight+realHeight*cos(x) ] ];
        rotate_extrude($fn=100) polygon(concat(points, [[0, 0],[0, height]]));

        translate([0,0,-weight ]) cylinder(h=weight ,d1=diameterOuter,d2=diameterInner,$fn=100);
    }


    translate([-diameterOuter/2,0,weight+1 ]) rotate([0,90,0]) cylinder(h=diameterOuter ,d=holeD,$fn=32);

}
*/