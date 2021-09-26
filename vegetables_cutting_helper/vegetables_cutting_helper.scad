res=64;


toleranceR=0.5;
toleranceD=toleranceR*2;

thicknessR=5;
thicknessD=thicknessR*2;

spinOffsetR=2;
spinOffsetD=spinOffsetR*2;

spinFn=16;
outerSpinH=5;
innerSpinH=10;

innerD=120;

shutterH=3;
shutterW=8;
shutterTicknessR=3;
shutterTicknessD=shutterTicknessR*2;
shutterTolerance=0.3;
shutterClickH=1;

coverSphereSpacerH = 10;
coverSphereOffsetH = coverSphereSpacerH+innerSpinH;

//bottom();
cover();
//coverShutter();


pi=3.1416;


module knive(){
    kniveWeight=5;
    
  cube([kniveWeight,0,0]) ;
}


module cover(){
    
    //coverSpacer
    difference(){
        union(){
            //outer spinning
            cylinder(d=(innerD+thicknessD+spinOffsetD),h=innerSpinH,$fn=spinFn);
            cylinder(d=(innerD+thicknessD),h=coverSphereOffsetH,$fn=res);
        }
        cylinder(d=(innerD),h=coverSphereOffsetH,$fn=res);
    }
    
    //coverSphere
    translate([0,0,coverSphereOffsetH])
    difference(){
            sphere(d=innerD+thicknessD, $fn=res);
            sphere(d=innerD, $fn=res);
            translate([0,0,-innerD/2]) cube([innerD+thicknessD,innerD+thicknessD,innerD],center=true);
    }
    
    
    union(){
        coverShutter();
        rotate(90) coverShutter();
    }

    
}

module coverShutter(){
    difference(){
        translate([0,0,shutterH/2])cube([innerD+thicknessD-1,shutterW-shutterTolerance,shutterH-shutterTolerance],center=true);
        cylinder(d=(innerD-shutterTicknessD+shutterTolerance),h=shutterH,$fn=res);
    }
}






module bottom(){
    difference(){
        union(){
            //outer spinning
            cylinder(d=(innerD+thicknessD+spinOffsetD),h=outerSpinH,$fn=spinFn);
            //inner slide plate
            cylinder(d=(innerD-toleranceD),h=outerSpinH+innerSpinH,$fn=res);
        }
        
        
        union(){
            bottomShutter();
            rotate(90) bottomShutter();
        }
    }
}

module bottomShutter(){
    shutterD=innerD+spinOffsetD;
    tempRad=asin(2*shutterW/innerD);
    difference(){
        union(){
            translate([0,0,shutterH/2+outerSpinH]) cube([shutterD,shutterW,shutterH],center=true);  
            
            rotate(tempRad) translate([0,0,innerSpinH/2+outerSpinH]) cube([shutterD,shutterW,innerSpinH],center=true);  
            
            rotate(-tempRad) translate([0,0,(shutterH+shutterClickH)/2+outerSpinH]) cube([shutterD,shutterW,shutterH+shutterClickH],center=true);  
        };
        cylinder(d=(innerD-toleranceD-shutterTicknessD),h=outerSpinH+innerSpinH,$fn=res);
    }
}

/*res=100;

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
}*/