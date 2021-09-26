b=70;//68-70

cable_w=10;//8;
cable_h=6;//4;

thick = 1;

height = 18;

difference(){
    outer_all();
    inner_all();
}
 


module outer_all(){
    union(){
        switch_outer();
        cable_top_outer();
        cable_right_outer();
        cable_right_bottom_outer();
        cable_right_bottom_outer_2();
    }
}

module inner_all(){
    union(){
        switch_inner();
        cable_top_inner();
        cable_right_inner();
        cable_right_bottom_inner();
        cable_right_bottom_inner_2();
    }
}

add=20;


module cable_right_bottom_outer_2(){
    // translate([b/2 + add/2  + cable_h, -b/2 + cable_h/2  +thick/2  ,cable_h/2+thick/2])
    translate([b/2 + cable_w/2  + cable_h, -b/2 + (cable_w + thick*2)/2 - thick ,cable_w/2+thick/2])
    cube([cable_w, cable_w + thick*2 ,cable_w+thick],center=true);
}


module cable_right_bottom_inner_2(){
    // translate([b/2 + add/2  + cable_h, -b/2 + cable_h/2  +thick/2  ,cable_h/2])
    translate([b/2 + cable_w/2  + cable_h-thick, -b/2 + (cable_w + thick*2)/2 - thick  ,cable_w/2])
    cube([cable_w,cable_w,cable_w],center=true);
}



module cable_right_bottom_outer(){
    // translate([b/2 + add/2  + cable_h, -b/2 + cable_h/2  +thick/2  ,cable_h/2+thick/2])
    translate([b/2 + add/2  + cable_h, -b/2 + (cable_w + thick*2)/2 - thick ,cable_h/2+thick/2])
    cube([add, cable_w + thick*2 ,cable_h+thick],center=true);
}


module cable_right_bottom_inner(){
    // translate([b/2 + add/2  + cable_h, -b/2 + cable_h/2  +thick/2  ,cable_h/2])
    translate([b/2 + add/2  + cable_h, -b/2 + (cable_w + thick*2)/2 - thick  ,cable_h/2])
    cube([add,cable_w,cable_h],center=true);
}



module cable_right_outer(){
    translate([b/2+cable_h/2 + thick/2, cable_h/2,  cable_w/2 + thick/2])
    cube([cable_h+thick, b + cable_h + thick*2 ,cable_w + thick],center=true);
}


module cable_right_inner(){
    translate([b/2+cable_h/2, cable_h/2 ,cable_w/2])
    cube([cable_h, b + cable_h ,cable_w],center=true);
}


module cable_top_outer(){
    translate([cable_h/2, b/2+cable_h/2 + thick/2, cable_w/2 + thick/2])
    cube([b + cable_h + thick*2,cable_h+thick,cable_w + thick],center=true);
}


module cable_top_inner(){
    translate([cable_h/2,b/2+cable_h/2,cable_w/2])
    cube([b + cable_h,cable_h,cable_w],center=true);
}

module outer_wall(){
    difference(){
        switch_outer();
        switch_inner();
    }
}

module switch_outer(){
    translate([0,0,height/2])
    cube([b+thick*2,b+thick*2,height],center=true);
}

module switch_inner(){
    translate([0,0,height/2])
    cube([b,b,height],center=true);
}
