outer_d2 = 46;
outer_d1 = 45;
l = 10;
thickness=1;
inner_d=18;
inner_d_plus=1;

res=128;


difference(){
  union(){
    difference(){
      cylinder(d1=outer_d1+2*thickness,d2=outer_d2+2*thickness,h=l+thickness,$fn=res);
      cylinder(d1=outer_d1,d2=outer_d2,h=l,$fn=res);
    }
  cylinder(d1=inner_d+2*thickness,d2=inner_d+2*thickness+2*inner_d_plus,h=l+thickness,$fn=res);
  }
  cylinder(d=inner_d,h=l+thickness,$fn=res);
  count=7;
  for(i=[0:count]){
      translate([sin(i/count*360)*inner_d*0.94
              ,cos(i/count*360)*inner_d*0.94
              ,0]) 
  cylinder(d=(outer_d2-inner_d)*0.35,h=l+thickness,$fn=res);

  }

}