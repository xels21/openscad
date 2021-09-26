include <..\libs\openscad_xels_lib\ball_bearings.scad>;

//cylinder(h = height, r1 = BottomRadius, r2 = TopRadius, center = true/false);

//cube(size = [x,y,z], center = true/false);


bear_h_dif=1;
//bear_width=1.5;
bear_width=1.5;

bear_in_dil_2 =12;

toleranz=0.1;


//stand_h=1;
init_h=1.5;
gap_h=1;
con_h=2.5;
con_h_tol=.15;
con_r=2;

    spin_width=10;
    coin_width=17;
    coin_cover_width=1;
    coin_cover_h=0.8;

//minus();
plus();
//spin();
//cover();
//cover2();


module spin(){
    difference() {
        union(){
            translate([-21,0,0]) coin_p();
            translate([46,0,0]) coin_p();
            translate([-15,-spin_width/2,0]) cube(size = [70,spin_width,bear_h-bear_h_dif], center = false);
            translate([46,0,0])cylinder(h=bear_h-bear_h_dif,r=21,$fn=3);
            cylinder(h = bear_h-bear_h_dif, r = (bear_out_dil+bear_width)/2+.5, $fn=100);
        } 
        
        translate([-21,0,0]) coin_m();
        translate([46,0,0]) coin_m();
        cylinder(h = bear_h-bear_h_dif, r = bear_out_dil/2, $fn=100);
    }
}

module cover(){
   cylinder(h = coin_cover_h-0.3, r = coin_width/2+coin_cover_width, $fn=100);  
}

module cover2(){
    cylinder(h = coin_cover_h-0.3, r = coin_width/2+coin_cover_width, $fn=100);  
    translate([0,0,0.2])cylinder(h = 1.5, r = coin_width/2, $fn=100);
}

module coin_m(){
       translate([0,0,bear_h-bear_h_dif-coin_cover_h]) cylinder(h = coin_cover_h, r = coin_width/2+coin_cover_width, $fn=100);
     translate([0,0,0.2])cylinder(h = bear_h-bear_h_dif, r = coin_width/2, $fn=100);
}

module coin_p(){
     cylinder(h = bear_h-bear_h_dif, r = coin_width/2+coin_cover_width+bear_width/2, $fn=100);
  //cylinder(h = 0.2, r = coin_width/2+coin_cover_width, $fn=100);  
}


module minus(){
    difference() {
        pre();
        translate([0,0,(init_h+gap_h+bear_h/2)-con_h+con_h_tol]) cylinder(h = con_h+con_h_tol, r = con_r+toleranz, $fn=100);
    }
}

module plus(){
    pre();
    cylinder(h = init_h+gap_h+bear_h/2+con_h-con_h_tol, r = con_r-toleranz, $fn=100);
}

module pre(){
cylinder(h = init_h, r = 30, $fn=100);
cylinder(h = init_h+gap_h, r = bear_in_dil_2/2, $fn=100);
cylinder(h = init_h+gap_h+(bear_h/2), r = bear_in_dil/2, $fn=100);
}

module vorlage(){
    difference() {
        union() {
            translate([-8.5,-12.5,0]) cube(size = [17,25,2.5]);
            translate([-2,-12,0]) cube(size = [4,24,17]);
        }
        translate([-8,0,0]) cylinder(h = 50, r = 4);
        translate([8,0,0]) cylinder(h = 50, r = 4);
        translate([-10,-3,5.4]) cube(size = [20,6,6.2]);
        translate([-20,3,8.5]) rotate([0,90,0]) cylinder(h = 40, r = 3.1);
        translate([-20,-3,8.5]) rotate([0,90,0]) cylinder(h = 40, r = 3.1);
    }
}