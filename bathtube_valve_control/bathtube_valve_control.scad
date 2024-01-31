/*

 ___
|---|_ ___ ___
|---| *   *   |____
|---|         |---|
|---|         |___|
|---|_.___.___|
|___|

*/
use <../libs/Gears Library for OpenSCAD/files/Getriebe.scad>;
use <../libs/Star.scad>;

$fn=64;

big_gear_h=13;
big_gear_d1=14;
big_gear_d2=18;
big_gear_teeth_count=13;

middle_d=10.5;
middle_h=26;
middle_ring_depth=1.5;
middle_ring_h=2.2;

ring_1_h_off=4;
ring_2_h_off=21;

small_gear_h=20;
// small_gear_h=10;
small_gear_d1=8.6;    //10
small_gear_d2=10.8; //11
small_gear_teeth_count=20;

connector_size=small_gear_d1-2;

// all();
// middle();
// small_gear();


// rotate([90,0,0])
other_with_connector();
big_gear_with_connector();



module all(){
  big_gear();
  translate([0,0,big_gear_h])
  middle();
  translate([0,0,big_gear_h+middle_h])
  small_gear();
}

module connector(tol=0, length=10){
  translate([0,0,length/2]) 
  cube([connector_size+tol,connector_size+tol,length],center=true);
}

module other_with_connector(){
  connector(tol=0.0,length=big_gear_h);
  translate([0,0,big_gear_h])
  middle();
  translate([0,0,big_gear_h+middle_h])
  small_gear();
}

module big_gear_with_connector(){
  difference(){
    big_gear(big_gear_h=big_gear_h-.6);
    connector(tol=0.6,length=big_gear_h);
  }
}

module big_gear(big_gear_h=big_gear_h){
  // cylinder(d=big_gear_d2,h=big_gear_h);
  // modul    = Höhe des Zahnkopfes über dem Teilkreis
  // zahnzahl = Anzahl der Radzähne
  // d        = modul * zahnzahl;
  correction = 0.6; //dont know why...
  modul = (big_gear_d2-big_gear_d1)/2 * correction;
  stirnrad(modul=modul, zahnzahl=big_gear_teeth_count, breite=big_gear_h, bohrung=0, eingriffswinkel=25, schraegungswinkel=0, optimiert=true);
}

module middle(){
  difference(){
    cylinder(d=middle_d,h=middle_h);

    translate([0,0,ring_1_h_off])
    middle_ring();

    translate([0,0,ring_2_h_off])
    middle_ring();
  }
}

module middle_ring(){
  rotate_extrude()
  translate([(middle_d/2)-middle_ring_depth,0,0])
  square([middle_ring_depth,middle_ring_h]);
}

module small_gear(){
  linear_extrude(small_gear_h) 
  Star(points=small_gear_teeth_count, outer=small_gear_d2/2, inner=small_gear_d1/2);
}