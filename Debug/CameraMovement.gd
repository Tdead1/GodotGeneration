extends Camera2D

func _ready():
	current = true;
	pass

func _process(delta):
	if(Input.is_key_pressed(KEY_W)):
		offset.y -= 500.0 * delta;
	if(Input.is_key_pressed(KEY_S)):
		offset.y += 500.0 * delta;
	if(Input.is_key_pressed(KEY_A)):
		offset.x -= 500.0 * delta;
	if(Input.is_key_pressed(KEY_D)):
		offset.x += 500.0 * delta;
	pass
