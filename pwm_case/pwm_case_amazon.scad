use <../libs/Round-Anything/MinkowskiRound.scad>;
use <../libs/openscad_xels_lib/round.scad>;



/*

   |----------------|
  -|                |
  =|              ()|
  -|                |
   |----------------|


*/



x_raw=32;
y_raw=32;
z_raw=15;

x_tol=4;
y_tol=1;
z_tol=0.5;

x=x_raw+x_tol;
y=y_raw+y_tol;
z=z_raw+z_tol;

thickness=2;
r=1.5;

x_max = x + 2*thickness;
y_max = y + 2*thickness;
z_max = z + 2*thickness;

hole_d=7.5;
hole_z_fac=1.5;

        screw_d=3;
        screw_off=3;
        holes_plate_y = 2*screw_off+ screw_d;

        screw_h=3;


pwm_case_amazon();

module pwm_case_amazon(w_holes=true){
    difference(){
        minkowskiOutsideRound(r)
        union(){
            cube([x_max,y_max,z_max],center=true);
            if(w_holes){
                for (m=[0:1]) mirror([0,m,0]) {
                    translate([0,y_max/2+holes_plate_y/2,-z_max/2+screw_h/2]) 
                    difference() {
                        cube([x_max,holes_plate_y,screw_h], center=true);
                        for (m=[0:1]) mirror([m,0,0]) {
                            #translate([-x_max/2+screw_off+screw_d,0,-screw_h/2]) 
                            cylinder(h = screw_h, d = screw_d,$fn=8);
                        }
                    }
                }
            }
        }

        translate([-thickness,0,0])
        minkowskiOutsideRound(r)
        cube([x_max,y,z],center=true);

        translate([0,0,1.8])
        rounded_cube_y([x_max*2,hole_d,hole_d*hole_z_fac], r=hole_d*0.49, center=true);
    }
}