
res = 128;
valve_inner_d = 7;
valve_max_l = 18;
connector_l = 3;
out_tol = -1;
out_outer_d_raw = 4.5;
out_outer_d = out_outer_d_raw - out_tol;
out_outer_r = out_outer_d / 2;

out_max_l = 10.5;

valve_tol = -0.7;
valve_outer_d_raw = 11;
valve_outer_d = valve_outer_d_raw - valve_tol;
valve_outer_r = valve_outer_d / 2;

max_l = valve_max_l + connector_l + out_max_l;
t1 = 3;
t2 = 2.2;

// all_2d();
all();

module all()
{
    rotate_extrude($fn = res) rotate([ 0, 0, 90 ]) all_2d();
}

module all_2d()
{
    difference()
    {
        all_outer_2d();
        all_inner_2d();
    }
}

module all_outer_2d()
{
    polygon(points = [
        [ 0, 0 ], [ 0, valve_outer_r + t1 ], [ valve_max_l, valve_outer_r + t1 ],
        [ valve_max_l + connector_l, out_outer_r + t2 ], [ max_l, out_outer_r + t2 ], [ max_l, 0 ]
    ]);
}

module all_inner_2d()
{
    valve_tube_2d();

    translate([ valve_max_l, 0, 0 ]) connector_2d();

    translate([ max_l, 0, 0 ]) rotate([ 0, 180, 0 ]) out_tube_2d();
}

module connector_2d()
{
    polygon(points = [ [ 0, 0 ], [ 0, valve_inner_d / 2 ], [ connector_l, out_outer_d / 2 ], [ connector_l, 0 ] ]);
}

module valve_tube_2d()
{
    inner_r = valve_inner_d / 2;
    connector_l = 7;
    connector_l_expand = 3;
    connector_d_raw = 12;
    connector_d = connector_d_raw - valve_tol;
    connector_r = connector_d / 2;
    polygon(points = [
        [ 0, 0 ],
        [ 0, valve_outer_r ],
        [ valve_max_l - connector_l, valve_outer_r ],
        [ valve_max_l - connector_l, connector_r ],
        [ valve_max_l - connector_l+connector_l_expand, connector_r ],
        [ valve_max_l, inner_r ],
        [ valve_max_l, 0 ],
    ]);
}

module out_tube_2d()
{
    tol = 0.3;
    connector_end_offset = 1.5;
    connector_l = 3.5;
    connector_d = 6;
    connector_r = connector_d / 2;
    polygon(points = [
        [ 0, 0 ],
        [ 0, out_outer_r ],
        [ out_max_l - connector_l - connector_end_offset, out_outer_r ],
        [ out_max_l - connector_l - connector_end_offset, connector_r ],
        [ out_max_l - connector_end_offset, out_outer_r ],
        [ out_max_l, out_outer_r ],
        [ out_max_l, 0 ],
    ]);
}