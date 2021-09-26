thickness = 3;
res=64;

bulbWidth=33;
bulbHeight=45;

pipeD=19;
//pipeThickness=thickness;
pipeThickness=4;

diffuserStabilizerTranslate = -15;

holeD=1.5;

difference(){
  union(){
    difference(){
      //outer sphere
      resize([bulbWidth,bulbWidth,bulbHeight],auto)sphere($fn = res, ,d=10);

      //Generating holes
      union(){
        for(y = [0 : 10]){
          for(x = [0 : 10]){
            zOffset=(x%2)==0?4.5:-4.5;
            translate([0,0,zOffset]) rotate([90+(y*18),0,(x*18)+0]) cylinder(h=200,d=holeD,center=true,$fn = 8);
          }
        }
      }   
    }
    //outer pipe
    translate([0,0,diffuserStabilizerTranslate]) cylinder(h=30,d=pipeD+pipeThickness,center=true,$fn = res);
  }

  //inner pipe and inner sphere
  union(){
    resize([bulbWidth-thickness,bulbWidth-thickness,bulbHeight-(thickness*2)],auto)sphere($fn = res, ,d=10); 
    translate([0,0,diffuserStabilizerTranslate]) cylinder(h=30,d=pipeD,center=true,$fn = res);
  }

}