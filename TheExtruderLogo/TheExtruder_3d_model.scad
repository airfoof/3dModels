
union(){
    linear_extrude(height = 3)
    translate( [2.5,0,0] )
    import(file = "TheExtruder_3d_model_base.dxf", layer="Main");
    
    cube( size = [105,100,2]);
}
