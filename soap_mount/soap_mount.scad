use <../libs/Round-Anything/MinkowskiRound.scad>;


inner_d1_raw = 62;
inner_d1 = inner_d1_raw+1;
inner_d2_raw = 69;
inner_d2 = inner_d2_raw+1;
inner_h = 40;


holder_t=2.2;
holder_x=15.5;

thickness = 5;


max_x=inner_d2+3*thickness;
max_y=inner_d2+2*thickness;
max_z=inner_h+thickness;

$fn=64;

all();

module all(){
  difference(){
    // minkowskiOutsideRound(2)
    difference(){
      shell();
      deco();
    }
    #angle();
    soap();
  }

}

module deco(){
  translate([max_x-30,0,max_z]) 
  scale([1,1.6,1])
  rotate([0,90,0])
  cylinder(d=40,h=30,$fn=8);

}

module soap(){
  translate([inner_d2/2+2*thickness,0,thickness])
  cylinder(h = inner_h, d1=inner_d1, d2=inner_d2);
}

module angle(){
  translate([0,-holder_x/2,0])
  union(){
    cube([holder_t,holder_x,max_z]);
    cube([max_z,holder_x,holder_t]);
  }
  translate([0,0,32])
  rotate([0,90,0])
  union(){
    translate([0,0,thickness*2-1.5]) 
    cylinder(h = 4, d1=4, d2=10);
    cylinder(h = thickness*2, d=4);
  }
}

module shell(){
  translate([max_y/2+thickness,0,0]) 
  cylinder(d=max_y,h=max_z, $fn=16);
  translate([0,-max_y/2,0]) 
  cube([max_y/2+thickness,max_y,max_z]);
}