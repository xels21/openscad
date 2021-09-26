use <..\libs\Round-Anything\MinkowskiRound.scad>;

min_width = 35;
min_height = 35;

depth = 10;
z=40;

top = 25;
cor = 5;

rad=5;
// rad=0;
res=64;

hole=4;


difference(){

    minkowskiOutsideRound(3)
    linear_extrude(z)
    offset(-rad)
    offset(rad)

    offset(-3*rad)
    offset(3*rad)
    polygon(points=[
        [0,-2*cor],
        [cor,0],

        [min_width-cor,0],
        [min_width,-cor],

        [min_width,-min_height+cor/2],
        [min_width+cor/2,-min_height],

        [min_width+depth-cor/2,-min_height],
        [min_width+depth,-min_height+cor/2],

        [min_width+depth,depth-2.5*cor],
        [min_width+depth-2.5*cor,depth],


        [depth,depth],
        [depth,top+depth],
        [0,top+depth+cor],
    ]);


    translate([0,depth+top/2+cor/2,z/2])
    rotate([0,90,0])
    union(){
        translate([0,0,-1])
        cylinder(h=2*depth, d=hole,$fn=res);
        
        translate([0,0,depth*0.35])
        cylinder(h=depth, d1=0, d2=hole*3.2,$fn=res);
    }


}