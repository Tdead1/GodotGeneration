extends Node

func Find():
	var xtext = get_node("x").text;
	var ytext = get_node("y").text;
	if(xtext.is_valid_integer() && ytext.is_valid_integer()):
		if(xtext.to_int() < get_parent().MAPSIZE && ytext.to_int() < get_parent().MAPSIZE && xtext.to_int() >= 0 && ytext.to_int() >= 0):
			get_node("output").text = str(get_parent().map.find(xtext.to_int(), ytext.to_int()).pos);
			get_node("id").text = "Type: " + str(get_parent().map.find(xtext.to_int(), ytext.to_int()).type);
		else:
			get_node("output").text = "Input is too large or too small.";
	else:
		get_node("output").text = "Not a valid integer.";
	pass;


func Smooth():
	get_parent().get_node("Generator").smoothmap();
	pass;


func PlaceItems():
	get_parent().get_node("Generator").placeitems();
	pass;
