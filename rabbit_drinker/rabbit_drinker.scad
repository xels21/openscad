thickness = 3;
res=128;

holder_t_raw=18;
holder_t = holder_t_raw+3;

holder_h = 20;

bottle_h_raw=150;
bottle_h = bottle_h_raw-40;

d_raw = 42;
d = d_raw+10;

d_outer=78;

zip_d=5;
zip_z_offset=15;
zip_x_offset=15;

max_w=thickness*4+d;


difference(){
  top();
  zips();
  }
bottom();



module top(){
  top_max_x=thickness+holder_t+thickness;


  translate([-top_max_x,-max_w/2,0])
  difference(){
    cube([top_max_x,max_w,bottle_h]);

    translate([thickness,0,-thickness])
    cube([holder_t,max_w,bottle_h]);

    translate([0,0,-thickness-holder_h])
    cube([holder_t,max_w,bottle_h]);


  }
}

module zips(){
    translate([-zip_d,-max_w/2+zip_x_offset,bottle_h-zip_z_offset])
    rotate([0,90,-45])
    cylinder(d=zip_d,h=4*thickness,$fn=res);

    translate([-zip_d,max_w/2-zip_x_offset,bottle_h-zip_z_offset])
    rotate([0,90,45])
    cylinder(d=zip_d,h=4*thickness,$fn=res);
}

module bottom(){
  difference(){
    union(){
      translate([0,0,0])
      difference(){
        translate([0,-max_w/2,0])
        cube([d_outer/2,max_w,thickness*11]);

        translate([d_outer/2,-max_w/2,thickness*12])
        scale([d_outer/2,1,thickness*10])
        rotate([-90,0,0])
        cylinder(h=max_w,$fn=res);
      }

      translate([d_outer/2,0,0])
      cylinder(d=max_w,h=thickness*2,$fn=res);
    }
    translate([d_outer/2,0,0])
    cylinder(d=d,h=thickness*10,$fn=res);
  }
}
