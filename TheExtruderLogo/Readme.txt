This my first 3D model!  It is the logo for my new endeavor revolving around my 3D printing.

Tools used to create these:
- Inkscape
  - https://inkscape.org
- OpenSCAD
  -  http://www.openscad.org
- Slic3r
  - http://slic3r.org
- Inkscape extension to export to OpenSCAD
  - https://github.com/brad/Inkscape-OpenSCAD-DXF-Export
  
All these tools are free and run on Linux and other platforms.

This article was very helpful in taking me thru an example workflow:  http://makezine.com/projects/3d-print-custom-stamps-using-inkscape-and-openscad/

My workflow:
1)  Create vector art in Inkscape
2)  Copy all objects to a new, single layer .svg file (if you work with multiple layers)
3)  Ungroup all objects
4)  Convert all objects to paths
5)  Export as .dxf file using the OpenSCAD DXF Export extension
6)  Using OpenSCAD, create a new OpenSCAD file
7)  Add code to import the .dxf file and add or manipulate anything else desired
8)  Press F6 to compile the code and review the results
9)  Export to an .stl file
10) Open Slic3r and add the .stl file
11) Preview the model and adjust your Slic3r settings
12) You're done!
