use <..\libs\openscad_xels_lib\connector\vert_clip.scad>;

thickness = 8;

z       =1;      //height
// z       =40;      //height
left    = thickness/2;      //left side
hold    = thickness;      //lenght of the "middle" part
right   = thickness;      //right side
hold_plus = thickness/2;      //amount of "hold" thats really holding
base    = thickness;
tol     = 0.13;
add     = thickness/2;


stab_support_h = 20;
xbox_height    = 80;
height_plus    = 10;

max_h = stab_support_h + xbox_height + height_plus;

stand_w=70;

xbox_holder_h=17;
xbox_holder_h_minus=5;
xbox_holder_h_clip=1;

xbox_down_w=25;
xbox_down_rad=5;

rad=2;

points=[
[-2*rad,3.5*thickness]
,[thickness*1.7,thickness*0.88]
,[stand_w+thickness,stab_support_h]
,[stand_w+thickness,stab_support_h+thickness+xbox_holder_h-xbox_holder_h_minus]
,[stand_w+xbox_holder_h_clip,stab_support_h+thickness+xbox_holder_h]
,[stand_w-xbox_holder_h_clip,stab_support_h+thickness+xbox_holder_h]
,[stand_w,stab_support_h+thickness+xbox_holder_h/2]
,[stand_w-xbox_holder_h/2,stab_support_h+thickness]
,[stand_w-xbox_down_w+xbox_down_rad,stab_support_h+thickness]
,[stand_w-xbox_down_w-xbox_down_rad,stab_support_h+thickness+xbox_down_rad]
,[-rad,xbox_height+stab_support_h]
,[-2*rad,max_h+2*rad]
];


xbox_controller_mount();
module xbox_controller_mount(){

  linear_extrude(height=z) 
  translate([0,2.5*thickness,0]) 
  // cube([thickness,max_h-2.5*thickness,z]);
  polygon([
    [0,0]
    ,[-thickness,0]
    ,[-thickness,max_h-2.5*thickness-tol]
    ,[0,max_h-2*thickness]
    ]);

    translate([-thickness,max_h,0])
    vert_clip_pos(  height    = z,
                    left      = left,
                    hold      = hold,
                    hold_plus = hold_plus,
                    base      = base,
                    tol       = -tol,
                    add       = add);
    

linear_extrude(height=z) 
difference(){
  offset(rad)
  offset(-rad)
  polygon(points);

  // offset(1)
  // offset(-7)
  // polygon(points=points);

translate([-2*rad,0]) 
square([2*rad,max_h]);
}





    translate([-thickness,2.5*thickness,0])
    vert_clip_neg(  height    = z,
                    left      = left,
                    hold      = hold,
                    hold_plus = hold_plus,
                    base      = base,
                    tol       = -tol,
                    tol       = 0,
                    add       = add,
                    right     = right);
}