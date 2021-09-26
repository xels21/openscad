joint_d=7;
joint_d_smaller=5;
joint_r=joint_d/2;
joint_r_smaller=joint_d_smaller/2;
//joint_smaller_inner_r=1;

filter_d=8.6;
//old -> filter_d_smaller=7.8;
filter_d_smaller=6.4;
filter_r=filter_d/2;
filter_r_smaller=filter_d_smaller/2;
//joint_filter_inner_r=0.25;
width = 1.2;

joint_h=15;
filter_h=15;

sum_h=joint_h+filter_h;

rotate_extrude($fn=100) 
polygon( points=[[joint_r,0],
    [joint_r_smaller,joint_h],

    [filter_r_smaller,joint_h],
    [filter_r,sum_h],

    [filter_r+width,sum_h],
    //[filter_d+width,joint_h],
    //[joint_d+width,joint_h],
    [joint_r+width,0]
] );


print_stabilizer_r=0; //set 0 for null
 scale([1,1,0.3]) difference(){
    linear_extrude(height=1) circle($fn = 100, r = joint_r+width+print_stabilizer_r);
    linear_extrude(height=1) circle($fn = 100, r = joint_r);
}