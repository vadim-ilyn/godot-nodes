extends Node

signal finish

var operations = []
var total_operations_quantity = 0

var finished = false

func _ready():
	operations = Global.get_loading_operations_pool()
	total_operations_quantity = operations.size()
	
func _process(dt):
	Global.unused([dt])
	
	var operations_size = operations.size()
	if operations_size > 0 :
		var dict = operations[operations_size - 1]
		if dict.has("args"):
			var args = dict.args
			dict.method.call_func(args)
		else:
			dict.method.call_func()
		operations.remove(operations_size - 1)

		var progress_value = int(float(total_operations_quantity - operations.size()) / total_operations_quantity * 100)
		get_node("TextureProgress").set_value(progress_value)
	else :
		if not finished :
			finished = true
			emit_signal("finish")