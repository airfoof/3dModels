/*  
**  Name:  TheExtruder_3d_model
**  Author:  Chris Benson  @TheExtruder
**  Created:  12/27/2016
*/

//union both the dxf file and the new cube being made
union(){
    //create a box
    color("Black")
        cube( size = [108,82,2]);
    
    color("Red")
        //extrude the dxf file to 3 mm height
        linear_extrude(height = 3)
            //center the dxf file to the cube.  I wish I understood why the import places in a weird spot
            translate( [5,21,0] )
                import(file = "TheExtruder_3d_model_base.dxf", layer = "Main");
    
}
