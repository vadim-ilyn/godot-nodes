extends Node2D

func _ready():
	#set_process_input(false)
	pass # Replace with function body.
	
func _input(event):
	get_tree().set_input_as_handled()
	#print(event.get_class())
	#print(event.as_text())
	pass
	
func _on_Button_mouse_entered():
	print("OnMouseEntered")
	pass

func _on_Button_button_up():
	print("OnMouseup")
	pass

func _on_Button_gui_input(event):
	print("on_Button_gui_input")
	pass