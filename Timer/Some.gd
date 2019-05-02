extends Node

func _init():
	print("init")

func on_timer_update():
	print(OS.get_system_time_secs())