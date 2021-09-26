use <../libs/openscad_xels_lib\round.scad>;


magnet_d_raw=10;
magnet_h_raw=2;
magnet_tol=0.2;
magnet_con=0.12;
magnet_d=magnet_d_raw+magnet_tol;
magnet_h=magnet_h_raw+magnet_tol;


step_count=16;
step_size=1;
step_fac=1.4;

// bottom_thickness=0.5;
bottom_thickness=0;
magnet_distance=1;

magnet_brim=magnet_d+2*magnet_distance;

male_max_h=magnet_h+bottom_thickness;
// res=32;
res=64;

female_make_fac=1.05;

male_upper_round=0.6;
male_upper_round_plus=0.2;


female_thickness=0.7;
// female_thickness=1;
female_magnet_space=0;

female_max_h=magnet_h+female_magnet_space+male_max_h*female_make_fac;

female_r_max_2 = magnet_brim/2+step_size+female_thickness;
female_r_max_1 = female_r_max_2+3;

translate([-female_r_max_1*1.8,0,0])
male();
translate([female_r_max_1*1.8,0,0])
male();

translate([0,female_r_max_1*2.2,0])
// rotate([180,0,0])
female();

mic_mount();

  // rounded_cylinder(r=magnet_brim/2, h=male_max_h, n=10, fn=64);

module mic_mount(){
  d_mic_mount=10.6;
  mic_mount_round=2;
  mic_mount_bottom=1;

  translate([0,0,mic_mount_bottom])
  difference(){
    translate([0,0,-mic_mount_round-mic_mount_bottom])
    rounded_cylinder(r=female_r_max_1,h=d_mic_mount*0.71+mic_mount_round+mic_mount_bottom,n=mic_mount_round, fn=res);
    
    translate([-female_r_max_1,-female_r_max_1,-mic_mount_round-mic_mount_bottom])
    cube([female_r_max_1*2,female_r_max_1*2,mic_mount_round]);

    translate([-female_r_max_1,0,d_mic_mount/2])
    rotate([0,90,0])
    cylinder(d=d_mic_mount,h=female_r_max_1*2,$fn=res);
    
    translate([0,female_r_max_1,d_mic_mount/2])
    rotate([90,0,0])
    cylinder(d=d_mic_mount,h=female_r_max_1*2,$fn=res);
  }
}

module female(){
  // rotate([0,180,0])
  difference(){
    cylinder(r1=female_r_max_1, r2=female_r_max_2, 
                     h=male_max_h+female_thickness+magnet_h,
                     $fn=64);

    //magnet
    // translate([0,0,female_thickness])
    cylinder(d1=magnet_d,d2=magnet_d-magnet_con,h=magnet_h,$fn=res);

    cylinder(d=magnet_d-2,h=female_max_h,$fn=res);

    translate([0,0,female_max_h])
    rotate([180,0,0])
    scale(female_make_fac)
    male_raw();

    translate([-magnet_brim,-magnet_brim,female_max_h-0.001])
    cube([magnet_brim*2,magnet_brim*2,magnet_h*2]);
  }

}

module male_raw(){
  difference(){
    union(){
      translate([0,0,-male_upper_round])
      rounded_cylinder(r=magnet_brim/2, h=male_max_h+male_upper_round+male_upper_round_plus, n=male_upper_round, fn=64);

      for(i=[0:step_count]){
        translate([sin(i/step_count*360)*magnet_brim*0.5
                ,cos(i/step_count*360)*magnet_brim*0.5
                ,0]) 
      rotate([0,0,-i/step_count*360])
      scale([magnet_brim/step_count*step_fac,step_size,male_max_h-male_upper_round])
      sphere(r=1,$fn=res/2);
      }
    }
    translate([-magnet_brim,-magnet_brim,-magnet_h*2])
    cube([magnet_brim*2,magnet_brim*2,magnet_h*2]);
  }
}

module male(){

  difference(){
    male_raw();

    //magnet
    translate([0,0,bottom_thickness])
    cylinder(d1=magnet_d,d2=magnet_d-magnet_con,h=magnet_h+male_upper_round_plus,$fn=res);
  }

}
