/*

 __              __
| |             | |
| |             | |
| |             | |
| |_____________| |
|     ______      |
|    |______|     |
|_________________|

*/

// joachim_v1();

// translate(v = [ 60, 0, 0 ])
joachim_v2();

module joachim_v1()
{
    x_sum = 40;
    x_wall = 5;
    x1 = x_wall;
    x2 = x_sum - x_wall;
    y1 = 15;
    y2 = 15;
    y_sum = y1 + y2;

    // tol = 0.3;
    tol = 0;

    hole_x = 20 + tol;
    hole_y = 5 + tol;

    extrude = 90;

    joachim(x1 = x1, x2 = x2, y1 = y1, y2 = y2, hole_x = hole_x, hole_y = hole_y, extrude = extrude);
}

module joachim_v2()
{
    x_sum = 40;
    x_wall = 5;
    x1 = x_wall;
    x2 = x_sum - x_wall;
    y1 = 15;
    y2 = 15;
    y_sum = y1 + y2;

    // tol = 0.3;
    tol = 0;

    hole_x = 30 + tol;
    hole_y = 4.5 + tol;

    extrude = 30;

    joachim(x1 = x1, x2 = x2, y1 = y1, y2 = y2, hole_x = hole_x, hole_y = hole_y, extrude = extrude);
}

module joachim(x1 = x1, x2 = x2, y1 = y1, y2 = y2, hole_x = hole_x, hole_y = hole_y, extrude = extrude)
{
    x_sum = x1 + x2;
    y_sum = y1 + y2;
    linear_extrude(height = extrude) difference()
    {
        body_2d(x1 = x1, x2 = x2, y1 = y1, y2 = y2);
        // HOLE
        translate(v = [ .5 * (x_sum - hole_x), .5 * (y1 - hole_y) ]) square(size = [ hole_x, hole_y ]);
    }
}

module body_2d(x1, x2, y1, y2)
{
    x_sum = x1 + x2;
    y_sum = y1 + y2;
    polygon(points =
                [
                    [ 0, 0 ],
                    [ 0, y_sum ],
                    [ x1, y_sum ],
                    [ x1, y1 ],
                    [ x2, y1 ],
                    [ x2, y_sum ],
                    [ x_sum, y_sum ],
                    [ x_sum, 0 ],
                ],
            paths = paths, convexity = convexity);
}