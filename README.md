# OpenSCAD 

## librarys:

### include
include \<filename\> acts as if the contents of the included file were written in the including file
#### example:
include <..\lib\openscad_xels_lib\ball_bearings.scad>;<br>
--> bear_in_dil

<br>

### use
use \<filename\> imports modules and functions, but does not execute any commands other than those definitions.
#### example:
use <..\lib\openscad_xels_lib\ball_bearings.scad>;<br>
--> switch_complete(h)