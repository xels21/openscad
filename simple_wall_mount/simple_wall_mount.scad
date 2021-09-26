use <..\libs\Round-Anything\MinkowskiRound.scad>;

//With of the thing
thingWRaw = 58;
//Depth of your thing
thingDRaw = 7;

thingWTol = 1;
thingDTol = 1;

PI=3.141592;


thickness=1;
thingFrameSide=10;
thingFrameBottom=14;

thingW = thingWRaw + thingWTol;
thingD = thingDRaw + thingDTol;

thingH = 25;

//rendering thing case
thing_holer(withScrew=true);

module thing_holer(withScrew=true,){
  
  if(withClip){
    clip_tol=0.4;
    clipWSum = clipMountW+thickness+2+clip_tol*2;
    translate([(thingWSum-clipWSum)/2,thingD+thickness,0]) clip_mount(0.4);
  };

  thingWSum=thingW+(thickness*2);
  thingDSum=thingD+(thickness*2);

  difference(){
    
    //outer cube
    rad = 2.5;
    
    minkowskiOutsideRound(rad,1)
    cube([thingWSum, thingDSum, thingH+(thickness*2)+rad]);
    //upper cut off
    translate([0,0,thingH+(thickness*2)]) cube([thingWSum, thingDSum, rad]);
    
    
    //charger cut
    cutVar=3;
    translate([thingWSum/2,-cutVar,0]) cylinder(r1=thingD+thickness,r2=cutVar+thingD+thickness, h=thingFrameBottom+thickness, $fn=64);

    //screw
    if(withScrew){
        translate([thingWSum/2,thingD+thickness,thingH/2+thickness]) rotate([-90,0,0]) cylinder(r=3.5,r2=2, h=thickness, $fn=64);
    }

    //inner (thing) cube
    translate([thickness,thickness,thickness]) cube([thingW, thingD, thingH]);
    
    //front thing frame
    translate([thingFrameSide+thickness,0,thingFrameBottom+thickness]) cube([thingW-(2*thingFrameSide), thickness, thingH]);
    
    //stick in helper
    polyhedron( 
    [
    //lower part
    [thickness, thickness, thingH+thickness],//0
    [thickness+thingW, thickness, thingH+thickness],//1
    [thickness+thingW, thickness+thingD, thingH+thickness],//2
    [thickness, thickness+thingD, thingH+thickness],//3
    
    //upper part
    [0, 0, thingH+(thickness*2)],//4
    [thingWSum, 0, thingH+(thickness*2)],//5
    [thingWSum, thingDSum, thingH+(thickness*2)],//6
    [0,thingDSum, thingH+(thickness*2)]//7
    ],
    
    [
    [0,1,2,3],  // bottom
    [4,5,1,0],  // front
    [7,6,5,4],  // top
    [5,6,2,1],  // right
    [6,7,3,2],  // back
    [7,4,0,3]
    ]); //7, CubeFaces );
    
    
  }
}
