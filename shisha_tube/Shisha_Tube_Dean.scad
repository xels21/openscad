ShishaBottomR=6;
ShishaTopR=8;
ShishaH=20;

rise = ShishaH/(ShishaTopR-ShishaBottomR);

TubeR=6.5;

TubeBottomR=5;
TubeTopR=TubeR+3;
TubeH=(TubeTopR-TubeBottomR)*rise;



InnerR=4.5;

difference(){
    cylinder(r=13,h=.3);
    cylinder(r=5,h=.3);
}

rotate_extrude($fn=100) 
polygon( points=[[TubeBottomR,0],
[TubeTopR,TubeH],

[TubeR+.5,TubeH],
[TubeR,TubeH+2],

[TubeR,TubeH+14],
[TubeR+1,TubeH+16.5],
[TubeR,TubeH+19],
[TubeR,TubeH+24.2],

[InnerR,TubeH+25],
[InnerR,0]] );