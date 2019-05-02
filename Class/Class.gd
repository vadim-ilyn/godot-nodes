extends Node

var my_class = load("res://Class/MyClass.gd")

func _ready():
	var mc = my_class.new()
	print(mc.get_signal_list())