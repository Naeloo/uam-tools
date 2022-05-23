/////////////////////////////////////////////////////////
// Original Version by Paul Tibble - 18/7/19           //
// https://www.thingiverse.com/Paul_Tibble/about       //
// Modified by Leonhard Hauptfeld for Airway Modelling //
// https://github.com/Naeloo/uam-tools                 //
/////////////////////////////////////////////////////////

use <adapter_plate.scad>;

// Adapter params
adap_d=10; adap_h=2; adap_spacing=2; adap_screw_dia=3; adap_screw_num=3;

$fn = 100*1;

// Outer Diameter (bottom)
outer_diameter_1 = 8;
// Wall Thickness (bottom)
wall_thickness_1 = 2;
// Rib Thickness (bottom), set to Zero to remove
barb_size_1 = 0.5;
// Length (bottom)
length_1 = 15;
// Outer Diameter (top), should be smaller than or equal to Outer Diameter (bottom)
outer_diameter_2 = adap_d;
// Wall Thickness (top)
wall_thickness_2 = 2;
// Rib Thickness (top), set to Zero to remove
barb_size_2 = 0.5;
// Length (top)
length_2 = 15;
// Middle Diameter
mid_diameter = calculate_outer_dia(adap_d, adap_spacing, adap_screw_dia);
// Middle Length
mid_length = adap_h;

//do not change these (i changed these)
inner_diameter_1 = outer_diameter_1 - (wall_thickness_1*2);

module create_profile() {
    ////////
    // Middle
    ///////
    polygon(points=[[inner_diameter_1/2,length_1],[mid_diameter/2,length_1],[mid_diameter/2,length_1+mid_length],[outer_diameter_2/2,length_1+mid_length]]);
    //////
    //length 1
    /////
    translate([inner_diameter_1/2,0,0])square([wall_thickness_1,length_1]);
    //barb 1
    translate([outer_diameter_1/2,0,0])polygon(points=[[0,0],[0,(length_1/5)],[barb_size_1,(length_1/5)]]);
    //barb 2
    translate([outer_diameter_1/2,length_1*0.25,0])polygon(points=[[0,0],[0,(length_1/5)],[barb_size_1,(length_1/5)]]);
    //barb 3
    translate([outer_diameter_1/2,length_1*0.5,0])polygon(points=[[0,0],[0,(length_1/5)],[barb_size_1,(length_1/5)]]);
}

difference(){
    rotate_extrude(angle = 360, convexity = 10) create_profile();
    // Create a drill with some margin to prevent diff fighting
    drill_h = adap_h+1;
    translate([0,0, length_1 - (drill_h - adap_h) / 2])
        adapter_drill(d=adap_d, h=drill_h, spacing=adap_spacing, screw_dia=adap_screw_dia, screw_num=adap_screw_num, no_center=1);
}