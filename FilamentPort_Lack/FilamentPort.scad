/*  
**  Name:  Customizable Filament Port_3d_model
**  Author:  Chris Benson  @TheExtruder
**  Created:  1/22/2017
*/
/*[Global]*/
part = "both" ; // [first:Plug Only,second:Cap Only,both:Plug and Cap]

/*[Base]*/
//in millimeters
totalHeight = 56;
//in millimeters
baseDiameter = 30;
//in millimeters
baseChamferDiameter = 27.5;
//in millimeters
baseHeight = 3;

/*[Plug]*/
//in millimeters
plugOD = 6;
//in millimeters
plugID = 4.5;

/*[Cap]*/
//in millimeters
capDiameter = 12;
//in millimeters
capChamferDiameter = 10;
//in millimeters
capHeight = 3;

/*[Hidden]*/
$fn = 100;

print_part();

module print_part() {
	if (part == "first") {
        Port();
	} else if (part == "second") {
        Cap();
	} else if (part == "both") {
		PortAndCap();
	} else {
		PortAndCap();
	}
}

module PortAndCap(){
    Port();
    translate([max(baseDiameter, capDiameter) + 5,0,0])
        Cap();
}

module Port(){
    difference(){
        union(){
            cylinder(totalHeight, d=plugOD, false);
            cylinder(baseHeight, d1=baseChamferDiameter, d2=baseDiameter, false);
        }
        cylinder(totalHeight, d=plugID, false);
    }
}

module Cap(){
    difference(){
        cylinder(capHeight, d1=capDiameter, d2=capChamferDiameter, false);
        cylinder(capHeight, d=plugOD, false);
    }
}