extends Node

signal finish

var tw
var setter
var tweens = []
var current_tween_index = 0
var repeat = false

func _ready():
	tw = Tween.new()
	add_child(tw)
	
	#tw.connect("tween_step", self, "_on_step")
	tw.connect("tween_completed", self, "_on_tween_finish")
	
func start():
	var init_value = tweens[current_tween_index].init_value
	var finish_value = tweens[current_tween_index].finish_value
	var duration = tweens[current_tween_index].duration
	var transition = tweens[current_tween_index].transition
	var easing = tweens[current_tween_index].easing
	
	tw.interpolate_method(
		self,
		"_set_value",
		init_value, 
		finish_value, 
		duration,
		transition, 
		easing)
	
	tw.start()
	
func bind_setter(setter_impl):
	setter = setter_impl

func set_tween(init_value, finish_value, duration, transition = Tween.TRANS_LINEAR, easing = Tween.EASE_IN_OUT):
	tweens.append({
		init_value = init_value,
		finish_value = finish_value,
		duration = duration,
		transition = transition,
		easing = easing
	})
	
func set_repeat(enabled):
	repeat = enabled

func _set_value(value):
	assert(setter)
	setter.call_func(value)

#Object object, NodePath key, float elapsed, Object value 
func _on_step(o, node_path_key, elapsed_t, value):
	#prints(o, node_path_key, elapsed_t, value)
	pass
	
func _on_tween_finish(o, node_key_path):
	current_tween_index += 1
	if current_tween_index == tweens.size():
		if repeat :
			current_tween_index = 0
			start()
		else :
			emit_signal("finish")
	else :
		start()