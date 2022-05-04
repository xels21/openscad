use <../libs/geodesic_sphere.scad>;
// Use it exactly like you would use the OpenSCAD sphere()

d_up=88;
d_down=65;
h=73;

thickness=2;

res=128;


// geodesic_sphere(d_up*0.85, $fn=26);
pot(d_up=d_up+1, d_down=d_down+1, h=h+1, thickness=thickness);

module pot(d_up, d_down, h, thickness){
    intersection() {

        translate([0,0,-thickness]) 
        cube([d_up*2,d_up*2,h+thickness],center=true);

        difference() {
            geodesic_sphere(d_up*0.7, $fn=6);
            // sphere(d_up*0.85, $fn=6);


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
}