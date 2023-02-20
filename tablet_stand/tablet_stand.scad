use <../libs/Round-Anything/MinkowskiRound.scad>;
/*

------,    ,-----------
|     |    |           ----------
|   /      |                      ----------,
|   \      |                                |
|     |    |                                |
|     `---`                                 |
|____________________________________________


*/

bottom_t = 5;
front_t = 10;

inner_cutaway_d = 4;
inner_cutaway_h = 8;

front_d=front_t+inner_cutaway_d;

inner_width=10;

inner_bottom_plus =5;

length_extension = 50;
extrude = 50;

smaller_fac = 0.3;

stand_deg = 0.7;

max_height = bottom_t + inner_bottom_plus+inner_cutaway_h;
max_l = front_d+inner_width+length_extension;

rad = 3;

all();
module all(){
  difference(){
    minkowskiOutsideRound(rad){
      intersection(){
        stand_hull();
        smaller();
      }
    }
    stand_inner();
  }
}
module smaller(){
  mirror([0,1,0])
  rotate([90,0,0])
  linear_extrude(height = max_height) 
  polygon(points = [
    [0,0],
    [0,extrude],
    [max_l,extrude*(1-smaller_fac/2)],
    [max_l,extrude*smaller_fac/2],
  ]);
}
module stand_hull(){

  linear_extrude(height = extrude) 
  polygon(points = [
    [0,0],
    [0,max_height],
    [front_d+inner_width,max_height],
    [max_l,max_height*0.5],
    [max_l,0],
  ]);
}

module stand_inner(){
  linear_extrude(height = extrude) 
  polygon(points = [
    [front_d,max_height],
    [front_t,max_height-inner_cutaway_h*stand_deg],
    [front_d,max_height-inner_cutaway_h],
    [front_d,bottom_t],
    [front_d+inner_width,bottom_t],
    [front_d+inner_width,max_height],
  ]);
}