extends Node2D

var tw
var setter

func _ready():
	#sprite = get_node("Sprite")
	
	tw = Tween.new()
	add_child(tw)
	
	tw.connect("tween_step", self, "on_step")
	tw.connect("tween_completed", self, "on_tween_finish")
	
	set_tween(1, 2, 3, 4, 5)
	
func start():
	pass

func set_key():
	pass

func set_tween(init_value, finish_value, duration, transition, easing):
	# Object object, String method, Variant initial_val, Variant final_val, 
	# float duration, TransitionType trans_type, EaseType ease_type, float delay=0 )
	tw.interpolate_method(
		self,
		"set",
		init_value, 
		finish_value, 
		duration,
		Tween.TRANS_LINEAR, 
		Tween.EASE_IN_OUT)
	
	tw.start()

#Object object, NodePath key, float elapsed, Object value 
func on_step(o, node_path_key, elapsed_t, value):
	prints(o, node_path_key, elapsed_t, value)
	
func on_tween_finish(o, node_key_path):
	set_tween(1, 2, 3, 4, 5)
	
func on_finish():
	#emit_signal finish
	pass