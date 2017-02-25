/*  
**  Name:  Coin Container_3d_model
**  Author:  Chris Benson  @TheExtruder
**  Created:  2/24/2017
*/

numOfCoins = 10;

coinHeight = 3;
coinDiameter = 41;
capHeight = 5;

wallThickness = 1;

$fn = 100;

//coins
CreateCylinder(numOfCoins * coinHeight, coinDiameter, wallThickness);

//cap
translate([coinDiameter + wallThickness + 5,0,0])
    CreateCylinder(capHeight, coinDiameter + wallThickness * 2, wallThickness);

module CreateCylinder(height,innerDiameter,wallThinkness){
    union(){
        //bottom
        cylinder(wallThickness, d=innerDiameter + (wallThickness * 2), true);
        
        translate([0,0,wallThickness]){
            difference(){
                //outer wall
                cylinder(height, d=innerDiameter + (wallThickness * 2), true);
                //inner wall
                cylinder(height, d=innerDiameter, true);
            }
        }
    }
}