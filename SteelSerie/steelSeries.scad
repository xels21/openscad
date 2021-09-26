


difference(){
   union(){
        //Ost + West fixierung
        union(){
            translate ([0, 0, 7.25])cube([72,7,1.5],true);
            
            
            translate ([-34, 3, 4])cube([2,0.5, 8],true);
            translate ([34, -3, 4])cube([2,0.5, 8],true);
        }
    
        //Sued fixierung
        union(){
            translate ([0, -11, 7.25])cube([7,50,1.5],true);
            
            translate ([-3, -34, 4])cube([0.5, 2, 8],true);
        }
        
        //Nord fixierung
        difference(){
            union(){
                translate ([0, 11, 7.25])cube([9,50,1.5],true);
                
                
                translate ([4.25, 34, 4])cube([0.5, 2, 8],true);
                intersection(){
                    cylinder (h=9, d=68.5, $fn=200);
                    translate ([0, 10, 9])cube([9,50,2],true);
                }
            }
            
        }
    }
    
    //difference inner fix
    cylinder (h=10, d2=67, d1=67 , $fn=200);
}

//noppen
intersection(){
    difference(){
    cylinder (h=10, d=61 , $fn=200);
    cylinder (h=10, d=57 , $fn=200);
    }
    
    translate ([35, 35, 1]) rotate([90,0,-45]) cylinder (h=100, d=3, $fn=50);
}


difference(){
    //outter cylinder
    union(){
        cylinder (h=6, d2=73, d1=70 , $fn=200);
        translate ([0, 0, 6])cylinder (h=2, d=73 , $fn=200);
    }
    
    //inner cylinder
    union(){
        translate ([0, 0, 1]) cylinder (h=5, d2=71, d1=68 , $fn=200);
        translate ([0, 0, 6]) cylinder (h=2, d=71 , $fn=200);
    }
    
    //inner circle
    translate ([0, 0, 0.7]) cylinder (h=2, d=20,  $fn=100);
    //mark circle
    translate ([0, 30, 0.7]) cylinder (h=2, d=6,  $fn=50);
}

