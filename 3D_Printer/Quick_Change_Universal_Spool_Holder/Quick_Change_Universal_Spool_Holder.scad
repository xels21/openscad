d1=40;
d2=50;
h=20;

res=64;

intersection(){
  cylinder(d1=d1,d2=d2,h=h, $fn=res);

  translate([0,0,h])
  rotate([180,0,0])
  import("Quick_Change_Universal_Spool_Holder/files/Quick_Change_Universal_Spool_Hub_Nut_2.0.stl");  
}