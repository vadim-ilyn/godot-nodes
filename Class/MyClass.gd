extends Object

class_name MyClass, "res://Class/icon.png"

func _init():
	print("_init")
	
# calling only when script is attached to node
func _ready():
	print("_ready")
	print(self.get_class())
	