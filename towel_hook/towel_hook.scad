distance = 25;
factor = 0.65;

scale([factor,factor,factor])
union(){
    import("towelhook.stl");
    translate([-distance,0,0]) import("towelhook.stl");
    translate([distance,0,0]) import("towelhook.stl");
    translate([-30,-18,0]) cube([60,10,3.5]);
}