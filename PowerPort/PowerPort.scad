// remix by Chris Benson @TheExtruder
// Created:  4/15/2017
// changed model so that a cap would live on both sides of a given material
// also removed other stuff that was not relevant to me
//
// ORIGINAL MODEL
// Customizable Wire Access Grommet v1.3
// by TheNewHobbyist 2014 (http://thenewhobbyist.com)
// http://www.thingiverse.com/thing:273159
//
// "Customizable Wire Access Grommet" is licensed under a 
// Creative Commons Attribution-NonCommercial 3.0 Unported License.
//

/* [Grommet Settings] */
//Select the diameter of the hole in table in mm
Grommet_Diameter = 35; // [20:90]
//Thickness of the material you are placing a hole in
Thickness = 18;// [5:500]
//Select the diameter if the access hole in mm
Hole_Diameter = 7; // [5:50]

/* [Hidden] */
$fn=120;

  //////////////////////////
 // Put it all together! //
//////////////////////////

translate([-Grommet_Diameter,0,0]) full_top();
translate([0,Grommet_Diameter,0]) full_top();
translate([Grommet_Diameter,0,0]) full_bottom();

module solid_top(){
	translate([0,0,1.5]) 
        cylinder(r1=(Grommet_Diameter/2)*1.2, r2=(Grommet_Diameter/2)*1.25,h=3, center=true);
	translate([0,0,5]) 
        cylinder(r=((Grommet_Diameter/2)/1.14)-.1, h=4, center=true);	
}

module full_top(){
	union(){
		difference(){
			solid_top();
			translate([0,0,5.25]) 
                cylinder(r=((Grommet_Diameter/2)/1.14)-3, h=5, center=true);	
			translate([Grommet_Diameter*.25,0,0]) 
                cylinder(r=Hole_Diameter/2, h=40, center=true);	
			translate([Grommet_Diameter*.6,0,0]) 
                cube([Grommet_Diameter*.75, Hole_Diameter, 40], center=true);
		}	
	}
}

module solid_bottom(){
	cylinder(r=(Grommet_Diameter/2), h=Thickness, center=false);	
}

module full_bottom(){
	union(){
		difference(){
			solid_bottom();
			cylinder(r=(Grommet_Diameter/2)/1.14, h=50, center=true);
		}
	}
}