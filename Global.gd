extends Node

var test = load("res://icon.png") 

func _ready():
	var sprite = Sprite.new()
	sprite.set_texture(test)
	# get_tree().get_root().add_child(sprite)
	add_child(sprite)
	sprite.set_position(Vector2(300, 300))