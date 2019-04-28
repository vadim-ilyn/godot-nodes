extends Node2D

var sprite

func _ready():
	var tw = Tween.new()
	add_child(tw)
	
	sprite = get_node("Sprite")
	
	tw.interpolate_property(
		sprite,
		"position",
		Vector2(0, 0), 
		Vector2(100, 100), 1,
		Tween.TRANS_LINEAR, 
		Tween.EASE_IN_OUT)
	
	tw.start()