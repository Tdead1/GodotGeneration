# GodotGeneration
A super basic godot 2D Terrain tiles generator with smoothing and debugging options.

This consists of three major scripts: 
The first is a WorldGenerator which produces tiles based on a MAPSIZE constant in the _ready().
The second is a Tile script, which contains a initialization function for itself.
The third is a Control Panel script, which calls functions in the WorldGenerator script to smooth the terrain and add items. 

In the WorldGenerator script there are a couple of noteworthy things:
- I created my own map class and put a 1 dimensional array in there. Use the find function to access elements based on x and y location.
- The smoothing works by checking tiles around it, and setting the tiles to similar surrounding tiles.
- The item placement places items only on tiles that are guaranteed to stay dirt.

Feel free to use this as is or adapt it, no need to give me credit or whatever.
