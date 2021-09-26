use <../libs/Round-Anything/MinkowskiRound.scad>;

led_w=10;
led_h=2;

thickness=1.5;
bottom_thickness=1;

length=40;

v2();

module v2(){
  h=1.5;
  holder = 2.5;
  difference(){
    union(){
      translate([-(thickness+led_w+thickness)/2,-length/2,-h])
      minkowskiOutsideRound(1)
      cube([thickness+led_w+thickness,length,(bottom_thickness+h+thickness)+h]);

      rotate([0,0,90])
      translate([-(thickness+led_w+thickness)/2,-length/2,0])
      minkowskiOutsideRound(1)
      cube([thickness+led_w+thickness,length,bottom_thickness+h+thickness]);

      rotate([0,0,45/2])
      cylinder(d1=length*1.08,d2=length/2,h=bottom_thickness+h+thickness,$fn=8);
    }
    translate([-(led_w)/2,-length/2-1,-4*h+bottom_thickness+thickness*1.5])
    minkowskiOutsideRound(2)
    cube([led_w,length+2,h*4]);

    rotate([0,0,90])
    translate([-(led_w)/2,-length/2-1,-4*h+bottom_thickness+thickness*1.5])
    minkowskiOutsideRound(2)
    cube([led_w,length+2,h*4]);

    translate([-(led_w-holder)/2,-length/2,bottom_thickness])
    cube([led_w-holder,length,h+thickness]);

    rotate([0,0,90])
    translate([-(led_w-holder)/2,-length/2,bottom_thickness])
    cube([led_w-holder,length,h+thickness]);
    
    translate([0,0,-h])
    cylinder(d=length*2,h=h,$fn=8);
  }
  rotate([0,0,45/2])
  cylinder(d=length*1.08,h=bottom_thickness,$fn=8);
}

module v1(){
  difference(){
    union(){
    translate([-(thickness+led_w+thickness)/2,-length/2,0])
    cube([thickness+led_w+thickness,length,bottom_thickness+2*led_h+thickness]);

    rotate([0,0,90])
    translate([-(thickness+led_w+thickness)/2,-length/2,0])
    cube([thickness+led_w+thickness,length,bottom_thickness+2*led_h+thickness]);

    rotate([0,0,45/2])
    cylinder(d1=length*1.08,d2=length/2,h=bottom_thickness+2*led_h+thickness,$fn=8);
    }
    translate([-(led_w)/2,-length/2,bottom_thickness])
    cube([led_w,length,2*led_h]);

    rotate([0,0,90])
    translate([-(led_w)/2,-length/2,bottom_thickness])
    cube([led_w,length,2*led_h]);
  }
}