use <../libs/openscad_xels_lib/round.scad>;

w=5;
t=3;
outer_d=150;

inner_r=outer_d/2-w;

yard_depth=.3;
yard_w=2;

fractals=11;


difference(){
  contur_3d(_w=w, _t=t, _inner_r=inner_r);
  intersection(){
    union(){
      deg_per_step=360/(fractals+.5);
      // deg_per_step=2*360/(fractals*2+1);
      // deg_per_step=360/(fractals);
      for(i=[0:fractals]){
        rotate([0,0,i*deg_per_step])
        translate([0,outer_d/4,0])
        #cube([yard_w,outer_d/2, t], center=true);
      }
    }
    yarn_mask_neg_3d(_w=w, _t=t, _inner_r=inner_r, _yard_depth=yard_depth);
  }
}

module yarn_mask_3d(_w=w, _t=t, _inner_r=inner_r, _yard_depth=yard_depth){
  contur_3d(_w=w-_yard_depth, _t=t-2*_yard_depth, _inner_r=inner_r, _yard_depth=yard_depth);
}

module yarn_mask_neg_3d(_w=w, _t=t, _inner_r=inner_r, _yard_depth=yard_depth){
  difference(){
    contur_3d(_w=w, _t=t, _inner_r=inner_r);
    yarn_mask_3d(_w=w, _t=t, _inner_r=inner_r, _yard_depth=yard_depth);
  }
}

module contur_3d(_w=w, _t=t, _inner_r=inner_r){
  rotate_extrude(angle=360,convexity=10,$fn=99)
  translate([_inner_r,0,0])
  rotate([0,0,-90])
  contur_2d(_w=_w, _t=_t);
}

module contur_2d(_w=w, _t=t){
  union(){
    translate([-_t/2,0])
    union(){
      rounded_square([_t,_w-(_t/2)], r=_t*.3);
      translate([0,_w-_t])
      square([_t,(_t/2)]);
    }

    translate([0,_w-(_t/2)])
    circle(r=_t/2, $fn=99);
  }
}




/*
t = 4;
w_plus=2;
// w_plus=0;

r=50;

w=t+w_plus;

// square([t,0]);

yarn_circle(_r=r, _t=t, _w=w);

function yarn_circle(_r=r, _t=t, _w=w){
  rotate_extrude(angle=360,convexity=10,$fn=99)
  translate([_r,0,0])
  rotate([0,0,90])
  union(){
    translate([-_t/2,0,0])

    // square([t,10]);
    union(){
      square([_t,_t/2]);
      #rounded_square(size=[_t,_w-(_t/2)], r=1, fn=32, center=false);
    }
    circle(r=_t/2, $fn=99);
  }
}
*/