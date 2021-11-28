//use <..\libs\Round-Anything\polyround.scad>;
use <../libs/Round-Anything/MinkowskiRound.scad>;
use <../libs/Poor_mans_openscad_screw_library/polyScrewThread_r1.scad>;
use <../libs/openscad_xels_lib/round.scad>;


//With of the phone
phoneWRaw = 76;
//Depth of your phone
phoneDRaw = 10;





PI=3.141592;

phoneWTol = 1;
phoneDTol = 0.5;

thickness=2;
phoneFrameSide=4;
phoneFrameBottom=8;

phoneW = phoneWRaw + phoneWTol;
phoneD = phoneDRaw + phoneDTol;

phoneH = 25;

clipMountH= 15;
clipMountW= 13.5;

fan_clip_h_raw=3;
fan_clip_h_tol=1;
fan_clip_h_span=1.6;
fan_clip_w=13;

clipMountD = 3.5;
clip_tol=0.4;

clip_screw_thickness=3.5;
clip_screw_h=30;
clip_screw_innder_handle_h  = 4;
clip_screw_d_sum=clipMountW;
clip_screw_d_inner = clip_screw_d_sum-2*clip_screw_thickness;
clip_screw_tol=0.3;
 

charger_w=15;
aux_l_offset=16;

    // rounded_cube_x([10,10,10, r=2], center=false);
    // cube([10,10,10]);
//rendering phone case
// translate([phoneD+3*thickness+clipMountD+2*clip_tol - thickness,-phoneW/2-thickness+clipMountW/2,0])
rotate([0,0,90])
phone_holer(withClip=true, charger_w=charger_w, withPattern=false, aux_l_offset=aux_l_offset);
// clip_screw_inner();
//rendering screw holder
// translate([10,-15,0])
// union(){
  //clip_screw_inner();
  
  // translate([clip_screw_d_sum+1,0,0]) 
  // rotate([0,0,60]) 
  // clip_screw_outer();
// }
translate([0,-3,0])
rotate([90,0,0])
clip_fan();

module clip_fan(){
  clipBottomW=2*thickness+2*clip_tol;
  fan_clip_sum = 2*thickness+fan_clip_h_tol+fan_clip_h_raw;
  // cube([clip_screw_d_sum/2+clipMountD+thickness*2 , clipMountW  ,clipMountD]);

  translate([-clipBottomW+thickness,0,0])
  union(){
    clip_fan_clip();

    translate([0,0,fan_clip_sum])
    mirror([0,0,1])
    clip_fan_clip();
  }

  translate([-clipBottomW,0,0])
  cube([thickness , clipMountW , fan_clip_sum]);

  translate([-clipBottomW,0,0])
  cube([clipBottomW, clipMountW, fan_clip_sum-thickness*.5]);
  cube([clipMountD , clipMountW , clipMountH+clipMountD]);
}

module clip_fan_clip(){
  translate([0,fan_clip_w,0])
  rotate([90,0,0])
  linear_extrude(fan_clip_w)
  offset(-thickness/2)
  offset(thickness/2)
  polygon(points=[
    [0,0],
    [-clipMountH, 0+ fan_clip_h_span/2],
    [-clipMountH, thickness+ fan_clip_h_span/2],
    [0, thickness],
    ]);
}


module clip_screw_outer(){
  difference(){
    union(){
    cylinder(h=clip_screw_h-clip_screw_innder_handle_h,d=clip_screw_d_sum,$fn=6);
    
       rotate([0,0,30])translate([-(clip_screw_d_sum/2+clipMountD+thickness*2),-(clipMountW/2),0]) union(){
      cube([clip_screw_d_sum/2+clipMountD+thickness*2 , clipMountW  ,clipMountD]);
      cube([clipMountD , clipMountW , clipMountH+clipMountD]);
    }
  }
  
    screw_thread(clip_screw_d_inner,   // Outer diameter of the thread
      4,   // Step, traveling length per turn, also, tooth height, whatever...
      55,   // Degrees for the shape of the tooth (XY plane = 0, Z = 90, btw, 0 and 90 will/should not work...)
      clip_screw_h,   // Length (Z) of the tread
      PI/2,   // Resolution, one face each "PI/2" mm of the perimeter, 
      0);  // Countersink style:
  }
}

module clip_screw_inner(){
  difference(){
  union(){
    cylinder(h=clip_screw_innder_handle_h,d=clip_screw_d_sum,$fn=6);
     translate([0,0,clip_screw_innder_handle_h]) scale([1,1,0.3]) sphere(d=clip_screw_d_sum,$fn=6);
     screw_thread(clip_screw_d_inner-2*clip_screw_tol,   // Outer diameter of the thread
                  4,   // Step, traveling length per turn, also, tooth height, whatever...
                  55,   // Degrees for the shape of the tooth (XY plane = 0, Z = 90, btw, 0 and 90 will/should not work...)
                  clip_screw_h,   // Length (Z) of the tread
                  PI/2,   // Resolution, one face each "PI/2" mm of the perimeter, 
                  0);  // Countersink style:
  }
   translate([0,0,-clip_screw_h/2]) cube([clip_screw_h,clip_screw_h,clip_screw_h],center=true);
  }
}

module clip_mount(clip_tol){
  //clip mount
  difference(){
    cube([clipMountW+thickness*2+clip_tol*2,clipMountD+thickness*2+clip_tol*2,clipMountH]);
    translate([thickness+clip_tol,thickness+clip_tol,0]) cube([clipMountW+clip_tol,clipMountD+clip_tol,clipMountH]);
  }
}


module phone_holer(withClip=true, charger_w=0, withPattern=true, aux_l_offset=-1){
  
  if(withClip){
    clip_tol=0.4;
    
    clipWSum = clipMountW+thickness+2+clip_tol*2;
    
    translate([(phoneWSum-clipWSum)/2,phoneD+thickness,0]) clip_mount(clip_tol);
  };

  phoneWSum=phoneW+(thickness*2);
  phoneDSum=phoneD+(thickness*2);

  difference(){
    
    //outer cube
    rad = 2.5;
    
    minkowskiOutsideRound(rad,1)
    cube([phoneWSum, phoneDSum, phoneH+(thickness*2)+rad]);
    //upper cut off
    translate([0,0,phoneH+(thickness*2)]) cube([phoneWSum, phoneDSum, rad]);
    
    if(withPattern){
      //pattern
      pAmount=6;
      wEntirePart=phoneWSum/(pAmount+1);
      wPart=wEntirePart/3;
      z_fac=0.8;

      translate([0,(phoneD+wPart),((phoneH-2*phoneFrameSide)/2+phoneFrameSide)+thickness])
      for (i =[0:pAmount])
        translate([1.5*wPart+(wEntirePart*i),0,0])
        rotate([90,0,0])
        scale([wPart,(phoneH-phoneFrameSide)*z_fac,1])
        cylinder(d=1, h=thickness+0.1,$fn=64);
    }
    /*
    patternW=4;
    for (x =[0:7])
      translate([phoneFrameSide+x*12,thickness*2+phoneD,phoneFrameSide+thickness])
      rotate([90,0,0])
      translate([patternW/2,(phoneH-2*phoneFrameSide)/2,0])
      scale([patternW,phoneH-phoneFrameSide,1])
      cylinder(d=1, h=thickness,$fn=64);
    */
    
    //charger cut
    if(charger_w>0){
      //cutVar=2;
      r=2;
      translate([phoneWSum/2-charger_w/2,-r,0]) 
      rounded_cube_z([charger_w,phoneD+thickness+r,phoneH], r=r);
      //cylinder(r1=phoneD+thickness,r2=cutVar+phoneD+thickness, h=phoneFrameBottom+thickness, $fn=64);
    }

    if(aux_l_offset>=0){
      // aux_l_offset
      aux_d=phoneD+2*thickness;
      translate([thickness + aux_l_offset, aux_d/2-thickness, 0])
      cylinder(d=aux_d, h=thickness+phoneFrameBottom);
    }

    //inner (phone) cube
    translate([thickness,thickness,thickness]) 
    minkowskiOutsideRound(3)
    cube([phoneW, phoneD, phoneH+3]);
    
    //front phone frame
    translate([phoneFrameSide+thickness,0,phoneFrameBottom+thickness]) 
    // cube([phoneW-(2*phoneFrameSide), thickness, phoneH]);
    rounded_cube_x([phoneW-(2*phoneFrameSide),thickness,phoneH], r=5, center=false);
    
    
    //stick in helper
    if(false){
      polyhedron( 
      [
      //lower part
      [thickness, thickness, phoneH+thickness],//0
      [thickness+phoneW, thickness, phoneH+thickness],//1
      [thickness+phoneW, thickness+phoneD, phoneH+thickness],//2
      [thickness, thickness+phoneD, phoneH+thickness],//3
      
      //upper part
      [0, 0, phoneH+(thickness*2)],//4
      [phoneWSum, 0, phoneH+(thickness*2)],//5
      [phoneWSum, phoneDSum, phoneH+(thickness*2)],//6
      [0,phoneDSum, phoneH+(thickness*2)]//7
      ],
      
      [
      [0,1,2,3],  // bottom
      [4,5,1,0],  // front
      [7,6,5,4],  // top
      [5,6,2,1],  // right
      [6,7,3,2],  // back
      [7,4,0,3]
      ]); //7, CubeFaces );
    }else{
      padding=0.4;

      translate([padding,padding,phoneH+(thickness*2)-rad*1.5])
      minkowskiOutsideRound(rad*2)
      cube([phoneWSum-padding*2, phoneDSum-padding*2, rad*4]);
    }
    
  }
}




/*
module clip(clipX,clipY,clipZ){
  stlClipY=25;
  stlClipZ=3.5;
  stlClipX=3+9.5;
  
  scale([1,clipY/stlClipY,1])
  
  union(){
  difference(){
    translate([-stlClipX,0,0])import_stl("Vent_Clip_v2.stl", convexity = 5); 
    translate([-stlClipX,0,0])cube([stlClipX,stlClipY,stlClipZ]);
    }
  
  translate([-clipX,0,0])cube([clipX,stlClipY,clipZ]);
  }
}
*/