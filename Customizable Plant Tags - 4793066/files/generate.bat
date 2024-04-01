rem unix may be 'generate="base"'

set common_name="Beetroots"
set variety_name="Rote Bete"
set botanical_name="Буряки"

@REM openscad -D "generate=""all""" -o plant_all.stl PlantTag-V1.4.scad

openscad -D "generate=""label""" -D "common_name=""%common_name%""" -D "variety_name=""%variety_name%""" -D "botanical_name=""%botanical_name%""" -o plant_label_%common_name%.stl PlantTag-V1.4.scad
openscad -D "generate=""base""" -D "common_name=""%common_name%""" -D "variety_name=""%variety_name%""" -D "botanical_name=""%botanical_name%""" -o plant_base_%common_name%.stl PlantTag-V1.4.scad
openscad -D "generate=""border""" -D "common_name=""%common_name%""" -D "variety_name=""%variety_name%""" -D "botanical_name=""%botanical_name%""" -o plant_border_%common_name%.stl PlantTag-V1.4.scad


pause