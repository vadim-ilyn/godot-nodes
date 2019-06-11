extends Node2D

var value = 0

func _ready():
	#set_value(15)
	pass
	
func set_value(value):
	assert(value >= 0 and value <= 100)
	var angle = int(360 * (value / 100.0))
	
	get_node("Left/CircleBack").set_visible(angle < 360)
	get_node("Right/CircleBack").set_visible(angle < 180)
	
	get_node("Left/CircleFront").set_visible(angle > 180)
	get_node("Right/CircleFront").set_visible(angle > 0)

	if angle == 0 :
		get_node("Right/CircleBack").set_rotation(deg2rad(180))
	elif angle <= 180 :
		get_node("Right/CircleBack").set_rotation(deg2rad(180 + angle))
		get_node("Right/CircleFront").set_rotation(deg2rad(angle))
	else :
		get_node("Right/CircleFront").set_rotation(deg2rad(180))
		get_node("Left/CircleBack").set_rotation(deg2rad(180 - (360 - angle)))
		get_node("Left/CircleFront").set_rotation(deg2rad(angle))

func get_value():
	return value