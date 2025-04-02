


thickness=2;
lenght = 290;
inner_d= 18;
outer_d= inner_d+thickness*2;

battery_d=15;
battery_x=51;
uC_x=18;

top_cut=outer_d-7;
res=64;

tube();
module tube(isBottom=true){

  intersection(){
    #cube([lenght,outer_d,top_cut]);
    tube_raw();
  }
}

module tube_raw(){
  translate([0,outer_d/2,outer_d/2])
  rotate([0,90,0])
  difference() {
    cylinder(d=outer_d, h=lenght, $fn=res);
    cylinder(d=inner_d, h=lenght, $fn=res);
  }
}