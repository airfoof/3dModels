/*  
**  Name:  IKEA Lack Filament Port_3d_model
**  Author:  Chris Benson  @TheExtruder
**  Created:  1/22/2017
*/

totalHeight = 56;
baseDiameter = 30;
baseChamferDiameter = 27.5;
baseHeight = 3;
plugOD = 6;
plugID = 4.5;

$fn = 100;
difference(){
    union(){
        cylinder(totalHeight, d=plugOD, false);
        cylinder(baseHeight, d1=baseChamferDiameter, d2=baseDiameter, false);
    }
    cylinder(totalHeight, d=plugID, false);
}
