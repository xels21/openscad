use <..\libs\openscad_xels_lib\switch_case.scad>;

desk_h=29;
desk_toleranze = 0;
desk_upper=11;
//desk_upper=0;

desk_lower = 24;
desk_sharp = 2;

switch_width=13;
switch_length = 20.5;
switch_stablizier_length =1.4;
switch_stablizier_width =6;

switch_h=20;

cable_width=5;
calbe_option="outside";
//calbe_option="inside";

thick = 1.2;

holder_thick=2.5;

winkel=3;

wall_thick = thick;
//wall_thick = 0;



difference(){
    linear_extrude(height = (thick*2)+(switch_stablizier_length*2)+switch_length) 
        polygon(points=
        [[0,0]
        ,[-desk_lower+desk_sharp,desk_toleranze]
        ,[-desk_lower,desk_toleranze+holder_thick]
        ,[-winkel,holder_thick]
        ,[0,winkel+holder_thick]
        
        ,[0,-winkel+holder_thick+desk_h]
        ,[-winkel,holder_thick+desk_h]
        ,[-desk_upper,holder_thick+desk_h-desk_toleranze+desk_toleranze*0.1]
        ,[-desk_upper+desk_sharp,holder_thick*2+desk_h-desk_toleranze]
        ,[0,holder_thick*2+desk_h]
    
        ,[wall_thick+thick+switch_width,holder_thick*2+desk_h]
        ,[wall_thick+thick+switch_width,(holder_thick*2+desk_h)-switch_h]
        ,[wall_thick,0]
    ]);
    
    translate([wall_thick,0,thick])switch_complete(h=desk_h+holder_thick*2);
    //switch body
    //translate([wall_thick,0,thick+switch_stablizier_length]) cube([switch_width,desk_h+holder_thick*2,switch_length]);
    
    //switch stabilizer
    //translate([wall_thick+((switch_width-switch_stablizier_width)/2),0,thick]) cube([switch_stablizier_width,desk_h+holder_thick*2,switch_length+switch_stablizier_length*2]);
    
    //cable outside
    if(calbe_option=="outside"){
       translate([wall_thick+switch_width,0,((thick*2+switch_stablizier_length*2+switch_length)-cable_width)/2])
       cube([thick,desk_h+holder_thick*2,cable_width]);
        }
        
    //cable inside
    if(calbe_option=="inside"){
        maxCut=max(desk_upper,desk_lower);
        
       translate([-maxCut,0,((thick*2+switch_stablizier_length*2+switch_length)-cable_width)/2])
       cube([maxCut,desk_h+holder_thick*2,cable_width]);
        }
}