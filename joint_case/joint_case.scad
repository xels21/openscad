use <../libs/openscad_xels_lib/round.scad>;

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

tol=0.04;

printHelper=false;

dual_x_dif=d1/2+thickness/4;
dual_rot=1.2;

// if (printHelper) print_helper();
// translate([0,0,h])rotate([180,0,0])case();
// translate([d2*1.6,0,capH+thickness])rotate([180,0,0])cap();

translate([0,d2*1.4,thickness])
// cap();
// case();
// dual_cap();
dual_case();

// difference(){
//   dual_case();
//   translate([0,0,100])
//   cube([50,50,50],center=true);
// }


module print_helper(){
  difference(){
    cylinder(h = 0.3,r=r2+3, $fn=res);
    cylinder(h = 0.3,r=r2, $fn=res);
  }
}


module dual_cap(){
  x_diff_corr=0.6;
difference(){
    union(){
      translate([-d1*1.8/2,-d1,-thickness])
      rounded_cube_y([d1*1.8,d1*2,capH+thickness], r=2, center=false);

      translate([-dual_x_dif-thickness-x_diff_corr,0,-thickness])
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