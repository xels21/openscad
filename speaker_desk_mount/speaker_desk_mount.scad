use <../libs/Round-Anything/MinkowskiRound.scad>;
use <../libs/openscad_xels_lib\helper.scad>;
use <../libs/Poor_mans_openscad_screw_library/polyScrewThread_r1.scad>;

desk_h_raw=29;
desk_h_plus_metal=5;
desk_h_tol=.2;

span=2.5;

screw_h=15;
speaker_h_raw=70;
speaker_wo_screw_adjust_raw = 10;

metal_screw_d=6.1;
top_sub=10;
// thickness=7;
thickness=8;
desk_l=40;
// mount_z=20;
mount_z=22;


screw_res = 1;
screw_deg = 55;
screw_step = 4;
screw_d = 11;

headset_l = 47;
headset_h = 5;
headset_y_offset = 10;
headset_support= 10;

/*
|****--,,__
| ***--,,_|
| |    
| |_________
|      <  >|
|  ____<__>| 
| |
| |
| |
| |
| |
| |
|-|
|-|
|_|


*/

// translate([screw_d,0,0])
// screw();
// rotate([0,-90,0])
// under_mount(with_screw=false,with_headset=true,with_speaker=true,with_metal=false);
under_mount(with_screw=false,with_headset=true,with_speaker=true,with_metal=true);

module stamp(with_headset=false){
  iterations = with_headset?3:6;

  for(i = [0 : iterations]){
    translate([0,i*mount_z,0])
    scale([mount_z*.8,mount_z*.8,1])
    linear_extrude(1)
    twenty_one();
  }
}

module screw(){
  hex_screw(screw_d,  // Outer diameter of the thread
            screw_step,  // Thread step
            screw_deg,  // Step shape degrees
            screw_h+4,  // Length of the threaded section of the screw
            screw_res,  // Resolution (face at each 2mm of the perimeter)
            2,  // Countersink in both ends
            screw_d+5,  // Distance between flats for the hex head
            5,  // Height of the hex head (can be zero)
            0,  // Length of the non threaded section of the screw
            0);  // Diameter for the non threaded section of the screw
}

module under_mount(with_screw = true, with_headset = false, with_speaker=true, with_metal=true){
  desk_h=with_metal?desk_h_raw+desk_h_tol+desk_h_plus_metal:desk_h_raw+desk_h_tol;
  speaker_h = (with_speaker)?speaker_h_raw:0;
  speaker_wo_screw_adjust=(with_speaker)?speaker_wo_screw_adjust_raw:0;
  max_x = thickness + desk_l;
  max_y = (with_screw)?(speaker_h+screw_h+desk_h+thickness) : (speaker_h+speaker_wo_screw_adjust+thickness+desk_h+thickness);


  difference(){
    minkowskiRound((thickness-1)/2)
    union(){
      points_speaker = [        
        [thickness,speaker_h+speaker_wo_screw_adjust],
        [thickness,0],
        [0,0]
        ];
      
      points_headset = with_headset?[
        [0,max_y-thickness-headset_y_offset-headset_support],
        [-headset_l-thickness,max_y-thickness-headset_y_offset],
        [-headset_l-thickness,max_y+headset_h-headset_y_offset],
        [-headset_l,max_y+headset_h-headset_y_offset],
        [-headset_l,max_y-headset_y_offset],
        [0,max_y-headset_y_offset],
        [0,max_y]
      ]:[
        [0,max_y]
      ];

      points_desk = [
        [max_x-top_sub,max_y-span],
        [max_x-top_sub,max_y-span-thickness],
        [thickness,max_y-thickness],
        [thickness,max_y-thickness-desk_h],
        [thickness+desk_l,max_y-thickness-desk_h],
        [thickness+desk_l,speaker_h+speaker_wo_screw_adjust]
      ];



      linear_extrude(mount_z)
      polygon(points=concat(points_speaker,points_headset,points_desk));
      if(with_speaker){
        translate([0,0,mount_z/2])
        rotate([0,90,0])
        cylinder(d=mount_z, h=thickness);
      }
    }
    
    if(with_speaker){
      translate([0,0,+mount_z/2])
      rotate([0,90,0])
      cylinder(d=metal_screw_d, h=thickness*1.2, $fn=32);

      translate([.6,0,desk_l/9])
      scale([0.6,1,1])
      rotate([0,-90,0])
      stamp(with_headset);
    }
    if(with_screw){
      translate([thickness+desk_l-screw_d,speaker_h+screw_h,mount_z/2])
      rotate([90,0,0])
      screw_thread(screw_d,screw_step,screw_deg,screw_h,screw_res,0);
    }
  }
}