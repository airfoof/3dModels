/*  
**  Name:  Enclosure Exhaust Port_3d_model
**  Author:  Chris Benson  @TheExtruder
**  Created:  3/21/2017
**
**  Honeycomb example: http://forum.openscad.org/Beginner-Honeycomb-advice-needed-td4556.html
*/
part = "Filter Tray"; // [Fan Guard,Filter Slot,Filter Fan Guard,Filter Tray,Cutting Template,Large Cutting Template]

mountHoleSizeDiameter = 4.33;
mountHoleLocation = 35.75;
screwHeadDiameter = 6.1;

fanWidth = 80;
fanLength = 80;
fanDepth = 25;
fanHoleDiameter = 76;

plywoodDepth = 18;

portOffset = (fanDepth-plywoodDepth)/2;//distance betweenedge of guard and the plywood

//port is the whole part
portWidth = 100;
portLength = 100;
portCornerRadius = 4;
portThickness = 1.5;

templateWidth = 120;
templateLength = 120;
largeTemplateWidth = 140;
largeTemplateLength = 140;
templateTolerence = 1;//how much extra to cut
templateThickness = 2;

filterThickness = 4.75; // 3/16"
filterTabWidth = 5;
filterSlotTolerence = .2;//how much extra to add

/* [Hidden] */
$fn = 100;

PrintPart(part);

module PrintPart() {
	if (part == "Fan Guard") {
        FanGuard();
    }else if (part == "Filter Tray") {
        FilterTray();
    }else if (part == "Filter Fan Guard") {
        FilterFanGuard();
    }else if (part == "Filter Slot") {
        FilterSlot();
    }else if (part == "Cutting Template") {
        CuttingTemplate(templateWidth,templateLength);
    }else if (part == "Large Cutting Template") {
        CuttingTemplate(largeTemplateWidth,largeTemplateLength);
    }
}

module FilterTray(){
    difference(){
        linear_extrude(portThickness+filterThickness)
            RoundedSquare(portWidth-(portThickness*2)-filterSlotTolerence,portLength-portThickness,portCornerRadius);
        
        //cavity
        linear_extrude(portThickness+filterThickness)
            RoundedSquare(portWidth-(portThickness*4)-filterSlotTolerence,portLength-(portThickness*3),portCornerRadius);
    }
    intersection(){
        linear_extrude(portThickness)
            RoundedSquare(portWidth-(portThickness*4)-filterSlotTolerence,portLength-(portThickness*2),portCornerRadius);
        
        translate([-(portWidth-(portThickness*4))/2,-(portLength-(portThickness*2))/2,0])
            honeycomb(portWidth-(portThickness*4)-filterSlotTolerence, portLength-(portThickness*2), portThickness, 11, 1);
    }

    //pull tab
    translate([0,-(portWidth-(portThickness*2))/2,0])
        linear_extrude(portThickness) circle(d=25);
}

module FilterSlot(){
    difference(){
        union(){
            MainBase(portThickness,false);
            PortBorderInnerLip((portThickness*2)+filterThickness+filterSlotTolerence);
            FilterTabs(portOffset+(portThickness*3)+filterThickness+filterSlotTolerence);
        }
        
        //create the ledge
        translate([0,-(portThickness*2)*2,0])
            linear_extrude(portThickness)
                RoundedSquare(portWidth-(portThickness*4),portLength+(portThickness*4),portCornerRadius);
        
        //remove side
        translate([0,-(portThickness*4),portThickness])
            linear_extrude((portThickness*2)+filterThickness)
                RoundedSquare(portWidth-(portThickness*2),portLength-(portThickness*2),portCornerRadius);
    }
}

module FilterFanGuard(){
    difference(){
        union(){
            difference(){
                MainBase(portThickness,true);
                //fan hole
                linear_extrude(portThickness+1) circle(d=fanHoleDiameter);
            }
            FilterHoleGrate();   
            PortBorderInnerLip(portOffset+portThickness);
        }   
        //tabs
        FilterTabs(portOffset+portThickness);
    }
}

module FilterTabs(height){
    linear_extrude(height){
        translate([(portWidth/2)-portThickness,-(portWidth/2)+portCornerRadius,0])
            square([portThickness,filterTabWidth]);
        translate([-(portWidth/2),-(portWidth/2)+portCornerRadius,0]) 
            square([portThickness,filterTabWidth]);
        translate([0,(portWidth/2)-portThickness,0])
            square([filterTabWidth,portThickness]);
    }
}

module CuttingTemplate(width, length){
    linear_extrude(templateThickness)
    difference(){
        //outer border
        RoundedSquare(width,length,portCornerRadius);
        //inner border
        RoundedSquare(fanWidth+templateTolerence,fanLength+templateTolerence,portCornerRadius);
    }
}

module FanGuard(){
    difference(){
        MainBase(portThickness,true);
        //fan hole
        linear_extrude(portThickness+1) circle(d=fanHoleDiameter);
    }
    FanHoleGrate();   
    PortBorderInnerLip(portOffset+portThickness);
}

module MainBase(height, includeScrewHoles){
    difference(){
        //border
        linear_extrude(height){
            RoundedSquare(portWidth,portLength,portCornerRadius);
        }

        //screw holes
        if(includeScrewHoles){
            translate([mountHoleLocation,mountHoleLocation,0]) ScrewHole(height);
            translate([-mountHoleLocation,-mountHoleLocation,0]) ScrewHole(height);
            translate([mountHoleLocation,-mountHoleLocation,0]) ScrewHole(height);
            translate([-mountHoleLocation,mountHoleLocation,0]) ScrewHole(height);
        }
    }
}

module FilterHoleGrate(){
    intersection(){
        cylinder(d=fanHoleDiameter,h=5);
        //honeycomb(length, width, height, cell_size, wall_thickness); 
        translate([-fanHoleDiameter/2,-fanHoleDiameter/2,0]) honeycomb(fanHoleDiameter, fanHoleDiameter, portThickness, 11, 1); 
    }
}

module FanHoleGrate(){
    intersection(){
        cylinder(d=fanHoleDiameter,h=5);
        //honeycomb(length, width, height, cell_size, wall_thickness); 
        translate([-fanHoleDiameter/2,-fanHoleDiameter/2,0]) honeycomb(fanHoleDiameter, fanHoleDiameter, portThickness, 11, 1); 
    }
}

module PortBorderInnerLip(height){
    linear_extrude(height)
        difference(){
            //outer
            RoundedSquare(portWidth,portLength,portCornerRadius);
            //inner
            RoundedSquare(portWidth-(portThickness*2),portLength-(portThickness*2),portCornerRadius);
        }
}

module ScrewHole(height){
    cylinder(h=height,d1=screwHeadDiameter,d2=mountHoleSizeDiameter);
}

module RoundedSquare(length, width, cornerRadius){
    offset = cornerRadius*2;
    minkowski(){
        square([length-offset,width-offset], true);
        circle(r=cornerRadius);
    }
}

//Honeycomb example: http://forum.openscad.org/Beginner-Honeycomb-advice-needed-td4556.html
module hc_column(length, cell_size, wall_thickness) { 
    no_of_cells = floor(length / (cell_size + wall_thickness)) ; 

    for (i = [0 : no_of_cells]) { 
        translate([0,(i * (cell_size + wall_thickness)),0]) 
            circle($fn = 6, r = cell_size * (sqrt(3)/3)); 
    } 
} 

module honeycomb (length, width, height, cell_size, wall_thickness) { 
    no_of_rows = floor(1.2 * length / (cell_size + wall_thickness)) ; 

    tr_mod = cell_size + wall_thickness; 
    tr_x = sqrt(3)/2 * tr_mod; 
    tr_y = tr_mod / 2; 
    off_x = -1 * wall_thickness / 2; 
    off_y = wall_thickness / 2; 
    linear_extrude(height = height, center = false, convexity = 10, twist = 0, slices = 1)
    {
        difference(){ 
            square([length, width]); 
            for (i = [0 : no_of_rows]) { 
                translate([i * tr_x + off_x, (i % 2) * tr_y + off_y,0]) 
                    hc_column(width, cell_size, wall_thickness); 
            }
        }
    }
}