
// Module names are of the form poly_<inkscape-path-id>().  As a result,
// you can associate a polygon in this OpenSCAD program with the corresponding
// SVG element in the Inkscape document by looking for the XML element with
// the attribute id="inkscape-path-id".

// fudge value is used to ensure that subtracted solids are a tad taller
// in the z dimension than the polygon being subtracted from.  This helps
// keep the resulting .stl file manifold.
fudge = 0.1;

module poly_path2(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[1.813375,-38.390500],[1.959031,-37.847828],[1.966875,-37.293625],[1.928375,-35.987500],[1.166093,-35.870010],[0.544621,-35.611672],[0.050456,-35.225998],[-0.329906,-34.726500],[-0.803230,-33.440078],[-0.983375,-31.860500],[-0.896219,-28.254250],[-0.844965,-26.443766],[-0.932625,-24.772500],[2.176250,-24.777750],[5.704375,-24.772500],[8.560156,-24.644734],[11.256375,-24.771875],[12.361777,-25.057100],[13.207844,-25.557328],[13.721426,-26.322986],[13.829375,-27.404500],[15.217375,-27.417250],[16.464375,-27.290500],[16.464375,-18.020500],[15.217375,-17.892875],[13.829375,-17.905500],[13.796545,-18.614137],[13.615859,-19.201906],[13.304650,-19.679098],[12.880250,-20.056000],[11.761203,-20.550094],[10.397375,-20.766500],[7.655203,-20.838500],[4.675000,-20.774000],[1.723484,-20.705750],[-0.932625,-20.766500],[-0.932625,0.405500],[3.718375,0.589375],[8.567375,0.634500],[8.697875,1.486875],[8.567375,2.350500],[6.323750,2.341375],[5.339047,2.472141],[4.955662,2.646619],[4.673375,2.922500],[5.177783,3.959068],[5.810266,4.883547],[7.332000,6.510375],[8.983672,8.031266],[10.510375,9.674500],[13.944375,6.813500],[15.801125,5.241000],[16.580531,4.305313],[16.783285,3.836367],[16.804375,3.380500],[16.637797,2.991588],[16.326750,2.722453],[15.377375,2.452625],[12.912375,2.350500],[12.912375,0.634500],[27.101375,0.977500],[27.225125,1.711250],[27.215375,2.581500],[24.902027,3.228287],[22.875344,4.162172],[21.069113,5.316814],[19.417125,6.625875],[16.311031,9.441891],[14.724504,10.816166],[13.027375,12.079500],[18.519375,17.915500],[20.444109,19.962266],[22.478250,21.894375],[23.643662,22.705314],[24.965203,23.353047],[26.485799,23.792725],[28.248375,23.979500],[28.286625,24.749625],[28.248375,25.694500],[18.908625,25.495000],[9.252375,25.352500],[9.114375,24.495375],[9.252375,23.634500],[12.134500,23.559375],[13.323047,23.311766],[13.722982,23.030572],[13.943375,22.604500],[13.958467,22.116094],[13.803297,21.629000],[13.134000,20.682000],[11.422375,19.059500],[8.564375,15.968500],[6.902250,17.100625],[5.017375,18.713500],[3.047250,20.046750],[2.137234,20.827094],[1.838842,21.248074],[1.697375,21.690500],[1.837547,22.492281],[2.406250,23.108250],[3.335516,23.473344],[4.557375,23.522500],[4.665375,26.702797],[4.504125,30.219375],[4.369500,33.763516],[4.557375,37.026500],[4.826750,37.785125],[5.017375,38.511500],[0.208375,38.511500],[0.085750,37.950375],[0.208375,37.367500],[-3.784875,33.349000],[-7.917625,29.471500],[-8.018500,32.942750],[-8.031625,36.910500],[-7.887859,37.281797],[-7.637500,37.546125],[-7.412453,37.835391],[-7.344625,38.281500],[-9.704875,38.296750],[-11.922625,38.169500],[-11.960187,37.731266],[-11.832375,37.458125],[-11.464625,37.023500],[-11.464625,25.005500],[-19.911250,24.705875],[-24.067859,24.548891],[-28.172625,24.204500],[-28.163203,23.699094],[-27.884250,23.463500],[-27.549234,23.283406],[-27.371625,22.944500],[-27.370500,14.794000],[-27.485625,7.264500],[-27.352125,4.505875],[-27.317156,3.133641],[-27.485625,1.887500],[-27.671391,1.533125],[-27.926250,1.280750],[-28.161047,1.016750],[-28.286625,0.627500],[-27.765406,0.288531],[-27.056875,0.235500],[-25.654625,0.398500],[-17.644625,0.512500],[-11.043875,0.674375],[-7.920125,0.575359],[-5.170625,0.283500],[-5.042000,-10.115500],[-5.056625,-20.658500],[-7.798156,-20.715250],[-11.009375,-20.901000],[-14.219469,-21.023000],[-16.957625,-20.888500],[-17.946937,-20.605766],[-18.653875,-20.075625],[-19.113687,-19.293672],[-19.361625,-18.255500],[-20.689875,-18.243250],[-21.878625,-18.370500],[-21.858375,-23.099125],[-21.764625,-27.753500],[-19.246625,-27.753500],[-19.134072,-26.949135],[-18.827187,-26.299141],[-18.345693,-25.788107],[-17.709312,-25.400625],[-16.050781,-24.934672],[-14.009375,-24.778000],[-9.409062,-24.899375],[-7.165719,-24.930859],[-5.170625,-24.778500],[-5.079250,-28.235547],[-4.966125,-31.935125],[-5.154766,-33.575834],[-5.642000,-34.917141],[-6.029260,-35.438014],[-6.529172,-35.839033],[-7.154404,-36.105196],[-7.917625,-36.221500],[-7.936250,-37.499625],[-7.900328,-38.093078],[-7.688625,-38.511500],[-2.967250,-38.417250],[1.813375,-38.390500]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-22.561625,4.408500],[-22.690750,7.141125],[-22.676625,10.015500],[-17.260875,10.208125],[-11.804625,10.359500],[-11.804625,14.250500],[-17.316750,14.203500],[-22.676625,14.021500],[-22.676625,20.314500],[-13.483375,20.572125],[-9.022500,20.584078],[-5.167625,20.428500],[-5.066375,12.350750],[-5.167625,4.865500],[-9.575609,4.644891],[-13.865750,4.572875],[-22.561625,4.408500]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-0.819625,6.583500],[-0.904125,6.505875],[-1.048625,6.583500],[-0.945750,12.810250],[-0.933625,18.828500],[0.765344,17.677750],[2.469375,16.310250],[5.929375,13.562500],[4.346234,11.716031],[2.658000,9.972500],[-0.819625,6.583500]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-0.475625,31.531500],[0.339500,32.455750],[0.729391,32.806406],[1.128375,32.904500],[1.128375,26.265500],[-5.851625,26.265500],[-3.250250,28.986625],[-0.475625,31.531500]]);
    }
  }
}

poly_path2(5);