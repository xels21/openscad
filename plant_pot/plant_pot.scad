use <../libs/geodesic_sphere.scad>;
// Use it exactly like you would use the OpenSCAD sphere()

d_up=88;
d_down=65;
h=73;

thickness=2;

res=128;



// translate([0,0,h*.6]) 
// pot(d_up=d_up+1, d_down=d_down+1, h=h+1, thickness=thickness);

under_pot(d=(d_up+1)*1,thickness=2,offset=16,up_plus=4);

module under_pot(d,thickness,offset,up_plus, up_fac=3){
    
    rotate_extrude($fn=16)
    union(){
        square([d/2+offset,thickness]);
        translate([d/2+offset-up_plus,thickness,0])
        scale([1,up_fac,1]) 
        intersection() {
            circle(r=up_plus, $fn=16);
            translate([-up_plus,0,0]) 
            square([up_plus*2,up_plus]);
        }
    }
}

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