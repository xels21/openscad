use <Brick_Block_Box.scad>;


stove_d=47.5;
stove_d_add=0.7;
brick_x=stove_d+6;

brick_chamfer_size=2;
stove_h=8+brick_chamfer_size;



stick_d=2;
stick_h=25;



res=128;

inner_plus();

module inner_plus(){
  difference(){
    union(){
      Brick_Block_Box(brick_x, Chamfer_Size=brick_chamfer_size);

      translate([0,0,brick_x-brick_chamfer_size]) 
      cylinder(d1=stove_d+stove_d_add, d2=stove_d, h=stove_h, $fn=res);
    }
    translate([0,0,brick_x-stick_h+stove_h-brick_chamfer_size])
    cylinder(d=stick_d, h=stick_h, $fn=res/4);
  }
}

