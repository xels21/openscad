



// translate([-50,-50,0])
d=120;
scale_fac=1.35;
// square([d,d]);


circle_art();
module circle_art(d=d){
  sizer = d/100;

  translate([-d/2,-d/2,0])
  scale(sizer,sizer,1)
  scale(scale_fac,scale_fac,1)
  translate([-.42,-.42,0])
  import("circle_art.svg");
}





module test1(){
  intersection() {
    translate([15, 15, 0])
    circle(r=15);

    translate([10, 10, 0])
    circle(r=10);
}
}
module test2(){
difference(){
translate([10, 10, 0])
circle(r=10);

translate([15, 15, 0])
circle(r=15);
}
}
