/*



      ____
    ,'    ',
 ,/         \
|           |
 \,        /
   \____,/


*/



light_thickness = 3;
light_d=40;
light_r=light_d/2;
light_outer_r = light_r + light_thickness;
light_height=10;

light_off=2;

min_t=1;

screw_1_d=4;
screw_2_d=3;


$fn=64;

mother_h=2.1;
mother_rad=6;
// mother();

main();
module mother(min_rad = 6, h=2.1){
  // #cube(size = [min_rad,min_rad,light_outer_r], center=true);
  cylinder(h = h, r = min_rad*.57, $fn=6);
}


module main(){
difference(){

  union(){
    rotate_extrude()  
    polygon(points = [
      [light_r,0],
      [light_r,light_height],
      [light_r+min_t,light_height],
      [light_outer_r,light_height-light_off],
      [light_outer_r,light_off],
      // [light_outer_r,light_height],
      // [light_outer_r,4],
      [light_r+min_t,0],
      [light_r,0]
    ], paths = paths, convexity = convexity);


    translate([0,-light_r,light_height/2]) 
    rotate([90,0,0])
    cylinder(h = light_thickness*1.5, d2=mother_rad,d1=light_height);

    translate([0,light_r,light_height/2]) 
    rotate([-90,0,0])
    cylinder(h = light_thickness*1.5, d2=mother_rad,d1=light_height);

  }

  
  #translate([0,2*light_outer_r,light_height/2]) 
  rotate([90,0,0])
  cylinder(h=light_outer_r*4);

  translate([0,light_r+mother_h,light_height/2]) 
  rotate([90,0,0])
  #mother(h=mother_h*2, min_rad=mother_rad);


  translate([0,-(light_r+mother_h),light_height/2]) 
  rotate([-90,0,0])
  #mother(h=mother_h*2, min_rad=mother_rad);

  translate([0,0,light_height/2]) 
  rotate([0,90,0])
  #cylinder(d=screw_1_d, h=light_d);

}
// linear_extrude(height = d_height) 
// difference() {
//   circle(r = light_d/2+d_thickness);
//   circle(r = light_d/2);
// }
}