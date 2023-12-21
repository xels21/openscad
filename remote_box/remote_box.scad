use <../libs/Round-Anything/MinkowskiRound.scad>;

x=48;
y=23;
z=55;

t=2;

x_max=t+x+t;
y_max=t+y+t;
z_max=t+z;

screw_d = 4;

res=99;

minkowskiOutsideRound(t*0.35)
union() {
  hook();
  box();
}

module hook(){
  translate(v = [x_max/2, 0, z_max]) 
  rotate([-90, 0, 0]) 
  difference() {

    cylinder(h = t, d = x_max, $fn=res);
    translate(v = [0, -x_max/4, 0]) 
    cylinder(h = t, d = screw_d,$fn=res/3);
  }
}

module box(){
  difference() {
    cube(size = [x_max, y_max, z_max]);
    translate(v = [t,t,t])
    cube(size = [x, y, z]);
  }
}