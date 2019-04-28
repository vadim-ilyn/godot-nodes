extends Node2D

var sprite

func _ready():
	var tw = Tween.new()
	add_child(tw)
	
	tw.connect("tween_step", self, "_on_step")
	tw.connect("tween_completed", self, "_on_tween_finish")
	
	sprite = get_node("Sprite")
	
	# Object object, NodePath property, Variant initial_val, Variant final_val, float duration, TransitionType trans_type, EaseType ease_type, float delay=0 
	tw.interpolate_property(
		sprite,
		"position",
		Vector2(0, 0), 
		Vector2(100, 100), 1,
		Tween.TRANS_LINEAR, 
		Tween.EASE_IN_OUT)
		
	tw.interpolate_property(
		sprite,
		"rotation",
		0,
		2,
		2,
		Tween.TRANS_LINEAR, 
		Tween.EASE_IN_OUT)
	
	tw.start()
	
#Object object, NodePath key, float elapsed, Object value 
func _on_step(o, node_path_key, elapsed_t, value):
	prints(o, node_path_key, elapsed_t, value)

#Object object, NodePath key
func _on_tween_finish(o, node_path_key):
	print("finish")
