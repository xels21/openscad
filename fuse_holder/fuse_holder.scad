iter=12;
gapY=3;
fuseTol=0.6;
fuseGapX=2;
fuseGap=4;
fuseWidth=5+(fuseTol*2);
fuseH=6;
fuseWeight=0.5+fuseTol;


xMax=fuseGapX*2+fuseGap+fuseWidth*2;
yMax=(iter-1)*gapY;
zMax=fuseH;

//xMax=xMax-1;
//yMax=yMax-1;
//zMax=zMax-1;



difference(){
    

    
  //cube(size = [fuseGapX*2+fuseGap+fuseWidth*2,(iter+1)*gapY,fuseH]);
  roundedCube(xMax,yMax,zMax);

  translate([fuseGapX,,0])
  union(){
    for(i = [1 : iter]){ 
        translate([0,i*(gapY-(fuseWeight/2)),0])union(){
          cube(size = [fuseWidth,fuseWeight,fuseH]);
          translate([fuseWidth+fuseGap,0,0]) cube(size = [fuseWidth,fuseWeight,fuseH]);
        }
    }
  }
}

module roundedCube(x,y,z){
        tol = 1.8;
        x=x-tol;
        y=y-tol;
        z=z-tol;
        translate([tol/2,tol/2,tol/2])
        hull(){
        translate([0,0,0]) sphere();
        translate([x,0,0]) sphere();
        translate([x,y,0]) sphere();
        translate([0,y,0]) sphere();
        
        translate([0,0,z]) sphere();
        translate([x,0,z]) sphere();
        translate([x,y,z]) sphere();
        translate([0,y,z]) sphere();
        /*
        for(x=[1,5]){
            for(y=[1,5]){
                for(z=[1,5]){
                    translate([x*xMax,y*yMax,z*zMax]) sphere();
                }
            }
         }
         */
    }
}


  