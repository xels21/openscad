use <../libs/openscad_xels_lib/round.scad>;
use <../libs/openscad_xels_lib/helper.scad>;
use <../libs/Round-Anything/MinkowskiRound.scad>;

h=105;
d1=8.5;
d2=12.5;

r1=d1/2;
r2=d2/2;

thickness = 1.5;

// res=16;
res=64;
// res=128;

capR=r2+thickness/2;

capH=8;
capH2=4;
capW=0.35;
capStepH=0.4;

tol=0.05;

printHelper=false;

dual_x_dif=d1/2+thickness/4;
dual_rot=1.2;

// if (printHelper) print_helper();
// translate([0,0,h])rotate([180,0,0])case();
// translate([d2*1.6,0,capH+thickness])rotate([180,0,0])cap();

// translate([0,d2*1.4,thickness])
// cap();
// case();

// dual_cap();
// dual_case();

// case_out_norm();
// n_case_out();
// n_case_in();
n_case();
translate([0,50,0])
n_cap();

// difference(){
//   dual_case();
//   translate([0,0,100])
//   cube([50,50,50],center=true);
// }
n_rot_fac = .32;






module print_helper(){
  difference(){
    cylinder(h = 0.3,r=r2+3, $fn=res);
    cylinder(h = 0.3,r=r2, $fn=res);
  }
}


module n_cap_in(n=6){
  scale([1+tol*0.5,1+tol*0.5,1])
  translate([0,0,thickness])
  n_case_out(n);
}

module n_cap(n=6){
  // translate([0,0,capH])
  // rotate([180,0,0])
  difference(){
    n_cap_out(n);
    n_cap_in(n);
    translate([0,0,thickness])
    linear_extrude(height = capH+thickness)
    rotate([0,0,360/n*0.5])
    circle(d=capR*5.5,$fn=n);
  }
}


module n_cap_out(n=6) {
  // cap_out();
  // for (i=[0:n-1]) {
  //   translate([sin(i*360/n)*(capR*1.7+thickness)
  //             ,cos(i*360/n)*(capR*1.7+thickness)
  //             ,0])
  //   cap_out();
  // }

  // linear_extrude(height = capH+thickness)
  // rotate([0,0,360/n*0.5])
  // scale(2)
  // offset([4,4,1])
  // offset([1/4,1/4,1])
  // scale(0.5)
  // circle(d=capR*5.5,$fn=n);
  
  difference(){
    minkowskiOutsideRound(2.6)
    cylinder(d=capR*7.5,h=capH+thickness,$fn=n);
    scale([capR*5.5,capR*5.5,-.4])
    rotate([0,180,45])
    linear_extrude(1)
    translate([-.4,-.5,0])
    twenty_one();
  }

}
module case_in_norm(){
  translate([0,0,h]) 
  rotate([180,0,0])
  case_in();
}


module n_case(n=6){
  difference(){
    n_case_out();
    n_case_in();
  }
}

module case_out_norm(){
  translate([0,0,h]) 
  rotate([180,0,0])
  case_out();
}

module n_case_out(n=6) {
  difference(){
  translate([0,0,-0.3])
  union(){
    case_out_norm();
    for (i=[0:n-1]) {
      translate([sin(i*360/n)*(capR*1.9)
                ,cos(i*360/n)*(capR*1.9)
                ,0])
      rotate([cos(i*360/n)*capR*n_rot_fac
            ,sin(i*360/n)*-capR*n_rot_fac
            ,0])
      case_out_norm();
    }
  }
  translate([-100,-100,-200])
  cube([200,200,200]);
  }
}
module n_case_in(n=6) {
  difference() {
    translate([0,0,-0.3])
    union(){
    case_in_norm();
      for (i=[0:n-1]) {
      translate([sin(i*360/n)*(capR*1.9)
                ,cos(i*360/n)*(capR*1.9)
                ,0])
      rotate([cos(i*360/n)*capR*n_rot_fac
             ,sin(i*360/n)*-capR*n_rot_fac
             ,0])
      case_in_norm();
    }
  }
  translate([-100,-100,-200])
  cube([200,200,200]);
  }
}



module dual_cap(){
  x_diff_corr=0.6;
difference(){
    union(){
      translate([-d1*1.8/2,-d1,-thickness])
      rounded_cube_y([d1*1.8,d1*2,capH+thickness], r=2, center=false);

      translate([-(dual_x_dif+thickness+x_diff_corr),0,-thickness])
      cap_out();

      translate([dual_x_dif+thickness+x_diff_corr,0,-thickness])
      cap_out();
    }

    translate([-d1/2-2,-d1/2-2,])
    rounded_cube_y([d1+4,d1+4,h+r1+0.5], r=1, center=false);

    translate([dual_x_dif,0,h])
    rotate([180,-dual_rot,0])
    scale([1+tol,1+tol,1])
    case_out();

    translate([-dual_x_dif,0,h])
    rotate([180,dual_rot,0])
    scale([1+tol,1+tol,1]) 
    case_out();
  }
}

module cap_out(){
  cap_out_corr=0.1;

  rotate_extrude($fn=res) 
  polygon( points=[[0,0],
                   [capR+thickness-1+cap_out_corr,0],
                   [capR+thickness+cap_out_corr,1],
                   [capR+thickness+cap_out_corr, capH+thickness-0.5],
                   [capR+thickness-0.5+cap_out_corr, capH+thickness],
                   [0,capH+thickness]
  ]);
}

module cap_in(){
  scale([1+tol,1+tol,1])translate([0,0,-h+capH]) case_out();
}

module cap(){
  translate([0,0,capH])
  rotate([180,0,0])
  difference(){
    cap_out();
    cap_in();
  }
}

module dual_case(){
  z_cor=0.17;
  translate([0,0,-z_cor])
  difference(){
    union(){
      translate([-d1/2,-d1/2,0])
      rounded_cube_y([d1,d1,h+r1+0.5], r=d1/3, center=false);

      translate([dual_x_dif,0,h])
      rotate([180,-dual_rot,0])
      case_out();

      translate([-dual_x_dif,0,h])
      rotate([180,dual_rot,0])
      case_out();
    }

    translate([dual_x_dif,0,h])
    rotate([180,-dual_rot,0])
    case_in();

    translate([-dual_x_dif,0,h])
    rotate([180,dual_rot,0])
    case_in();

    translate([-50,-50,-100+z_cor])
    cube([100,100,100],center=false);
  }
}

module case(){
  translate([0,0,h])
  rotate([180,0,0])
  difference(){
    case_out();
    case_in();
  }
}

module case_out(){
  union(){
    sphere(r=r1+thickness/2, $fn=res);
    rotate_extrude($fn=res) 
    polygon( points=[[0,0],
                    [0,h],
                    [r2+thickness/2,h],
  
                    [capR,h-capH2],
                    [capR+capW,h-capH2-capStepH*1],
                    [capR+capW,h-capH2-capStepH*2],
                    [capR,h-capH2-capStepH*3],
      
                    [r2+thickness/2,h-capH],
                    [r1+thickness/2,0]
    ]);
  }
}

module case_in(){
  union(){
    rotate_extrude($fn=res) 
    polygon( points=[[0,0],
                     [0,h],
                     [r2,h],
                     [r2,h-capH],
                     [r1,0]]);
    sphere(r=r1, $fn=res);
  }
}