


/*


   ________________________________________
  |   ____________________________________|
__|  |
|_   |
  |  |____________________________________
  |______________________________________|

*/

uc_x=28;
uc_y=17;
uc_z=1;

uc_z_offset = 1;
uc_z_plus = 3;

usbc_x_over=1;
usbc_z=3;
usbc_y=9;

uc_y_plus = uc_y-2*uc_z_offset;

uc_z_max=uc_z + usbc_z;

thickness = 1.5;

x_max = uc_x+thickness;

y_max = uc_y + 2*thickness;
z_max = uc_z_max + 2*thickness;

scale_off=1.07;
scale_off_translate_cor=-0.5;

difference(){
  cube([x_max,y_max,z_max]);

  translate([usbc_x_over,thickness+scale_off_translate_cor,thickness])
  scale([scale_off,scale_off,scale_off]) 
  usb_c();
}

module usb_c(){
  //usb_c
  translate([-usbc_x_over,(uc_y-usbc_y)/2,uc_z])
  cube([uc_x+usbc_x_over,usbc_y,usbc_z]);

  //uc bottom
  // translate([thickness,thickness,thickness])
  cube([uc_x,uc_y,uc_z]);


  //uc bottom plus
  translate([0,(uc_y-uc_y_plus)/2,0])
  cube([uc_x,uc_y_plus,uc_z_plus]);
}