use <..\libs\Round-Anything\MinkowskiRound.scad>;

width= 25;
height=25;
holder=4.5;
thickness = 5;
z = 6;

holder_cut=width-holder*2;

minkowskiOutsideRound(2,2)
union(){
difference(){
  cube([width+thickness*2,height+thickness*2,z]);
  translate([thickness,thickness,0]) cube([width,height,z]);
  translate([thickness+holder,0,0]) cube([holder_cut,height,z]);
}

linear_extrude(z) polygon (
[[0,0]
,[-15,(height+thickness*2)/2]

//top
,[-20,height+thickness*2-2.5]
,[-17,height+thickness*2]
,[-14,height+thickness*2-2.5]

,[-10,(height+thickness*2)*2/3]

,[0,(height+thickness*2)/2]
]);
}



/*[[0,0]
,[-15,(height+thickness*2)/2]
,[-20,height+thickness*2-3]
,[-17,height+thickness*2]
,[-14,height+thickness*2-3]
,[-6,(height+thickness*2)*2/3]

,[-2,(height+thickness*2)/2-2]
,[0,(height+thickness*2)/2]]);

*/