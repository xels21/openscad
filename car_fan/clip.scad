/*    
   /||\
  / || \
 /  ||  \
 \  ||  /
  | || | 
  | || | 
  | || | 
  | || | 
  | || | 
__|(__)|__
|_,----,_|

     _
    ||
    ||
    ||
    ||
    ||
    ||
    ||
  ======
*/


h=7;
d=8.8;
r=d/2;
stand_h=1;
upper_d_plus=2;
upper_r_plus=upper_d_plus/2;
inner_d = upper_d_plus;
inner_r=inner_d/2;
stand_d=2*d-1;
stand_r=stand_d/2;


upper_corr=2;
stabilizer=0.5;

h_max=stand_h+h+upper_r_plus+upper_r_plus+r-upper_corr;
res=128;

upper_minus=0.4;

difference(){
  rotate_extrude($fn=res) 
  polygon( points=[
    [inner_r,stabilizer],
    [inner_r+stabilizer*2,0],
    [stand_r-1,0],
    [stand_r,stand_h],
    [r+stabilizer,stand_h],
    [r,stand_h+stabilizer],
    [r,stand_h+h],
    [r+upper_r_plus-upper_minus,stand_h+h+upper_r_plus-upper_minus],
    [r+upper_r_plus-upper_minus,stand_h+h+upper_r_plus+upper_minus],
    [inner_r+upper_corr,h_max],
    [inner_r,h_max]
  ]);
  translate([0,0,50+stand_h+stabilizer+(inner_d*1.8)/2])
  cube([inner_d-0.2, 100, 100], center=true);

  translate([-inner_d*1.4,-50,h_max+inner_d*2-inner_d*0.4])
  scale([1,1,4])
  rotate([0,45,0])
  cube([inner_d*2, 100, inner_d*2]);
  
  translate([0,0,stand_h+(inner_d*1.8)/2+stabilizer])
  rotate([90,0,0])
  cylinder(d=inner_d*1.5,h=100,$fn=res, center=true);
}
