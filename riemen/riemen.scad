d=64;
r_help=0.5; //needed for printing issues
r=d/2;
r_plus=3;
h2=5;
h1=3;


h_diff= h2-h1;

res=256;

rotate_extrude($fn=res){
  
  
  polygon(points=[
    [r+r_plus,0],
    [r-r_help+r_plus,0],
    [r,h_diff],
    [r,h_diff/2+h1],
    [r-r_help+r_plus,h2],
    [r+r_plus,h2]
  ]);

}