use <adapter_plate.scad>;

d=20; h=2; spacing=3; screw_dia=2.8; screw_num=3;

chamber_h = 15;
chamber_thick = 2;

union(){
    adapter_plate(d, h, spacing, screw_dia, screw_num);
    translate([0,0, -chamber_h + h])
        difference() {
            cylinder(h=chamber_h, d=d, $fn=30);
            translate([0,0,-1]) cylinder(h=chamber_h+2, d=d-chamber_thick*2, $fn=30);
        }
    translate([0,0,-chamber_h]) linear_extrude(chamber_thick) circle(d=d);
    /*translate([0,0, -chamber_h])
        difference() {
            cylinder(h=chamber_h, r=calculate_outer_dia(d, spacing, screw_dia)/2, $fn=30);
            translate([0,0,-1]) cylinder(h=chamber_h+2, r=d/2, $fn=30);
        };
    linear_extrude(chamber_thick) circle(d=10);*/
}