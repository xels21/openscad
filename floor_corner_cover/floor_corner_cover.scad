/*

 ________
/  ______\
| |
| |
|/

*/

top_w=14;
side_w=10;
l=200;
t=1.5;

side_max = side_w+t;
top_max= top_w+t;


end_off=2;
corner_off=0.5;

connector_length=15;

screw_r1=2;
screw_r2=1;
screw_r_h=1;

res=64;

all();

module screw(){
  translate([0,0,side_max-screw_r_h]) 
  cylinder(r1=screw_r2,r2=screw_r1,h=screw_r_h, $fn=res);
  cylinder(r=screw_r2,h=side_max, $fn=res);
}

module all(){
  difference(){
    rotate([90,0,90])
    raw();

  translate([0,top_max/2]){
    translate([connector_length/2,0,0])
    #screw();

    translate([l/2,0,0])
    #screw();

    translate([l-connector_length/2,0,0])
    #screw();
  }
  

  }
}

module raw(){
  linear_extrude(height = connector_length) 
  connector_low_2d();

  translate([0,0,connector_length]) 
  linear_extrude(height = l-2*connector_length) 
  profile_2d();

  translate([0,0,l-connector_length]) 
  linear_extrude(height = connector_length) 
  connector_high_2d();
}

module connector_high_2d(){
  difference() {
    profile_2d();
    translate([t/2,-t/2,0])
    square([top_max,side_max]);
  }
}

module connector_low_2d(){
  intersection(){
    profile_2d();
    translate([t/2,-t/2,0])
    square([top_max,side_max]);
  }
}

module profile_2d() {
  polygon([
    [0,end_off],
    [0,side_max-corner_off],
    [corner_off,side_max],
    [top_max-end_off,side_max],
    [top_max,side_w],
    [t+corner_off,side_w],
    [t,side_w-corner_off],
    [t,0]
  ]);
  
}