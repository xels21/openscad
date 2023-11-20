use <../libs/Round-Anything/MinkowskiRound.scad>;

res=64;

height      = 29.5;
thick       = 5;
// z           = 15;
top_l       = 25;
bottom_l    = 35;
tri_r       = 6;
led_w_raw   = 10;
led_h_raw   = 2.6;
led_w       = led_w_raw + .3;
led_h       = led_h_raw + .3;
cable_gap   = 10;
cable_h     = 8;
cable_h_gap = 5;
span        = 2;
clam_corr   = 5;
cable_helper= 3;

conn_x=3;
conn_y=2;
conn_thick=3;
conn_tol=1.025;

conn_h=thick + cable_h + thick;
conn_min_x = conn_x+conn_thick;


bear_stab=4;
bear_d_raw=22;
bear_d=bear_d_raw+2;
bear_h_raw=7;
bear_h=bear_h_raw+1;
bear_hole=7.5;//M8

z = 50;

// with_connector = true;
// with_connector = false;

max_x =  thick + bottom_l;
// min_x = with_connector ? -(thick + cable_gap + thick + led_w -10) : -(thick + cable_gap + thick + led_w);
min_x = -(thick + cable_gap + thick + led_w);
max_y = thick + height + thick;



v2(with_connector=false);


// z = thick+bear_h+thick;
// v2(with_connector=true);

// translate([0,-10,0])
// rotate([90,0,0])
// v2_conn_bear();

module v2_conn_bear(){
    translate([+conn_x+conn_thick,0,0])
    connector();
    conn_bear_x=bear_stab+bear_d/2;

    difference(){
    union(){
        translate([-conn_bear_x,0,0])
        cube([conn_bear_x,conn_h,z]);

        translate([-bear_d/2-bear_stab,conn_h/2,0])
        cylinder(d=conn_h,h=z,$fn=res);
    }

    translate([-bear_d/2-bear_stab-1,conn_h/2,0])
    cylinder(d=7,h=z,$fn=res);

    translate([-conn_bear_x-bear_stab-+bear_d/2,0,(z-bear_h)/2])
    cube([conn_bear_x+bear_d/2,conn_h,bear_h]);
    }
}

module connector(){
    linear_extrude(height = z) 
    polygon(points=
    [
        [ -conn_x-conn_thick      , conn_thick+conn_y            ],
        [ -conn_x                 , conn_thick                   ],
        [ 0                       , conn_thick                   ],
        [ 0                       , conn_h - conn_thick          ],
        [ -conn_x                 , conn_h - conn_thick          ],
        [ -conn_x-conn_thick      , conn_h - conn_thick - conn_y],
    ]);
}

module v2(with_connector=false){
    difference(){
    minkowskiRound((thick-1)/2)
    v2_raw(with_connector);
        if(with_connector){
            scale([conn_tol,conn_tol,1])
            translate([min_x+conn_h,conn_tol*0.07,0])
            rotate([0,0,90])
            #connector();
        }
    }
}
module v2_raw(with_connector=false){

//START CLAM
    linear_extrude(height = z) 
    polygon(points=
    [
        [ 0                           , 0                    ],
        [ 0                           , max_y                ],
        [ top_l + thick - clam_corr   , max_y - span         ],
        [ top_l + thick               , max_y - span - thick ],
        [ thick                       , max_y - thick        ],
        [ thick                       , thick                ],
        [ thick                       , thick                ],
        [ thick + bottom_l            , thick + span         ],
        [ thick + bottom_l - clam_corr, span                 ],
        [ thick                       , 0                    ]
    ]);
//END CLAM

//START CABLE
    linear_extrude(height = z) 
    polygon(points=
    [
        [ 0                            , 0                       ],
        [ min_x                        , 0                       ],
        [ min_x                        , thick + cable_h + thick ],
        [ min_x + thick + cable_helper , thick + cable_h + thick ],
        [ min_x + thick + cable_helper , thick + cable_h         ],
        [ min_x + thick                , thick + cable_h         ],
        [ min_x + thick                , thick                   ],
        [ 0                            , thick                   ],
    ]);
//END CABLE

//START LED
led_y_plus = 3;
translate([0,thick + cable_h + thick + cable_h_gap,0])
    linear_extrude(height = z) 
    polygon(points=
    [
        [ 0                     , -4                    ],
        [ min_x                 , 0                     ],
        [ min_x                 , led_y_plus                 ],
        // [ -(led_w + thick)      , thick                 ],
        [ -(led_w + thick)      , led_y_plus + led_h + led_y_plus ],
        [ -(led_w - led_w * .3) , led_y_plus + led_h + led_y_plus ],
        [ -(led_w - led_w * .3) , led_y_plus + led_h         ],
        [ -(led_w)              , led_y_plus + led_h         ],
        [ -(led_w)              , led_y_plus                 ],
        [ 0                     , led_y_plus                 ],
        [ 0                     , led_y_plus + led_h         ],
        [ -0.8                  , led_y_plus + led_h         ],
        [ -0.8                  , led_y_plus + led_h + led_y_plus ],
        [ 0                     , led_y_plus + led_h + led_y_plus ],
    ]);
//END LED

    if(with_connector){
    linear_extrude(height = z) 
    polygon(points=
    [
        [ thick                        , 0                       ],
        [ min_x                        , 0                       ],
        [ min_x                        , -conn_x-conn_thick                       ],
        [ min_x+conn_h                        , -conn_x-conn_thick                       ],
    ]);
}
    

}

module v1(){
    difference() {
    cube(size = [bottom_l+thick,height+thick*2,z], center = false);
    
    translate([thick,thick,0])linear_extrude(height = z) 
        polygon(points=
        [[0,0]
        ,[0,height]
        
        ,[bottom_l/2,height-span/2]
        ,[bottom_l/2-4,height-span/2+thick+0.3] //without custom step -> ,[bottom_l/2,height-span/2+thick]
        ,[0,height+thick]
        
        ,[bottom_l+10,height+span]
        ,[bottom_l+10,span]
        
        ,[bottom_l,0-thick]
        ,[0,0-thick]
        ,[bottom_l-4,span-.7] // without custom step -> ,[bottom_l,span]
        ,[bottom_l,span+thick]
        ]);
    }
    
    //LED Halter
    translate([-led_w-thick,height-15,0])
    difference() {
    cube(size = [led_w+thick,led_h+thick*2,z], center = false);
    translate([thick,thick,])cube(size = [led_w+thick,led_h,z], center = false);
    translate([thick*2,thick*2,])cube(size = [led_w-thick-.4,led_h,z], center = false);
    } 

    //verstaerkung
    translate([-led_w-thick,0,0])
    difference() {
        translate([-cable_gap,0,0]) cube(size = [led_w+thick+cable_gap,height-15+thick,z], center = false);
        translate([thick-cable_gap,thick,]) cube(size = [led_w+thick+cable_gap,height-15-thick,z], center = false);
        // translate([-led_w-cable_gap,height-15,0]) cube(size = [cable_gap-thick,thick,z], center = false);
    }
}