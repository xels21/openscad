/*

|      _______
|     |   ___|
|     |  |
|     |  |
|     |  |
|   __|  |
|  |     |
|  |_____|
|
*/


inner_d1=6.5;
inner_d2=9.5;

inner_r1=inner_d1/2;
inner_r2=inner_d2/2;

outer_d1=14.5;
outer_d2=19.5;

outer_r1=outer_d1/2;
outer_r2=outer_d2/2;

h1=4;
h2=6;
h3=3;


rotate_extrude(angle=360, convexity=10, $fn=100)
polygon(points = [
    [inner_r1, 0],
    [inner_r1, h1],
    [inner_r2, h1],
    [inner_r2, h1+h2+h3],

    [outer_r2, h1+h2+h3],
    [outer_r2, h1+h2],
    [outer_r1, h1+h2],
    [outer_r1, 0],
]);
