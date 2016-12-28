/*  
**  Name:  TheExtruder_3d_model_thin_border
**  Author:  Chris Benson  @TheExtruder
**  Created:  12/27/2016
*/

//union both the dxf file and the new cube being made
union(){    
    color("Red")
        //extrude the dxf file to 3 mm height
        linear_extrude(height = 3)
            //center the dxf file to the cube.  I wish I understood why the import places in a weird spot
            translate( [-87,225,0] )
                import(file = "TheExtruder_3d_model_text_base.dxf", layer = "Main");
    color("Black")
        //extrude the dxf file to 2 mm height
        linear_extrude(height = 2)
            //center the dxf file to the cube.  I wish I understood why the import places in a weird spot
            translate( [-2.5,4,0] )
                import(file = "TheExtruder_3d_model_thin_border_base.dxf", layer = "Border");
    
}
