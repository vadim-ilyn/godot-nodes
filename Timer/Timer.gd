extends Node

var some = load("res://Timer/Some.gd")

func _ready():
	var some_object = some.new()

	var events_handle_timer = Timer.new()
	add_child(events_handle_timer)
	events_handle_timer.start(1)
	events_handle_timer.connect("timeout", some_object, "on_timer_update")
