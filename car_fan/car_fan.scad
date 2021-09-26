max_x=60;
inner_gap=33;
inner_screw_d=9;
outer_screw_d=2.5;

x_plus=3;
y_plus=2;

y_off=1;

y_ges=2*x_plus+y_plus+y_off;

inner_outer_gap=0.4;

padding=5;

res=24;
h=6;

translate([0,0,h+1])
rotate([180,0,0])
intersection(){
  cube([max_x,1000,1000],center=true);
    outer();
  }
translate([max_x,0,0])
inner();

module outer(){
  /*
                ______________
                 \      ||   |
                  |     ||   |
                /       ||   |
               |________||___|
  */
  outer_x = inner_gap/2+inner_screw_d/2+padding+inner_outer_gap;
  outer_x_max=outer_x+x_plus+padding+outer_screw_d+padding;
  difference(){
    cylinder(h=h+1,r=outer_x_max,$fn=128);
    translate([0,0,1])
    cylinder(h=h,r2=outer_x, r1=outer_x+x_plus,$fn=res);
    cylinder(h=1, r=outer_x+x_plus,$fn=res);
    // rotate_extrude($fn=res) 
    // polygon( points=[
    //   [outer_x,0],
    //   [outer_x_max,0],
    //   [outer_x_max,y_ges],
    //   [outer_x,y_ges],
    //   [outer_x+x_plus,y_ges-x_plus],
    //   [outer_x+x_plus,y_ges-x_plus-y_plus],
    //   [outer_x,y_ges-x_plus-y_plus-x_plus],
    //   [outer_x,y_off],
    // ]);
    translate([20,outer_x_max-12,0])
    cylinder(d=outer_screw_d,h=y_ges,$fn=res);
    translate([-20,outer_x_max-12,0])
    cylinder(d=outer_screw_d,h=y_ges,$fn=res);
    translate([20,-(outer_x_max-12),0])
    cylinder(d=outer_screw_d,h=y_ges,$fn=res);
    translate([-20,-(outer_x_max-12),0])
    cylinder(d=outer_screw_d,h=y_ges,$fn=res);
  }
}
module inner(){
  /*
  ____________
 |             \
 |_______________\

  */
  inner_x = inner_gap/2+inner_screw_d/2+padding;
  // translate([0,0,y_off])
  difference(){
    cylinder(h=h,r2=inner_x, r1=inner_x+x_plus,$fn=res);
    // rotate_extrude($fn=res) 
    // polygon( points=[
    //   [0,0],
    //   [inner_x,0],
    //   [inner_x+x_plus,x_plus],
    //   [inner_x+x_plus,x_plus+y_plus],
    //   [inner_x,x_plus+y_plus+x_plus],
    //   [inner_x,y_ges],
    //   [0,y_ges],
    // ]);
    translate([inner_gap/2,0,0])
    union(){
      cylinder(d=inner_screw_d*2,h=1,$fn=res);
      cylinder(d=inner_screw_d,h=y_ges,$fn=res);
    }
    translate([-inner_gap/2,0,0])
    union(){
      cylinder(d=inner_screw_d*2,h=1,$fn=res);
      cylinder(d=inner_screw_d,h=y_ges,$fn=res);
    }
  }
}