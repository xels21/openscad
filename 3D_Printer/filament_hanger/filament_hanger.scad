MAX_LENGTH_RAW = 550;
TOL = 8;
MAX_LENGTH = MAX_LENGTH_RAW-TOL;
FIL_COUNT = 4;

FIL_W_MAX = 116;
FILL_W_OFFSET = 9;
FIL_W = FIL_W_MAX-2*FILL_W_OFFSET;

FILL_H = 38;
THICKNESS = 6;

LENGTH = 60;

SINGLE_COUNT = 2;
PAIR_COUNT = FIL_COUNT-1;

SCREW_D = 3;
SCREW_L = 30;
SCREW_OFF = 13;
SCREW_D2 = 7;
SCREW_H2 = 2.5;

STABILAZER = 5;
RAD=2.5;

HOLDER_NIBBLE = 2;

DISTRIBUTOR_W=43;

SINGLE_BASE_W = SCREW_D + 1.4*THICKNESS;

module screw(){
  SCREW_MAX_H = SCREW_L+FILL_H;

  rotate([-90,0,0])
  translate([0,0,-SCREW_OFF])

  rotate_extrude($fn=32)
    polygon(points=[
    [0,0],
    [0,SCREW_MAX_H],
    [SCREW_D2/2,SCREW_MAX_H],
    [SCREW_D2/2,SCREW_L],
    [SCREW_D/2,SCREW_L-SCREW_H2],
    [SCREW_D/2,0]
    ]);
}

// SINGLE_COUNT*SINGLE_BASE_W
// + PAIR_COUNT*PAIR_BASE_W 
// + FIL_COUNT*FIL_W_MAX
// = MAX_LENGTH
// ml = sc*sw + pc*pw + fc*fw
// pc*pw = ml - sc*sw - fc*fw
PAIR_BASE_W = (MAX_LENGTH - SINGLE_COUNT*SINGLE_BASE_W - FIL_COUNT*FIL_W_MAX) / PAIR_COUNT;
echo("------------");
echo("SINGLE_BASE_W: ", str(SINGLE_BASE_W));
echo("------------");
echo("PAIR_BASE_W: ", str(PAIR_BASE_W));
echo("------------");
echo(2*SINGLE_BASE_W+4*FIL_W_MAX+3*PAIR_BASE_W+TOL)
echo("------------");

/*
 __ __
| || |
| || |
| || |
| || |_____
| ||      |
|/ \______|


      ___ ___
     |  ||  |
     |  ||  |
     |  ||  |
 ____|  ||  |_____
|       ||       |
|______/ \_______|

*/

    // screw();

    translate([0,0,FILL_H+THICKNESS])
rotate([-90,0,0]){
  translate([PAIR_BASE_W+FILL_W_OFFSET,0,0])
  single();
  pair();
}

  // pair();

// pair_outer();

module pair(){
    difference(){
    pair_outer();
    translate([0,0,1/6*LENGTH])
    screw();
    translate([0,0,3/6*LENGTH])
    screw();
    translate([0,0,5/6*LENGTH])
    screw();
  }
}
module pair_outer(){


 points = [
    [0,0],
    [PAIR_BASE_W/2+STABILAZER,0],
    [PAIR_BASE_W/2,STABILAZER],
    [PAIR_BASE_W/2,FILL_H],
    [PAIR_BASE_W/2+FILL_W_OFFSET-HOLDER_NIBBLE,FILL_H],
    [PAIR_BASE_W/2+FILL_W_OFFSET-HOLDER_NIBBLE,FILL_H-HOLDER_NIBBLE],
    [PAIR_BASE_W/2+FILL_W_OFFSET,FILL_H-HOLDER_NIBBLE],
    // [PAIR_BASE_W/2+FILL_W_OFFSET,FILL_H],
    [PAIR_BASE_W/2+FILL_W_OFFSET,FILL_H+THICKNESS],
    [0,FILL_H+THICKNESS]
    ];
  linear_extrude(LENGTH)
  offset(r=-RAD)
  offset(r=RAD)
  union(){
    polygon(points=points);
    mirror([1,0,0])
    polygon(points=points);
  }
}


module single(){
  difference(){
    single_outer();
    translate([SINGLE_BASE_W/2,0,1/6*LENGTH])
    screw();
    translate([SINGLE_BASE_W/2,0,3/6*LENGTH])
    screw();
    translate([SINGLE_BASE_W/2,0,5/6*LENGTH])
    screw();
  }
}
module single_outer(){

  linear_extrude(LENGTH)

  offset(r=-RAD)
  offset(r=RAD)
  polygon(points=[
    [0,STABILAZER],
    [-STABILAZER,0],
    [SINGLE_BASE_W+STABILAZER,0],
    [SINGLE_BASE_W,STABILAZER],
    [SINGLE_BASE_W,FILL_H],
    [SINGLE_BASE_W+FILL_W_OFFSET-HOLDER_NIBBLE,FILL_H],
    [SINGLE_BASE_W+FILL_W_OFFSET-HOLDER_NIBBLE,FILL_H-HOLDER_NIBBLE],
    [SINGLE_BASE_W+FILL_W_OFFSET,FILL_H-HOLDER_NIBBLE],
    [SINGLE_BASE_W+FILL_W_OFFSET,FILL_H+THICKNESS],
    [0,FILL_H+THICKNESS]]);

}










