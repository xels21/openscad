use <../libs/openscad_xels_lib\round.scad>;
use <../libs/openscad_xels_lib\pattern.scad>;
use <../libs/openscad_xels_lib\helper.scad>;
use <../libs/Round-Anything/MinkowskiRound.scad>;




x_raw=90;
y_raw=60;

padding=10;

x=x_raw+2*padding;
y=y_raw+2*padding;

step_h=10;
step_y=40;
// step_y=1;

thickness = 2;

res=128;

height = 10;

innerThickness = 2;
innerHeight = 2;

z_max=thickness + step_h + height;

// case();
top();

module top(){
  scale([2.8,2.8,1])
  linear_extrude(innerHeight+.5)
  text("R&D", font="Adobe Caslon Pro Bold", halign="center", valign="center", $fn=res); 

  sphere_d=3;
  translate([0,0,innerHeight])
  ellipse_sphere(x=x*0.99-sphere_d, y=y*0.99-sphere_d, sphere_d=sphere_d, acc=4, fn=32);
  difference(){
    scale([x*.99, y*.99, innerHeight]) { 
      cylinder(d=1,h=1,$fn=res);
    }
    scale([x*.99-6, y*.99-6, innerHeight]) { 
      cylinder(d=1,h=1,$fn=res);
    }
  }
  difference(){
    scale([x*.99, y*.99, innerHeight]) { 
      cylinder(d=1,h=1,$fn=res);
    }
    translate([-x/2,-y/2,0])
    pattern_hexagon(x_size = x, y_size = y, hex_size=12, gap=2, height=innerHeight);
  }
}


module case(){
  difference(){
    union(){
      //upper body
      translate([0,0,step_h])
      scale([x+2*thickness, y+2*thickness, thickness + height]) { 
        cylinder(d=1,h=1,$fn=res);
      }

      intersection(){
        scale([x+2*thickness, y+2*thickness, thickness + height]) { 
          cylinder(d=1,h=1,$fn=res);
        }
        translate([-(x+2*thickness)/2, -(y+2*thickness)/2+step_y-(y+2*thickness), 0])
        rounded_cube_y([x+2*thickness,y+2*thickness,step_h+3], r=3, center=false);
      }


      difference(){
        translate([0,0,3])
        scale([x+2*thickness, y+2*thickness, thickness + height-3]) { 
          cylinder(d=1,h=1,$fn=res);
        }
        translate([-(x+2*thickness)/2, -(y+2*thickness)/2+step_y, 0])
        rounded_cube_y([x+2*thickness,y+2*thickness,step_h], r=3, center=false);
      }
    }

    translate([0,0,thickness+step_h])
    minkowskiOutsideRound(3)
    scale([x-2*innerThickness, y-2*innerThickness, height+3]) { 
      cylinder(d=1,h=1,$fn=res/2);
    }

    translate([0,0,thickness+step_h+height-innerHeight])
    scale([x, y, innerHeight]) { 
      cylinder(d=1,h=1,$fn=res);
    }
  }
}
