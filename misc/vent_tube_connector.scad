use <adapter_plate.scad>;

// Adapter params
adap_d=22; adap_h=2; adap_spacing=2; adap_screw_dia=2.8; adap_screw_num=3;

length = 40;
width = 2;
diameter = 21;
diameter_change = 1;

protrusion_size = 2;
protrusion_inset = 1.5;
protrusion_distance = 5;
protrusion_spacing = 8;
protrusion_count = 3;

tube_precision = 80;
protrusion_precision = 30;

// Do not change beyond this point

function x_along_outer(dist) =  width + diameter_change * (dist/length);

module protrusion(dist) {
    start_dist = dist - protrusion_size;
    end_dist = dist + protrusion_size;
    difference() {
        translate([x_along_outer(dist) - protrusion_inset, dist])
           circle(r=protrusion_size, $fn=protrusion_precision);
        polygon(points=[[x_along_outer(start_dist), start_dist], [x_along_outer(end_dist), end_dist], [-100,end_dist], [-100,start_dist]], paths=[[0,1,2,3]]);
    }
}

// Vent Tube
module vent_tube() {
    adap_inner_r = min(diameter/2 - width, adap_d/2);
    rotate_extrude(angle=360, $fn=tube_precision) {
        translate([diameter/2 - width,0,0])
        union(){
            // Top Plate
            translate([-diameter/2+width + adap_inner_r,length]) square([calculate_outer_dia(adap_d, adap_spacing, adap_screw_dia) / 2 - adap_inner_r , adap_h]);
            // Protrusions
            for(i = [0:protrusion_count-1]) {
                protrusion(protrusion_distance + protrusion_spacing * i);
            }
            // Main Tube
            polygon(points=[[0,0],[0,length],[width,0],[width+diameter_change,length]], paths=[[0,1,3,2]]);
        }
    }
}

difference(){
    // Vent Tube
    vent_tube();
    // Drill
    translate([0,0,length-2.5]) adapter_drill(d=adap_d, h=adap_h+5, spacing=adap_spacing, screw_dia=adap_screw_dia, screw_num=adap_screw_num, no_center=1);
}
