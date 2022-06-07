function screw_coords(d, r) = [cos(d)*r, sin(d)*r];
function calculate_outer_dia(inner_dia, spacing, screw_dia) = inner_dia + spacing*4 + screw_dia*2;
function calculate_inner_dia(outer_dia, spacing, screw_dia) = outer_dia - spacing*4 - screw_dia*2;

module adapter_plate(d=20, h=2, spacing=2, screw_dia=3,screw_num=3) {
    inner_dia = d;
    outer_dia = calculate_outer_dia(inner_dia, spacing, screw_dia);
    screw_angle = 360 / screw_num;
    screw_radius = inner_dia/2 + spacing + screw_dia/2;
    linear_extrude(h){
        difference() {
            circle(d=outer_dia, $fn=30);
            circle(d=inner_dia, $fn=30);
            if(screw_num > 0){
                for( i = [0 : screw_num-1] ){
                    translate(screw_coords(i*screw_angle, screw_radius)) circle(d=screw_dia, $fn=30);
                }
            }
        }
    }
}

module adapter_drill(d=20, h=20, spacing=2, screw_dia=3, screw_num=3, no_center=0) {
    inner_dia = d;
    outer_dia = calculate_outer_dia(inner_dia, spacing, screw_dia);
    screw_angle = 360 / screw_num;
    screw_radius = inner_dia/2 + spacing + screw_dia/2;
    linear_extrude(h) {
        if(no_center == 0){
            circle(d=inner_dia, $fn=30);
        }
        if(screw_num > 0){
            for( i = [0: screw_num-1] ){
                translate(screw_coords(i*screw_angle, screw_radius)) circle(d=screw_dia, $fn=30);
            }
        }
    }
}

module adapter_drill_od(d=20, h=20, spacing=2, screw_dia=3, screw_num=3, no_center=0) {
    inner_dia = calculate_inner_dia(d, spacing, screw_dia);
    outer_dia = d;
    screw_angle = 360 / screw_num;
    screw_radius = inner_dia/2 + spacing + screw_dia/2;
    linear_extrude(h) {
        if(no_center == 0){
            circle(d=inner_dia, $fn=30);
        }
        if(screw_num > 0){
            for( i = [0: screw_num-1] ){
                translate(screw_coords(i*screw_angle, screw_radius)) circle(d=screw_dia, $fn=30);
            }
        }
    }
}

d=9.5;
screw_num=2;
screw_dia=2;

//adapter_plate(d=d, screw_num=screw_num, screw_dia=screw_dia,spacing=3);
//adapter_drill(d=d, screw_num=screw_num, screw_dia=screw_dia);
//adapter_plate();
adapter_drill_od(d=d, spacing=.5, screw_dia=screw_dia, screw_num=screw_num);
//adapter_plate(d=d, spacing=2);

// upper: screw_num=4, screw_dia=2.8, d=20
// bottom: screw_num=4, screw_dia=2.8, d=20
// side: screw_num=2, d=6, screw_dia=1.8