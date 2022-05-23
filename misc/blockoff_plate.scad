use <adapter_plate.scad>;

// Adapter params
d=20; h=2; spacing=2; screw_dia=3; screw_num=3;

union(){
    adapter_plate(d=d, h=h, spacing=spacing, screw_dia=screw_dia, screw_num=screw_num);
    linear_extrude(h) circle(d=d+.5);
}
