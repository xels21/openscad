wall_width=.25;

b_width = 7.3;
b_width_s = 6.9;
b_height = 14.3;
b_height_s = 13.5;

bottom_h = 1.5;




difference(){

 union(){   
cylinder(d=b_width+wall_width,h=b_height+wall_width,$fn=100);
translate([-2,-4,0])cube([4,1,b_height+wall_width]);
 }
    
translate([-5,-2.8,bottom_h+wall_width])cube([10,10,b_height_s-bottom_h]);

translate([0,0,wall_width])union(){
cylinder(d=b_width,h=b_height_s,$fn=100);
cylinder(d=b_width_s,h=b_height,$fn=100);
}

}

