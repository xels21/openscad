
fn=5;
d=7;
height=120;

con_thickness=1.5;
con_height=15;
con_tol=0.2;
con_fall=30;

top_helper=1.5;

ez2print();


module ez2print(){
  difference(){
    translate([0,0,d*0.4])
    rotate([90,55,0])
    all();

    translate([-height/2,-height,-height])
    cube([height,height,height]);
  }
}

module all(){
  stick();
  top_helper();
  connector_outer();
  connector_fall();
}

module stick(){
  translate([0,0,con_height])
  cylinder(d=d,h=height-con_height-top_helper,$fn=fn);
}

module top_helper(){
  translate([0,0,height-top_helper])
  cylinder(d1=d,d2=d-top_helper,h=top_helper,$fn=fn);
}

module connector_outer(){
  difference(){
    cylinder(d=d+con_tol+con_thickness*2,h=con_height,$fn=fn);
    cylinder(d=d+con_tol,h=con_height,$fn=fn);
  }
}

module connector_fall(){
  translate([0,0,con_height])
  cylinder(d1=d+con_tol+con_thickness*2,d2=0,h=con_fall,$fn=fn);
}