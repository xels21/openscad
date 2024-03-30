/* Plant Tag
   by Lyl3

Creates a simple plant tag with a common name, variety name, and botanical name.

This code is published at:
https://www.thingiverse.com/thing:4793066
licensed under the Creative Commons - Attribution - Share Alike license (CC BY-SA 3.0)

V0.1 - basic functioning code
V0.2 - simplified text positioning
V0.3 - set some sane limits on the parameters
V0.4 - added parameters for variety name
V0.5 - tuned the spacing of the text
V0.6 - added a selection list of "specially selected" fonts
V0.7 - added parameters for adjusting the font spacing
V0.8 - corrected label thickness, compensating for the fudge factor of the Z location
V1.0 - ready for release
V1.1 - added a parameter for specifying the stake length
V1.2 - added an option for a reinforcing ridge down the middle of the stick the same height as the text
V1.3 - added an option for a border around the tag the same height as the text
V1.4 - added a parameter for specifying the stake width, allowed smaller tag width and font sizes
*/

/* [Plant Name Parameters] */
common_name = "Common Name";
variety_name = "Variety Name";
botanical_name = "Botanical name";

/* [Tag Parameters] */
// Specify what to generate.
generate = "all"; //["all", "base" ,"border" ,"label"]
// Specify the tag width (mm).
tag_width = 80; // [20:1:120]
// Specify the tag height (the rectanglular part) (mm).
tag_height = 23; // [6.0:1:60.0]
// Specify the tag thickness (mm).
tag_thickness = 1.0; // [0.6:0.01:5]
// Specify the length of the tag stake (mm).
stake_length = 40; // [10:100]
// Specify the width of the tag stake (mm).
stake_width = 5; // [2:30]
// Specify the label thickness (mm).
label_thickness = 0.5; // [0.2:0.01:3]
// border_thickness
border_thickness = 1.5; // [0.2:0.1:3]
// rounding
round_radius = 2; // [0:0.1:10]
// Reinforce the stick with a ridge down the center the same height as the text?
reinforce = "yes"; // [yes,no]

/* [Basic Font Parameters] */
// Some suitable fonts with italic styles
//"Arial";            // Microsoft font not available on Thingiverse customizer or Google Fonts
//"Liberation Sans";  // Curved joints on the glyphs are thin
//"Nunito Sans";      // Has tight kerning
//"Raleway";          // Has descended numbers
//"Roboto";           // No issues
//"Mali";             // An informal font with very even thickness on the glyphs
//"Montserrat";       // A font with very even thickness on the glyphs
//"Muli";
//"Niramit";
//"Rosario";
//"Rubik";
//"Ubuntu"


// Choose from a small selection of fonts that should work well for 3D printing small text. The black style, bold style, and bold italic style will be used for the common name, the variety name, and the botanical name respectively. (NOTE: Arial is not available on Thingiverse).
fontName = 1; // [1:Arial, 2:Nunito Sans, 3:Raleway, 4:Roboto, 5:Mali, 6:Montserrat, 0:other - specified in Advanced Font Parameters section ]

// Specify the font size for printing the common name of the plant.
common_name_font_size = 6; // [1:0.1:20]
// Specify the font size for printing the variety name of the plant.
variety_name_font_size = 4.6; // [1:0.1:20]
// Specify the font size for printing the botanical name of the plant.
botanical_name_font_size = 4.2; // [1:0.1:20]

/* [Advanced Font Parameters] */
// If "other" is selected for the font name in the Basic Parameters section, specify the font here to use for printing the common name of the plant.
common_name_font = "Liberation Sans:style=Bold";
// If "other" is selected for the font name in the Basic Parameters section, specify the font here to use for printing the variety name of the plant.
variety_name_font = "Liberation Sans:style=Bold";
// If "other" is selected for the font name in the Basic Parameters section, specify the font here to use for printing the botanical name of the plant.
botanical_name_font = "Liberation Sans:style=Bold Italic";
// If the position needs adjusting, specify the distance to shift up the common name of the plant (mm). A negative value shifts it down.
common_name_shift_up = -0.5; // [-3:0.1:10]
// If the position needs adjusting, specify the distance to shift up the variety name of the plant (mm). A negative value shifts it down.
variety_name_shift_up = -0.5; // [-3:0.1:10]
// If the position needs adjusting, specify the distance to shift up the botanical name of the plant (mm). A negative value shifts it down.
botanical_name_shift_up = 0.2; // [-2:0.1:10]
// If the spacing between the letters needs to be adjusted, specify the value. A value of 1 is normal spacing for the font. A larger value increases the spacing and a smaller value decreases the spacing.
common_name_spacing = 1; // [0.5:0.01:2]
// If the spacing between the letters needs to be adjusted, specify the value. A value of 1 is normal spacing for the font. A larger value increases the spacing and a smaller value decreases the spacing.
variety_name_spacing = 1; // [0.5:0.01:2]
// If the spacing between the letters needs to be adjusted, specify the value. A value of 1 is normal spacing for the font. A larger value increases the spacing and a smaller value decreases the spacing.
botanical_name_spacing = 1; // [0.5:0.01:2]


/* [Hidden] */
$fn=50;
fudge = .01;
reinforce_connector = 4.5;


// This convoluted way of selecting the font from an array was a requirement introduced by a change
// on the Thingiverse customizer that broke the ability to directly select fonts with a style specified.
// This issue was first noticed 2010-02-26 and probably happened within the two months prior to that date.
commonName_fontNames = ["Ski-bi dibby dib yo da dub dub Yo da dub dub"
  , "Arial Black:style=Regular"
  , "Nunito Sans:style=Black"
  , "Raleway:style=Black"
  , "Roboto:style=Black"
  , "Mali:style=Bold"
  , "Montserrat:style=Bold"];
varietyName_fontNames = ["Ba-da-ba-da-ba-be bop bop bodda bope Bop ba bodda bope"
  , "Arial:style=Bold"
  , "Nunito Sans:style=Bold"
  , "Raleway:style=Bold"
  , "Roboto:style=Bold"
  , "Mali:style=Bold"
  , "Montserrat:style=Bold"];
botanicalName_fontNames = ["Ska-badabadabadoo-belidabbelydabbladabbladabblabab-belibabbelibabbelibabbelabbelo-doobelidoo"
  , "Arial:style=Bold Italic"
  , "Nunito Sans:style=Bold Italic"
  , "Raleway:style=Bold Italic"
  , "Roboto:style=Bold Italic"
  , "Mali:style=Bold Italic"
  , "Montserrat:style=Bold Italic"];

selectedCommonNameFont = (fontName==0) ? common_name_font : commonName_fontNames[fontName];
selectedVarietyNameFont = (fontName==0) ? variety_name_font : varietyName_fontNames[fontName];
selectedBotanicalNameFont = (fontName==0) ? botanical_name_font : botanicalName_fontNames[fontName];



commonNameSpace = (common_name =="") ? 0 : common_name_font_size;
varietyNameSpace = (variety_name =="") ? 0 : variety_name_font_size;
botanicalNameSpace = (botanical_name =="") ? 0 : botanical_name_font_size;
totalNameSpace = commonNameSpace + varietyNameSpace + botanicalNameSpace;
commonNameYloc = (tag_height/totalNameSpace) * 1.0 * (botanicalNameSpace + varietyNameSpace + commonNameSpace/2);
varietyNameYloc = (tag_height/totalNameSpace) * 1.0 * (botanicalNameSpace + varietyNameSpace/2);
botanicalNameYloc = (tag_height/totalNameSpace) * 1.0 * botanicalNameSpace/2;

echo (commonNameSpace, varietyNameSpace, botanicalNameSpace, totalNameSpace, commonNameYloc, varietyNameYloc, botanicalNameYloc);

// Set the stick coordinates
s_off = 2;                    // stick offset (to make fillet)
s_top = stake_width/2 + 4.5 + s_off;            // half of stick top width
s_mid = stake_width/2 + 2.5 + s_off;            // half of stick middle width
s_bot = stake_width/2 + s_off;          // half of stick bottom width
s_len = stake_length - 4.25;  // stick length

tag_points = [ [-s_top,0], [-s_top,s_off*2+border_thickness], [s_top,s_off*2+border_thickness], [s_top,0], [s_mid,0], [s_bot,-4], [s_bot,-s_len], [0,-s_len-5], [-s_bot,-s_len], [-s_bot,-4], [-s_mid,0] ];
tag_paths = [ [0,1,2,3,4,5,6,7,8,9,10] ];


if(generate=="all"){
  base();
  border();
  label();
}
if(generate=="base"){base();}
if(generate=="border"){border();}
if(generate=="label"){label();}


module base(){
  color("black") difference(){
    union() {
      // Create the stick
      translate([0,-s_off,0]) linear_extrude(tag_thickness) offset(r=-s_off) polygon(tag_points,tag_paths,1);

      // Create the label area
      translate([-tag_width/2+round_radius,round_radius,0]) minkowski()
      {
        cube([tag_width-2*round_radius,tag_height-2*round_radius,tag_thickness/2]);
        cylinder(r=round_radius,h=tag_thickness/2);
      }
    }
    border(1);
    label();
  }
}

// Create the border around the label area
module border(plus=0){
  color("lightblue"){
    linear_extrude(height = tag_thickness+label_thickness) difference() {
      translate([-tag_width/2+round_radius-plus/2,round_radius-plus/2]) 
      minkowski(){
        square([tag_width-2*round_radius+plus,tag_height-2*round_radius+plus]);
        circle(r=round_radius);
      }

      translate([-tag_width/2+round_radius+(border_thickness/2),round_radius+(border_thickness/2)]) minkowski(){
        square([tag_width-2*round_radius-border_thickness,tag_height-2*round_radius-border_thickness]);
        circle(r=round_radius);
      }
    }
    if (reinforce == "yes") {border_reinforce();}
  }
}

// Create the reinforcing wall on the stick
module border_reinforce(){
  union() {
    intersection() { 
      translate([-1.25,-stake_length,0]) cube([2.5, stake_length,tag_thickness + label_thickness]);
      translate([0,-s_off,0]) linear_extrude(tag_thickness + label_thickness) offset(r=-s_off) polygon(tag_points,tag_paths,1);
    }
    translate([0,-reinforce_connector*.5,0]) linear_extrude(tag_thickness + label_thickness) rotate([0,0,-90]) circle (reinforce_connector, $fn=3);
  }
}

// Create the text
module label(){
  color("white"){
    label_normal();
    label_mirrored();
  }
}
module label_normal(){
  translate([0,0,tag_thickness-fudge])  linear_extrude(label_thickness+fudge)
  label_2d();
}

// Create the text
module label_mirrored(){
  translate([0,0,0])  linear_extrude(tag_thickness-fudge)
  mirror([1,0,0])
  label_2d();
}

module label_2d(){
    translate([0,commonNameYloc+common_name_shift_up]) text(common_name, size=common_name_font_size, halign="center", valign="center", font=selectedCommonNameFont, spacing=common_name_spacing);
    translate([0,varietyNameYloc+variety_name_shift_up]) text(variety_name, size=variety_name_font_size, halign="center", valign="center", font=selectedVarietyNameFont, spacing=variety_name_spacing);
    translate([0,botanicalNameYloc+botanical_name_shift_up]) text(botanical_name, size=botanical_name_font_size, halign="center", valign="center", font=selectedBotanicalNameFont, spacing=botanical_name_spacing);
}