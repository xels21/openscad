use <..\libs\Round-Anything\MinkowskiRound.scad>;

paste_w = 68;
paste_w_offset=1;
paste_t = 0.5;

thickness = 4;
height = 8;

minkowskiOutsideRound(2)
difference(){
    cube([thickness*2+paste_w+2*paste_w_offset,thickness*2+paste_t,height],center=true);
    cube([paste_w,+paste_t,height],center=true);
}