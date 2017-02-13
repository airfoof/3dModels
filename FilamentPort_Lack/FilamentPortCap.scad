/*  
**  Name:  IKEA Lack Filament Port Cap_3d_model
**  Author:  Chris Benson  @TheExtruder
**  Created:  1/22/2017
*/

plugDiameter = 12;
plugChamferDiameter = 10;
plugHeight = 3;
plugOD = 6;

$fn = 100;
difference(){
    cylinder(plugHeight, d1=plugDiameter, d2=plugChamferDiameter, false);
    cylinder(plugHeight, d=plugOD, false);
}
