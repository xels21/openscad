use <..\libs\openscad_xels_lib\single_led.scad>;
include <parameter.scad>

//amount LED
ledAmounts = [3,6,12];

//rad LED offset
//ledOffset = [9,25,40];
ledOffset = [30,75,115];


ledRows = len(ledAmounts);
/*
difference(){
  cylinder(d=12,h=4,$fn=res);
  cylinder(d=4,h=4,$fn=res);
  led_stamp();
}
*/



loop_stamp();

module top(){
difference(){
  led_circle();
  loop_stamp();
}
}



module loop_stamp(){
  union(){
    for(i=[0:ledRows-1]){
      for(a=[0:ledAmounts[i]]){
        
        translate([sin(a/ledAmounts[i]*360)*ledOffset[i]/2
      ,cos(a/ledAmounts[i]*360)*ledOffset[i]/2
      ,0]) 
        rotate([0,0,-a/ledAmounts[i]*360 + 90])
      led_single_pixel_stamp();
      }
    } 
    
    translate([0,16,0])rotate([0,0,-79])cube([3,30,3]);
    translate([3,37,0])rotate([0,0,-52])cube([3,27,3]);
    
  }
}
 

module led_circle(){
  difference(){
  union(){
  translate([0,0,hookah_inner_border_step_h])
    cylinder(d=hookah_d-(2*(hookah_outer_border_step_w)),
    h=hookah_outer_border_step_h,$fn=res);
    
  cylinder(d=hookah_d-(2*(hookah_outer_border_step_w+hookah_inner_border_step_w)),
    h=hookah_outer_border_step_h+hookah_inner_border_step_h,$fn=res);
  }
  
  union(){
    for(i=[0:ledRows-1]){
      difference(){
        cylinder(d=ledOffset[i]+hookah_inner_border_step_h, h=hookah_inner_border_step_h);
        cylinder(d=ledOffset[i]-hookah_inner_border_step_h, h=hookah_inner_border_step_h);
      }
    }
  }
}
  
}


//dummy_sceleton();



module dummy_sceleton(){
  
  
  for(i=[0:ledRows-1]){
    
     rotate([0,0,i/ledRows*360])translate([-2,-40,31])cube([4,80,1]);
    
     translate([0,0,31]) difference(){
      cylinder(r=ledOffset[i]+4,h=1, $fn=res);
      cylinder(r=ledOffset[i],h=1, $fn=res);
    }
      
    for(a=[0:ledAmounts[i]]){

      translate([sin(a/ledAmounts[i]*360)*ledOffset[i]
      ,cos(a/ledAmounts[i]*360)*ledOffset[i]
      ,0]) 
      led_big_sceleton();
      
    } 
  }
}


//cylinder(d=hookah_d,h=stand_space+stand_thickness,$fn=res);

