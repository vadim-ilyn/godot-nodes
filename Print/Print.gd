extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var dictionary = {
		"type": "purchase",
		"result": "error",
		"product_id": "the product id requested"
	}
	print(str(dictionary))