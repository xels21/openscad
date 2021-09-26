use <..\libs\Round-Anything\MinkowskiRound.scad>;


led_w = 10.6; // RAW -> 10
led_h = 3.5;  // RAW -> 3
led_w_offset=1.5;

length=25;

thickness = 1.7;

res = 32;

led_mount();

module led_mount(withScrew = true){
    difference(){
        
        union(){
            //bottom
            translate([0,0,-1/2*thickness])
            cube([length,led_w+2*thickness,thickness],center=true);

            difference(){
                //upper part
                translate([0,0,1/2*(led_h)])
                minkowskiOutsideRound(thickness)
                cube([length,led_w+2*thickness,led_h+thickness+thickness],center=true);

                //inner part
                translate([0,0,1/2*(led_h-thickness)])
                minkowskiOutsideRound(thickness)
                cube([length+thickness*2,led_w,led_h+thickness],center=true);

                //upper offset part
                translate([0,0,1/2*(led_h+thickness)])
                cube([length+thickness*2,led_w-2*(led_w_offset),led_h+thickness],center=true);
            }
        }
        //screw
        if(withScrew){
            translate([0,0,-thickness])
            cylinder(h=thickness,d2=6,d1=3,$fn=res);
        }
    }
}