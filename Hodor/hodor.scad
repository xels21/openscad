intersection(){
  translate([0,-5,0]) rotate([0,190,0]) cube([150,60,30]);
  translate([-12,0,0])  linear_extrude(height = 25) offset(delta = 1.5){
    text(text="HODOR",font="Castellar:Bold",size=30,spacing=0.65, halign = "right");
  }
}