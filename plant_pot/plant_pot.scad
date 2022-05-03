d_up=88;
d_down=65;
h=73;

thickness=2;

res=128;


intersection() {

    translate([0,0,-thickness]) 
    cube([d_up*2,d_up*2,h+thickness],center=true);

    difference() {
        sphere(d_up*0.85, $fn=6);


        translate([0,0,-h/2])
        rotate_extrude($fn=res)
        polygon(points=[
            [0,0],
            [d_down/2,0],
            [d_up/2,h],
            [0,h]
        ]);
    }

}