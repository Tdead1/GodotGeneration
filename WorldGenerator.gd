extends Node

class Map:
	var size =  Vector2(MAPSIZE, MAPSIZE);
	var tiles = [];
	func find(x,y):
		if(!(x < 0 || x >= MAPSIZE || y < 0 || y >= MAPSIZE)):
			return tiles[floor(y * MAPSIZE) + x];
		else:
			return null;

const MAPSIZE = 20;
export var worldseed = 1;

var Tile = preload("res://Tile.tscn");
var Dirt = preload("res://Textures/T_Dirt_64x64.png");
var Rock = preload("res://Textures/T_Rock_64x64.png");
var Water = preload("res://Textures/T_Water_64x64.png");
var Chest = preload("res://Textures/T_Chest_64x64.png");

var map : Map;
var items = [];
var neighbs = [];
var seeder;

func _ready():
	if(MAPSIZE > 0):	
		map = Map.new();
		seeder = RandomNumberGenerator.new();
		seeder.seed = worldseed;
		
		for i in range (MAPSIZE * MAPSIZE):
			var tile = Tile.instance();
			tile.pos = Vector2(i - floor(i / MAPSIZE) * MAPSIZE, floor(i / MAPSIZE));
			tile.type = seeder.randi_range(0, 2);
			tile.setuptile(self);
			get_node("Tiles").add_child(tile, true);
			map.tiles.push_back(tile);
			
		for i in range(8): 
			neighbs.push_back(map.find(0,0));
	else:
		print("Please define your mapsize correctly.");
		
	pass;

func placeitems():
	print("Attempted placing some items.");
	for x in MAPSIZE:
		for y in MAPSIZE:
			var tile = map.find(x,y);
			findneighbours(tile);
			var dirts = 0;
			for i in range(neighbs.size()):
				if(neighbs[i] != null):
					if(neighbs[i].type == 0):
						dirts += 1;
			if(dirts > 4 && tile.type == 0):
				if(seeder.randi_range(0,5) == 0):
					var occupied = false;
					for i in range(items.size()):
						if(items[i].pos == tile.pos):
							occupied = true;
					if(!occupied):
						var item = Tile.instance();
						item.pos = Vector2(x,y);
						item.type = 3;
						item.setuptile(self);
						get_node("Items").add_child(item, true);
						items.push_back(item);
	pass;

func smoothmap():
	print("Attempted smoothing.");
	for x in MAPSIZE:
		for y in MAPSIZE:
			var tile = map.find(x,y);
			findneighbours(tile);
			var counter = 0;
			var walls = 0;
			var dirts = 0;
			var waters = 0;
			for i in range(neighbs.size()):
				if(neighbs[i] != null):
					counter += 1;
					if(neighbs[i].type == 0):
						dirts += 1;
					if(neighbs[i].type == 1):
						walls += 1;
					if(neighbs[i].type == 2):
						waters += 1;
					
			if(float(dirts) / float(counter) > 0.6):
				tile.type = 0;
				tile.setuptile(self);
			elif(float(walls) / float(counter) > 0.6):
				tile.type = 1;
				tile.setuptile(self);
			elif(float(waters) / float(counter) > 0.6):
				tile.type = 2;
				tile.setuptile(self);
	pass;

func findneighbours(tile):
	var pos = tile.pos;
	neighbs[0] = map.find(pos.x - 1, pos.y - 1);
	neighbs[1] = map.find(pos.x, 	pos.y - 1);
	neighbs[2] = map.find(pos.x + 1, pos.y - 1);
	
	neighbs[3] = map.find(pos.x - 1, pos.y);
	neighbs[4] = map.find(pos.x + 1, pos.y);
	
	neighbs[5] = map.find(pos.x - 1, pos.y + 1);
	neighbs[6] = map.find(pos.x, 	pos.y + 1);
	neighbs[7] = map.find(pos.x + 1, pos.y + 1);
	
	return neighbs;