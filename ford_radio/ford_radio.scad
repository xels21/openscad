use <..\libs\Round-Anything\polyround.scad>;
/*
 ___________
/  ║  ║  ║  \
\  O  o  O  /
 \_________/
 
*/

res=32;

plateHeight=5;

withTop=67;
withMiddle=73;
withBottom=46;

height = 22.5;
heightBottom=13;


withTop2=withTop/2;
withMiddle2=withMiddle/2;
withBottom2=withBottom/2;

r=5;

platePoints=[
[withTop2,height, r],
[withMiddle2,heightBottom, r+2],
[withBottom2,0, r],

[-withBottom2,0, r],
[-withMiddle2,heightBottom, r+2],
[-withTop2,height, r]

];

stickWidth=12;
stickThickness=3;
stickHeight=13;
stickDistance=52;

stickPoints=[[-1-stickThickness,0],
[-stickThickness,1+plateHeight],
[-stickThickness,stickHeight],
[0,stickHeight],
[1.5,8.5],
[0,7.5],
[0,1+plateHeight],
[1,0]];

    

module genStick(){
translate([stickDistance/2,stickWidth+6,0]) scale([1,stickWidth,1]) rotate([90,0,0]) linear_extrude(height=1)polygon(stickPoints);    
}
module genHole(minD,maxD){
    union(){
        translate([-(minD/2),-50+(height/2),0]) cube([minD,50,50], center=false);
        translate([0,height/2,0]) cylinder(h=100,d=maxD,center=true,$fn=res);
    }
}

difference(){
    
    union(){
        genStick();
        mirror([1,0,0]) genStick();
        linear_extrude(height=plateHeight) polygon(polyRound(platePoints,4));
    };
    
    union(){
        translate([13,0,0]) genHole(2.5,5);
        translate([-13,0,0]) genHole(4.5,9.2);
        //translate([-18,0,0]) genHole(4.5,9);
        
        //translate([0,2,0.2]) rotate([0,180,180]) linear_extrude(height=1) 
        //text(text="( ͡° ͜ʖ ͡°)", size=13, font="Noto Sans",halign="center", valign="top");
    };
    
    rotate([-2.6,0,0]) translate([0,10/2,-10/2+1]) cube([100,50,10],true);

}




