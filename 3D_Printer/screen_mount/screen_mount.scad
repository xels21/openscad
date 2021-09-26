use <..\..\libs\Round-Anything\MinkowskiRound.scad>;

mirror([1,0,0])
mount();
translate([5,0,0])
mount();

module mount(){
  difference(){
    union(){
      translate([0.001,-52.74,0])
      import_stl("_LCD_Screen_Mount_for_GEEETech_i3_Pro_B/files/Geeetech_LCD_Mounts_V2.stl", convexity = 5);
      difference(){
        translate([0,0,-10])
        minkowskiOutsideRound(7)
        cube([27,27.6,35]);
        translate([0,0,-10])
        cube([27,30,10]);
      }
    }

    cube([1,100,100]);

    translate([5,6,0])
    cube([27,15.6,35]);

    translate([-1,0,0])
    rotate([0,0,70])
    cube([30,20,10]);

    translate([12,0,7])
    cube([40,10,25]);
  }
}


