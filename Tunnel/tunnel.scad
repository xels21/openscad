res=100;

tunnelD=20;
tunnelW=10;
tunnelTchickness=1.5;

squareW = 10;
tunnelDAdd=2;

outerCircleD=11;
innerCircleD=14;

outerOffset=-(outerCircleD/2);
innerOffset=-(innerCircleD/2)+tunnelTchickness;

rotate_extrude($fn=res)
translate([-(tunnelD/2),0,0]) 
intersection(){

    difference(){
        translate([innerOffset,0,0]) circle(d=innerCircleD);
        translate([outerOffset,0,0]) circle(d=outerCircleD);
    }
    translate([(squareW/2)-tunnelDAdd,0,0]) square([squareW,tunnelW], center=true);
}