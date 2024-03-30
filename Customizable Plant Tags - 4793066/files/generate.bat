rem unix may be 'generate="base"'

set common_name=111
set variety_name=222
set botanical_name=333

start openscad -D "generate=""base""" -D "common_name=""111""" -D "variety_name=""%variety_name%""" -D "botanical_name=""%botanical_name%""" -o plant_base.stl PlantTag-V1.4.scad
start openscad -D "generate=""border""" -D "common_name=""111""" -D "variety_name=""%variety_name%""" -D "botanical_name=""%botanical_name%""" -o plant_border.stl PlantTag-V1.4.scad
start openscad -D "generate=""label""" -D "common_name=""111""" -D "variety_name=""%variety_name%""" -D "botanical_name=""%botanical_name%""" -o plant_label.stl PlantTag-V1.4.scad
