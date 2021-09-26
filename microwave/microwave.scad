/*
              /
  h          /
  |     |   /
  |     |__/
  |    /
  |___/
     w1 w2 w_add_1
*/


h=20;
w1=8.4;
w2=14.5;

inner_right_w = w2-3.5;
inner_left_w = 2.5;

h_add_0=10;
h_add_1=h_add_0+20;
w_add_0=w2;
w_add_1=w2+10;
w_add_2=w_add_1+5;

clip_h=5.5;
clip_helper_h=clip_h-2;

connector_h=10;
connector_h_puffer=20;
connector_h_helper = 2;

thickness=2;
thickness_add=1;

print_h=145;

  
cut_out_h=4;
cut_out_h2=20;


complete();

module complete(){
  translate([2,0,0])complete_plus();
  complete_minus();
  //printhelper
}

module complete_minus(){
  mirror([1,0,0])union(){
    difference(){
      main();
      translate([0,0,print_h-connector_h_puffer]) cube([w1,h,connector_h_puffer]);
      translate([thickness,thickness,0]) cube([7,10,cut_out_h]);
    }
    connector_minus();
    translate([13,13,0]) linear_extrude(0.2)circle(r=25);
  }
}

module complete_plus(){
 difference(){
  main();
  translate([0,0,print_h-connector_h_puffer]) cube([w1,h,connector_h_puffer]);
  translate([thickness,thickness,0]) cube([7,10,cut_out_h]);
 }
 connector_plus();
 translate([13,13,0]) linear_extrude(0.2)circle(r=25);
}

module connector_minus(){ 
  connector_bridge();
  translate([0,0,print_h-connector_h_puffer]) rotate([90,0,90]) connector();
}

module connector_plus(){
  connector_bridge();
  translate([0,h,print_h-connector_h_puffer]) rotate([90,0,90]) mirror([1,0,0]) connector();
}

module connector_bridge(){
    translate([w1,h_add_0,print_h-connector_h_puffer]) cube([w1-thickness,h_add_0,connector_h_puffer]);
}

module connector(){
  tolerance=0.1;
  linear_extrude(w1) polygon (
  [[0,0]
    ,[0,connector_h_puffer]
    ,[1/5*h+tolerance,connector_h_puffer+connector_h_helper]
    ,[1/5*h+tolerance,connector_h_puffer+connector_h]
    ,[2/5*h-tolerance,connector_h_puffer+connector_h]
    ,[2/5*h-tolerance,connector_h_puffer+connector_h_helper]
    ,[3/5*h,connector_h_puffer-connector_h_helper]
    ,[3/5*h,connector_h_puffer-connector_h]
    ,[4/5*h,connector_h_puffer-connector_h]
    ,[4/5*h,connector_h_puffer-connector_h_helper]
    ,[h,connector_h_puffer]
    ,[h,0]
    ]);
  //translate([0,0,print_h-connector_h-connector_h_puffer]) cube([w1,h,connector_h_puffer]);
}

module main(){
 difference(){
  linear_extrude(print_h) polygon (
  [[0,0]
  ,[w1,0]
  ,[w2,h_add_0]

  //additional right
  ,[w_add_1,h_add_0]
  ,[w_add_2,h_add_1]
  ,[w_add_2-thickness_add,h_add_1]
  ,[w_add_1-thickness_add,h_add_0+thickness_add]
  ,[w_add_0,h_add_0+thickness_add]

  ,[w_add_0,h]
  ,[w_add_0-thickness,h]
  ,[inner_right_w,h-clip_helper_h]
  ,[inner_right_w,h-clip_h]
  ,[w2-thickness,h-clip_h]
  ,[w2-thickness,h_add_0+thickness]


  ,[w1-thickness,thickness]
  ,[inner_left_w,thickness]
  ,[inner_left_w,h_add_0+thickness]
  ,[thickness,h_add_0+thickness]
  ,[thickness,h-clip_h]
  ,[inner_left_w,h-clip_h]
  ,[inner_left_w,h-clip_helper_h]
  ,[thickness,h]
  ,[0,h]
  ]
  );

  
  translate([thickness,h-clip_h,0]) cube([w2-2*thickness,clip_h,cut_out_h]);
  translate([thickness,h-clip_h,cut_out_h2]) cube([w2-2*thickness,clip_h,print_h-cut_out_h2]);
  //translate([thickness,h-clip_h,0]) cube([w2-2*thickness,clip_h,print_h]);
}
}