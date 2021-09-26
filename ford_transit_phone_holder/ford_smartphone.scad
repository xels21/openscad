path_to_dxf = "./ford_smartphone.dxf";
height=62;

linear_extrude(height = height) {
    import(path_to_dxf );
}