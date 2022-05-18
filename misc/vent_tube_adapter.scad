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

rotate_extrude(angle=360, $fn=tube_precision) {
    translate([diameter - width,0,0])
    union(){
        for(i = [0:protrusion_count-1]) {
            protrusion(protrusion_distance + protrusion_spacing * i);
        }
        polygon(points=[[0,0],[0,length],[width,0],[width+diameter_change,length]], paths=[[0,1,3,2]]);
    }
}