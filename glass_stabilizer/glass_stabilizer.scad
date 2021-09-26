inner_d2=58.5;
inner_d1=59.5;

upper_cut=2;

h=25 + upper_cut;


stand_plus_d = 35;

res=128;
outer_res=6;

thickness=1;

difference(){
  cylinder(d1=inner_d1 + stand_plus_d,d2=inner_d2,$fn=outer_res,h=h+thickness);

  translate([0,0,h/2+h+thickness-upper_cut])
  cube([stand_plus_d+max(inner_d1,inner_d2),stand_plus_d+max(inner_d1,inner_d2),h],center=true);

  translate([0,0,thickness])
  cylinder(d1=inner_d1,d2=inner_d2,$fn=res, h=h);


}
