extends Sprite
var type : int = 0;
var pos  : Vector2 = Vector2(0,0);

func setuptile(generator):
	position = Vector2(pos.x * 64, pos.y * 64);
	if(type == 0):
		texture = generator.Dirt;
	if(type == 1):
		texture = generator.Rock;
	if(type == 2):
		texture = generator.Water;
	if(type == 3):
		texture = generator.Chest;
	pass;