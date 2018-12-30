/*  
**  Name:  Raspberry Pi Zero OLED Case
**  Author:  Chris Benson  @TheExtruder
**  Created:  11/25/2018
**
*/
coverThickness = 2.4;
wallThickness = 1.50;
outerWidth = 76;
outerDepth = 36;
$fn = 100;

FrontCase(coverThickness);

translate([0,outerDepth+5,0]) RearCase(coverThickness);
translate([0,-outerDepth,0]) CaseConnector();
translate([0,-outerDepth,0]) PushButton(coverThickness, 4);
translate([0,-outerDepth-35,0]) OLEDSupport();

module CaseConnector(){
    linear_extrude(6){
        difference(){
            square([71, 31], true);
            CaseWalls();
            square([67, 27], true);
        }
    }
    //translate([0,-32.5/2,0]) PiZeroCutouts(wallThickness,3.2);
}

module PiZeroCutouts(thickness, cutoutHeight){
    linear_extrude(cutoutHeight){
        translate([((65/2)-(41.4/2)),0,1]) {
            translate([-3,0,0]) square([8.4, thickness], true);
            translate([9.8,0,0]) square([8.4, thickness], true);
        }
        translate([-72.5/2,18.4,0]) square([thickness, 13], true);
    }
    linear_extrude(cutoutHeight+.4)
        translate([((65/2)-(41.4/2)),0,1])
            translate([-31.4,0,0]) square([12, thickness], true);
}

module RearCase(coverThickness){
    translate([-(outerWidth/2),-(outerDepth/2),0]) RoundedFace(coverThickness);
    translate([-(65/2),-(30/2),0]) PiZeroStandoffs();
    difference(){
        translate([0,0,coverThickness-1]) CaseWalls();
        translate([0,-32.5/2, 5.8]) PiZeroCutouts(wallThickness, 3.2);
    }
    translate([-47,67,coverThickness - .4])
        scale([.35,.35])
            linear_extrude(height = 1)
                import(file = "TheExtruder_3d_model_text_base.dxf", layer = "Main");
}

module PiZeroStandoffs(){
    holeSize = 2;
    
    translate([3.5,3.5,1]){
        StandOff(holeSize);
        translate([58,0,0])
            StandOff(holeSize);
        translate([58,23,0])
            StandOff(holeSize);
        translate([0,23,0])
            StandOff(holeSize);
    }
}

module StandOff(innerDiameter){
    difference(){
        cylinder(d = 6, h = 3.4);
        cylinder(d = innerDiameter, h = 3.4);
    }
}

module CaseWalls(){
    translate([0, -32.5/2, 0]){
        linear_extrude(11){
            difference(){
                translate([-36+3, 3.25, 0]) circle(d=8);
                translate([-36+3+wallThickness, 3.25+wallThickness, 0]) square(8, true);
            }
            difference(){
                translate([36-3, 3.25, 0]) circle(d=8);
                translate([36-3-wallThickness, 3.25+wallThickness, 0]) square(8, true);
            }
            difference(){
                translate([-35+2, 29.25, 0]) circle(d=8);
                translate([-35+2+wallThickness, 29.25-wallThickness, 0]) square(8, true);
            }
            difference(){
                translate([35-2, 29.25, 0]) circle(d=8);
                translate([35-2-wallThickness, 29.25-wallThickness, 0]) square(8, true);
            }
            
            square([68, wallThickness], true);
            translate([0,32.5,0]) square([68, wallThickness], true);
            translate([-72.5/2,32.5/2,0]) square([wallThickness, 28], true);
            translate([72.5/2,32.5/2,0]) square([wallThickness, 28], true);
        }
    }
}

module RoundedFace(coverThickness){
    hull(){
        hull(){
            translate([5,5,0])
                intersection(){
                    cylinder(coverThickness, d=8);
                    translate([0,0,4])
                        sphere(5);
                }
            translate([5,outerDepth-5,0])
                intersection(){
                    cylinder(coverThickness, d=8);
                    translate([0,0,4])
                        sphere(5);
                }
        }
        
        hull(){
            translate([outerWidth-5,5,0])
                intersection(){
                    cylinder(coverThickness, d=8);
                    translate([0,0,4])
                        sphere(5);
                }
            translate([outerWidth-5,outerDepth-5,0])
                intersection(){
                    cylinder(coverThickness, d=8);
                    translate([0,0,4])
                        sphere(5);
                }
        }
    }
}

module PCBSupport(){
    linear_extrude(5.4){
        translate([-28,-14,0]) square([15, 3], true);
        translate([-28,14,0]) square([15, 3], true);
        translate([28,-14,0]) square([15, 3], true);
        translate([28.5,14,0]) square([15, 3], true);
    }
}

module OLEDCutout(thickness){
    union(){
        translate([0,1.7,0]){
            linear_extrude(thickness){
                square([26.8, 14.5], true);
            }
        }
        translate([0,0,1]){
            linear_extrude(thickness-1){
                square([30, 30], true);
            }
        }
    }
}

module FrontButtonCutout(includeButtonHole){
    difference(){
        union(){
            circle(d=10);
            polygon([[-5,0], [-2, -10], [2, -10], [5,0]]);
        }
        union(){
            circle(d=8);
            polygon([[-4,0], [-1, -10], [1, -10], [4,0]]);
        }
    }
    if(includeButtonHole) circle(d=4);
}

module FrontCase(thickness){
    union(){
        difference(){
            translate([-(outerWidth/2),-(outerDepth/2),0])
                RoundedFace(thickness);
            linear_extrude(thickness){
                //difference(){
                    //translate([71/2,-31/2,0]){
                        /*minkowski(){
                            square([71, 31], true);
                            translate([-71/2,31/2,0]){
                                circle(d=2);
                            }
                        }*/
                        
                    //}
                    translate([24, 0, 0]){
                        //circle(d=1.5);
                        FrontButtonCutout(false);
                    }    
                    translate([-24, 0, 0]){
                        FrontButtonCutout(true);
                    }
                //}
            }
            OLEDCutout(thickness);
        }
        translate([0, 0, thickness]){
            PCBSupport();
        }
        translate([0,0,thickness-1]) CaseWalls();
    }
}

module OLEDSupport(){
    difference(){
        linear_extrude(4){
            difference(){    
                square(28,true);
                translate([0,5.5,0])
                    square([12,17],true);
            }
        }
        translate([0,3,3])
            linear_extrude(1.5){
               square([28,12], true);
            }
    }
}

module PushButton(coverThickness, holeDiameter){
    union(){
        intersection(){
            cylinder(4, d=8);
            translate([0,0,4])
                sphere(5);
        }
        cylinder(coverThickness+4.5, d=holeDiameter);
    }
}