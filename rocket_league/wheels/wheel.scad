// d = 18;
// fac=d;
h_fac=0.5;
inner_d=0.75;

axis_d=5;
tol=0.1;

axe_rim = 5;


rear_d = 20;
front_d = 16;

rear_axe_l = 25.5;
front_axe_l = 21.5;

// both_axe_and_rim();
// both_tires();
get_rim(front_d);
// get_rims(front_d);

module both_tires(){
  for (i=[1:2]) {/* five copies */
    translate([rear_d*(i-1),0,0])  
    union(){
        translate([0,0,rear_d*h_fac*0.42])
        get_tire(rear_d);
        translate([0,rear_d,rear_d*h_fac*0.34])
        get_tire(front_d);
     }
  }
}

module both_axe_and_rim(){
  axe_and_rim(rear_d, rear_axe_l);
  translate([1.5*rear_d,0,0])
  axe_and_rim(front_d, front_axe_l);
}

module axe_and_rim(d,l){
  get_rims(d);

  translate([0,0,(axis_d-tol)/2])
  rotate([90,0,0])
  axe(l);
}

module get_rims(d){
  translate([2*d/3,-d/2,d*0.43*h_fac])
  get_rim(d);

  translate([2*d/3,-3*d/2,d*0.43*h_fac])
  get_rim(d);
}

module axe(axe_l){
  cylinder(d=axis_d-tol,h=axe_rim,$fn=6);
  translate([0,0,axe_rim])
  cylinder(d=axis_d-tol,h=axe_l,$fn=64);
  translate([0,0,axe_l+axe_rim])
  cylinder(d=axis_d-tol,h=axe_rim,$fn=6);
}

module get_tire(d){
  scale(d)
  difference(){
    get_wheel();
    get_cut_mask();
  }
}

module get_rim(d){
  difference(){
    scale(d)
    intersection(){
      union(){
        get_wheel();
        get_inner_support();
      }
      get_cut_mask();
    }
    get_inner_support_diff(d);
  }
}

module get_cut_mask(){
  scale([1,1,1.5])
  sphere(d=0.82,$fn=65); //$fn=64 isn't working
}

// module get_cut_mask2(d){
//   scale(fac*0.3)
//   rotate_extrude(convexity = 10, $fn = 100)
//   scale([0.5,1,1])
//   translate([3.3, 0, 0])
//   circle(r = 1, $fn = 100);
// }

module get_inner_support(){
  translate([0,0,-0.12])
  difference(){
    cylinder(d=inner_d,h=0.32, $fn=64);
    cylinder(d1=inner_d,d2=4,0.07, $fn=64);
    // get_inner_support_diff();
  }
}

module get_inner_support_diff(fac){
    translate([0,0,h_fac/2*fac -axe_rim])
    cylinder(d=axis_d,h=h_fac*fac,$fn=6);
}


module get_wheel(d){
  // scale(d)
  scale(0.0315)
  translate([0,-15.7,0])
  rotate([-90,0,0])
  translate([-100,-100,0])
  import("Models/Tomahawk.stl",convexity=3); 
}


// translate([0.1,0.1,0.1])

// d=20;
// fac = d/10;
// y_fac=0.5;
// y=d*y_fac;

// // cube([10,10*v_fac,10]);

// scale(d/10)
// scale(0.31)
// translate([115.8,108,0])
// rotate([0,0,180])
// import("Models/Tomahawk.stl",convexity=3); 

// inner_d=10*fac;

// //infill
// translate([])
// rotate([-90,0,0])
// cylinder(d=inner_d,h=y);