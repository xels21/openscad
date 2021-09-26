rod_d_raw = 8;
rod_d = rod_d_raw+1;
rod_gap = 45;
padding_x = 5;
padding_y = 5;

linear_glider_x=24;
linear_glider_d=15;
linear_glider_gap=2;
linear_glider_stab_h = 1;
linear_glider_stab_depth = 1;
linear_glider_stab_margin = 2;

max_x = padding_x + linear_glider_x + linear_glider_gap + linear_glider_x + padding_x;
max_y = padding_y + linear_glider_d/2 + rod_gap + linear_glider_d/2 + padding_y;

thickness = 5;

res=64;

front();
//linear_glider();

module front(){
    difference(){
        cube([max_x,max_y,thickness+linear_glider_d/2]);
        
        translate([0,max_y-padding_y-linear_glider_d/2,thickness+linear_glider_d/2])
        rotate([0,90,0])
        cylinder(d=rod_d,h=max_x,$fn=res);

        translate([max_x/2-linear_glider_x/2,linear_glider_d/2+padding_y,thickness+linear_glider_d/2])
        linear_glider();


        translate([0,padding_y+linear_glider_d/2,thickness+linear_glider_d/2])
        rotate([0,90,0])
        cylinder(d=rod_d,h=max_x,$fn=res);

        translate([padding_y,max_y-linear_glider_d/2-padding_y,thickness+linear_glider_d/2])
        linear_glider();

        translate([max_x-linear_glider_x-padding_x,max_y-linear_glider_d/2-padding_y,thickness+linear_glider_d/2])
        linear_glider();

    }
}

module linear_glider(){
    rotate([0,90,0])
    difference(){
        cylinder(d=linear_glider_d,h=linear_glider_x,$fn=res);
        cylinder(d=rod_d,h=linear_glider_x);
        translate([0,0,linear_glider_stab_margin])
        linear_glider_stab();
        translate([0,0,linear_glider_x-linear_glider_stab_h-linear_glider_stab_margin])
        linear_glider_stab();
    }
}
module linear_glider_stab(){
    difference(){
        cylinder(d=linear_glider_d,h=linear_glider_stab_h,$fn=res);
        cylinder(d=linear_glider_d-linear_glider_stab_depth*2,h=linear_glider_stab_h,$fn=res);
    }
}