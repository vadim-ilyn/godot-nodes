extends Node2D

var timeline = load("res://TweensTimeline/Timeline.tscn")

func _ready():
	var tl = timeline.instance()
	add_child(tl)
	tl.bind_setter(funcref(self, "_set_object_position"))
	tl.set_tween(Vector2(0, 0), Vector2(200, 200), 2.0)
	tl.set_tween(Vector2(200, 200), Vector2(500, 200), 2.0)
	tl.set_tween(Vector2(500, 200), Vector2(500, 500), 2.0)
	tl.set_repeat(true)
	tl.start()
	tl.connect("finish", self, "_on_animation_finish")

func _set_object_position(position):
	get_node("Sprite").set_position(position)
	
func _on_animation_finish():
	print("finish timeline")