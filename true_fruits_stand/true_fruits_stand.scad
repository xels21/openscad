tf_d=55;
tf_r=tf_d/2;

r_plus=14;
bottom=1;
max_h=r_plus+bottom;

r_inner_thin=0.8;

res=128;

rotate_extrude($fn=res){

  translate([tf_r,0,0]){
    translate([0,max_h-r_inner_thin])
    circle(r=r_inner_thin,$fn=res);

    translate([0,bottom])
    intersection(){
      square(size=[r_plus, r_plus], center=false);
      circle(r=r_plus,$fn=res/2);
    }
  }

  square(size=[tf_r+r_plus-bottom, bottom], center=false);
  translate([tf_r+r_plus-bottom,bottom])
    rotate([0,0,270])
    intersection(){
      square(size=[bottom, bottom], center=false);
      circle(r=bottom,$fn=res/2);
    }

}