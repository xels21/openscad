module Brick_Block_Box(Block_Size=60){

// Overall width and length of block
Block_Size = Block_Size; //[12:0.25:100]

// Number of brick layers
Layers = 3; //[1:1:12]

// Size of the chamfer between bricks
Chamfer_Size = 2; //[0.25:0.25:8]

// Determines the brick height
Pixel_Ratio = 3;  //[3:"3D Mario", 4:"Classic Mario"]

// Block style
Style = 1; //[1:"Solid Block", 2:"Tube", 3:"Cup", 4:"Lid", 5:"Wall"]

// Width of block walls (only used with some styles)
Wall_Width =  4;

// Height of lip on lids
Lid_Lip_Height =  10;

// Additional space between fitting parts (only used with some styles)
Clearance = 0.125;

// Add chamfer to block corners
Chamfer_Corners = true;

// Add pattern to top layer
Top_Layer_Pattern = true;

// Add pattern to bottom layer (may harm print quality)
Bottom_Layer_Pattern = true;

// Determines the first layer brick pattern
Brick_Pattern = 0;  //[0:"Default", 1:"Alternate"]

pixel_size = Block_Size / Pixel_Ratio;

// Regardless of pixel size, some measurements are based on 1/4 the block measurement.
quarter_block = Block_Size / 4;


module makeLayer(layer_index, max_layer_index) {
  difference() {

    cube([Block_Size, Block_Size, pixel_size], true);

    // Corner Chamfers
    if (Chamfer_Corners) {
      translate([Block_Size/2, Block_Size/2, 0]) {
        linear_extrude(Block_Size, center=true) {
          polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
        }
      }
      translate([-Block_Size/2, -Block_Size/2, 0]) {
        linear_extrude(Block_Size, center=true) {
          polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
        }
      }
      translate([-Block_Size/2, Block_Size/2, 0]) {
        linear_extrude(Block_Size, center=true) {
          polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
        }
      }
      translate([Block_Size/2, -Block_Size/2, 0]) {
        linear_extrude(Block_Size, center=true) {
          polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
        }
      }

    }


    // Inner Chamfers
    translate([Block_Size/2, 0, 0]) {
      linear_extrude(Block_Size, center=true) {
        polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
      }
    }
    translate([-Block_Size/2, 0, 0]) {
      linear_extrude(Block_Size, center=true) {
        polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
      }
    }
    translate([Block_Size/4, Block_Size/2, 0]) {
      linear_extrude(Block_Size, center=true) {
        polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
      }
    }
    translate([-Block_Size/4, Block_Size/2, 0]) {
      linear_extrude(Block_Size, center=true) {
        polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
      }
    }
    translate([Block_Size/4, -Block_Size/2, 0]) {
      linear_extrude(Block_Size, center=true) {
        polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
      }
    }
    translate([-Block_Size/4, -Block_Size/2, 0]) {
      linear_extrude(Block_Size, center=true) {
        polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
      }
    }

    // Top Chamfers
    for (z = [0:1:3]) {
      rotate([0, 0, 90 * z + 90 * Brick_Pattern]) {
        translate([0, Block_Size/2, pixel_size/2]) {
          rotate([0, 90, 0]) {
            linear_extrude(Block_Size + 1, center=true) {
              polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
            }
          }
        }
      }
    }

    // Bottom Chamfers
    for (z = [0:1:3]) {
      rotate([0, 0, 90 * z + 90 * Brick_Pattern]) {
        translate([0, Block_Size/2, -pixel_size/2]) {
          rotate([0, 90, 0]) {
            linear_extrude(Block_Size, center=true) {
              polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
            }
          }
        }
      }
    }

    // Top layer chamfers
    if (layer_index == max_layer_index && Top_Layer_Pattern) {
      translate([quarter_block * 3, 0, pixel_size/2]) {
        rotate([0, 90, 0]) {
          linear_extrude(Block_Size, center=true) {
            polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
          }
        }
      }
      translate([-quarter_block * 3, 0, pixel_size/2]) {
        rotate([0, 90, 0]) {
          linear_extrude(Block_Size, center=true) {
            polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
          }
        }
      }
      translate([0, quarter_block, pixel_size/2]) {
        rotate([0, 90, 0]) {
          linear_extrude(quarter_block * 2, center=true) {
            polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
          }
        }
      }
      translate([0, -quarter_block, pixel_size/2]) {
        rotate([0, 90, 0]) {
          linear_extrude(quarter_block * 2, center=true) {
            polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
          }
        }
      }
      rotate([0, 0, 90]) {
        translate([0, -quarter_block, pixel_size/2]) {
          rotate([0, 90, 0]) {
            linear_extrude(Block_Size + 1, center=true) {
              polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
            }
          }
        }
      }
      rotate([0, 0, 90]) {
        translate([0, quarter_block, pixel_size/2]) {
          rotate([0, 90, 0]) {
            linear_extrude(Block_Size + 1, center=true) {
              polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
            }
          }
        }
      }

    }

    // Bottom layer chamfers
    if (layer_index == 1 && Bottom_Layer_Pattern) {
      translate([quarter_block  * 3, 0, -pixel_size/2]) {
        rotate([0, 90, 0]) {
          linear_extrude(Block_Size, center=true) {
            polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
          }
        }
      }
      translate([-quarter_block  * 3, 0, -pixel_size/2]) {
        rotate([0, 90, 0]) {
          linear_extrude(Block_Size, center=true) {
            polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
          }
        }
      }
      translate([0, quarter_block, -pixel_size/2]) {
        rotate([0, 90, 0]) {
          linear_extrude(quarter_block * 2, center=true) {
            polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
          }
        }
      }
      translate([0, -quarter_block, -pixel_size/2]) {
        rotate([0, 90, 0]) {
          linear_extrude(quarter_block * 2, center=true) {
            polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
          }
        }
      }
      rotate([0, 0, 90]) {
        translate([0, -quarter_block, -pixel_size/2]) {
          rotate([0, 90, 0]) {
            linear_extrude(Block_Size + 1, center=true) {
              polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
            }
          }
        }
      }
      rotate([0, 0, 90]) {
        translate([0, quarter_block, -pixel_size/2]) {
          rotate([0, 90, 0]) {
            linear_extrude(Block_Size + 1, center=true) {
              polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
            }
          }
        }
      }
    }




  }

}

// Style: Solid Block
if (Style == 1) {
  union() {
    // Loop through layers (z)
    for (z = [1:1:Layers]) {
      translate([0, 0, z * pixel_size - pixel_size / 2]) {
        rotate([0, 0, 90 * z + 90 * Brick_Pattern ]) {
          makeLayer(z, Layers);
        }
      }
    }
  }
}

// Style: Tube
if (Style == 2) {
  difference() {
    union() {
      // Loop through layers (z)
      for (z = [1:1:Layers]) {
        translate([0, 0, z * pixel_size - pixel_size / 2]) {
          rotate([0, 0, 90 * z + 90 * Brick_Pattern]) {
            makeLayer(z, Layers);
          }
        }
      }
    }
    difference() {
      translate([-Block_Size/2 + Wall_Width, -Block_Size/2 + Wall_Width, -1]) {
        cube([Block_Size - Wall_Width * 2, Block_Size - Wall_Width * 2, pixel_size * Layers + 2]);
      }
    }
  }
}

// Style: Cup
if (Style == 3) {
  difference() {
    union() {
      // Loop through layers (z)
      for (z = [1:1:Layers]) {
        translate([0, 0, z * pixel_size - pixel_size / 2]) {
          rotate([0, 0, 90 * z + 90 * Brick_Pattern]) {
            makeLayer(z, Layers);
          }
        }
      }
    }
    difference() {
      translate([-Block_Size/2 + Wall_Width, -Block_Size/2 + Wall_Width, Wall_Width]) {
        cube([Block_Size - Wall_Width * 2, Block_Size - Wall_Width * 2, pixel_size * Layers]);
      }
      // Inner chamfers
      for (i = [0:1:3]) {
        rotate([0, 0, 90 * i]) {
          translate([Block_Size/2 - Wall_Width, 0, Wall_Width]) {
            rotate([90, 0, 0]) {
              linear_extrude(Block_Size, center=true) {
                polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
              }
            }
          }
        }
      }
    }
  }
}


// Style: Lid
if (Style == 4) {
  difference() {
    union() {
      // Loop through layers (z)
      for (z = [1:1:Layers]) {
        translate([0, 0, z * pixel_size - pixel_size / 2]) {
          rotate([0, 0, 90 * z + 90 * Brick_Pattern]) {
            makeLayer(z, Layers);
          }
        }
      }
      // Add lid lip
      translate([-Block_Size/2 + Wall_Width, -Block_Size/2 + Wall_Width, pixel_size * Layers - Chamfer_Size]) {
      cube([Block_Size - Wall_Width * 2 - Clearance * 2, Block_Size - Wall_Width * 2 - Clearance * 2, Lid_Lip_Height + Chamfer_Size], false);
      }
    }
    difference() {
      translate([-Block_Size/2 + Wall_Width * 2, -Block_Size/2 + Wall_Width * 2, Wall_Width]) {
        cube([Block_Size - Wall_Width * 4, Block_Size - Wall_Width * 4, pixel_size * Layers + Lid_Lip_Height + 1]);
      }
      // Inner chamfers
      for (i = [0:1:3]) {
        rotate([0, 0, 90 * i]) {
          translate([Block_Size/2 - Wall_Width * 2, 0, Wall_Width ]) {
            rotate([90, 0, 0]) {
              linear_extrude(Block_Size, center=true) {
                polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
              }
            }
          }
        }
      }
    }
    // Outer chamfers
    for (i = [0:1:3]) {
      rotate([0, 0, 90 * i]) {
        translate([Block_Size/2 - Wall_Width, 0, pixel_size * Layers + Lid_Lip_Height]) {
          rotate([90, 0, 0]) {
            linear_extrude(Block_Size, center=true) {
              polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
            }
          }
        }
      }
    }
    for (i = [0:1:3]) {
      rotate([0, 0, 90 * i]) {
        translate([Block_Size/2 - Wall_Width, Block_Size/2 - Wall_Width, pixel_size * Layers]) {
          linear_extrude(Lid_Lip_Height * 2) {
            polygon([[Chamfer_Size,0],[0,Chamfer_Size],[-Chamfer_Size,0],[0,-Chamfer_Size]]);
          }
        }
      }
    }
  }
}

// Style: Wall
if (Style == 5) {
  difference() {
    union() {
      // Loop through layers (z)
      for (z = [1:1:Layers]) {
        translate([0, 0, z * pixel_size - pixel_size / 2]) {
          rotate([0, 0, 90 * z + 90 * Brick_Pattern ]) {
            makeLayer(z, Layers);
          }
        }
      }
    }
    translate([0, Block_Size/4, 0]) {
      cube([Block_Size + 1, Block_Size+ 1, Block_Size * Layers], true);
    }
  }
}

}