
gap=3;

translate([0,0,-0.5]) cube(size = [101,101,0.5]);

for(s = [0 : 7]){ 
    row(s*(10+gap),s);
}

module form(){
 difference() {
    cube(size = [10,10,10]);
    translate([0,0,10])  rotate([0,45,0]) cube(size = [20,20,20]);
    translate([0,0,0])  rotate([45,0,0]) cube(size = [20,20,20]);
 }
}

module row(yOffset, rOffset){
  for(iX = [0 : 1]){
      for(r = [0 : 3]){ 
          
          tempR=(r+rOffset)%4;
          
          xB=(iX*4+r)*(10+gap);
          yB=yOffset;
          
          x = (tempR==1)||(tempR==2) ? xB+10 : xB;
          y = (tempR==2)||(tempR==3) ? yB+10 : yB;

  
         translate([x,y,0]) rotate([0,0,tempR*90])  form();
      }
  }
}

  