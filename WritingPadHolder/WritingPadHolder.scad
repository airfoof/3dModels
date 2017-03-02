/*  
**  Name:  Writing Pad Holder_3d_model
**  Author:  Chris Benson  @TheExtruder
**  Created:  2/24/2017
*/

part = "Base" ; // [Base,Pen Cup,Top Pad Holder,Bottom Pad Holder,All]

/*[Base Dimensions]*/
baseWidth = 127;
baseHeight = 203.5;
baseDepth = 2;

/*[Pad Holders]*/
padHolderThickness = 1;
topPadHolderHeight = 6;
bottomPadHolderHeight = 7;

/*[Pen Cup]*/
penCupInnerDiameter = 12;
penCupOuterDiameter = 14;
penCupHeight = 60;
penCupAttachmentThickness = 1;
penCupBaseAttachmentLength = 20;
penCupBaseOverlap = 10;

/*[Sticker Slots]*/
stickerSlotWidth = 65;
stickerSlotHeight = 27;
stickerSlotDepth = .6;

/*[Buffers]*/
topBuffer = 17; //distance from the top to the start of the top of the pad holder
bottomBuffer = 5; //distance from the bottom to thetop of the lower pad holder
sideBuffer = 5; //distance to leave extra beyond the pad dimensions
basePadHolderBuffer = 2; //distance between the base and the pad holders

$fn = 100;

print_part();

module print_part() {
	if (part == "Base") {
        Base();
	} else if (part == "Pen Cup") {
        PenCup();
	} else if (part == "Top Pad Holder") {
		TopPadHolder();
    } else if (part == "Bottom Pad Holder") {
		BottomPadHolder();
    } else if (part == "All") {
		Base();
        
        translate([-penCupOuterDiameter, baseWidth+sideBuffer+penCupOuterDiameter+5, 0])
            PenCup();
        
        rotate([0,0,90])
            translate([0, 5, 0])
                TopPadHolder();
        
        rotate([0,0,90])
            translate([0, bottomPadHolderHeight+10, 0])
                BottomPadHolder();
    }
}

//base
module Base(){
    difference(){
        cube([baseWidth+sideBuffer, baseHeight, baseDepth], false);
        color("red")
        //    translate([(baseWidth + sideBuffer)/2,baseHeight/2,baseDepth/(baseDepth*2)])
        //        linear_extrude(height = baseDepth)
        //            text("Back", valign="bottom", halign="center");
        //logo
        translate([-3,200,1.25])
            scale([.5,.5])
               linear_extrude(height = 1)
                    import(file = "TheExtruder_3d_model_text_base.dxf", layer = "Main");//, origin=[0,-350]
        
        translate([0,baseHeight-topBuffer,0])
            cube([padHolderThickness, topPadHolderHeight, baseDepth], false);
        
        translate([baseWidth+sideBuffer-padHolderThickness,baseHeight-topBuffer,0])
            cube([padHolderThickness, topPadHolderHeight, baseDepth], false);
    
        cube([padHolderThickness, bottomPadHolderHeight, baseDepth], false);
        translate([baseWidth+sideBuffer-padHolderThickness,0,0])
            cube([padHolderThickness, bottomPadHolderHeight, baseDepth], false);
    
        translate([(baseWidth+sideBuffer)/2,stickerSlotHeight*1.5,baseDepth-(stickerSlotDepth/2)])
            cube([stickerSlotWidth, stickerSlotHeight, stickerSlotDepth], true);
        
        translate([(baseWidth+sideBuffer)/2,stickerSlotHeight*6,baseDepth-(stickerSlotDepth/2)])
            cube([stickerSlotWidth, stickerSlotHeight, stickerSlotDepth], true);

        translate([baseWidth+sideBuffer-(penCupBaseOverlap/2),penCupHeight,baseDepth-(penCupAttachmentThickness/2)])
            cube([penCupBaseOverlap, penCupHeight, penCupAttachmentThickness], true);
    }
}


//pen cup
module PenCup(){
    union(){
        rotate([0,0,90]) //rotate so that the All option doesn't collide
            translate([0,(penCupInnerDiameter/2),0])
                cube([penCupBaseAttachmentLength,penCupAttachmentThickness,penCupHeight]);
        cylinder(2, d = penCupOuterDiameter, true);
        difference(){
            cylinder(penCupHeight, d = penCupOuterDiameter, true);
            cylinder(penCupHeight, d = penCupInnerDiameter, true);
        }
        
        translate([-(penCupOuterDiameter/2),(penCupInnerDiameter/2),0])
        cube([penCupOuterDiameter/2,penCupAttachmentThickness,penCupHeight]);
    }
}

//Bottom Pad Holder
module BottomPadHolder(){
    union(){
        cube([baseWidth+sideBuffer, padHolderThickness, baseDepth+basePadHolderBuffer], false);
        cube([baseWidth+sideBuffer, bottomPadHolderHeight+padHolderThickness, padHolderThickness], false);
        cube([padHolderThickness, bottomPadHolderHeight+padHolderThickness, baseDepth+basePadHolderBuffer], false);
        
        translate([baseWidth + sideBuffer - padHolderThickness,0,0])
            cube([padHolderThickness, bottomPadHolderHeight+padHolderThickness, baseDepth+basePadHolderBuffer], false);
    }
}

//Top Pad Holder
module TopPadHolder(){
    union(){
        cube([baseWidth+sideBuffer, topPadHolderHeight, padHolderThickness], false);
        
        cube([padHolderThickness, topPadHolderHeight, baseDepth+basePadHolderBuffer], false);
        translate([baseWidth + sideBuffer - padHolderThickness,0,0])
            cube([padHolderThickness, topPadHolderHeight, baseDepth+basePadHolderBuffer], false);
    }
}

