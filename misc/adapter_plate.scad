function screw_coords(d, r) = [cos(d)*r, sin(d)*r];

module adapter_plate(d=20, h=2, spacing=2, screw_dia=3,screw_num=3) {
    inner_dia = d;
    outer_dia = inner_dia + spacing*4 + screw_dia*2;
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

module adapter_drill(d=20, h=20, spacing=2, screw_dia=3, screw_num=3) {
    inner_dia = d;
    outer_dia = inner_dia + spacing*4 + screw_dia*2;
    screw_angle = 360 / screw_num;
    screw_radius = inner_dia/2 + spacing + screw_dia/2;
    linear_extrude(h) {
        circle(d=inner_dia, $fn=30);
        if(screw_num > 0){
            for( i = [0: screw_num-1] ){
                translate(screw_coords(i*screw_angle, screw_radius)) circle(d=screw_dia, $fn=30);
            }
        }
    }
}

d=6;
screw_num=2;
screw_dia=1.8;

//adapter_plate(d=d, screw_num=screw_num, screw_dia=screw_dia);
adapter_drill(d=d, screw_num=screw_num, screw_dia=screw_dia);

// upper: screw_num=4, screw_dia=2.8, d=20
// bottom: screw_num=4, screw_dia=2.8, d=20
// side: screw_num=2, d=6, screw_dia=1.8