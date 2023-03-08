use <Brick_Block_Box.scad>;

stove_d=50.5;
stove_h=3;
brick_x=55;

stick_d=2;
stick_h=20;

difference(){
  Brick_Block_Box(brick_x);

  translate([0,0,brick_x-stove_h])
  cylinder(d=stove_d, h=stove_h, $fn=128);

  translate([0,0,brick_x-stick_h-stove_h])
  cylinder(d=stick_d, h=stick_h, $fn=32);
}