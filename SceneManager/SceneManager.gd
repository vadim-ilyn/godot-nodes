#http://docs.godotengine.org/en/latest/getting_started/step_by_step/singletons_autoload.html#doc-singletons-autoload

extends Node

var instantiated_scenes = {}
var current_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	instantiated_scenes[current_scene.get_path()] = current_scene

func _set_enabled(node, state):
	node.set_process(state)
	node.set_process_input(state)
	node.set_physics_process(state)
	if node.get("visible") :
		node.set_visible(state)

func goto_scene(path):
	#current_scene.free()
	_set_enabled(current_scene, false)

	if instantiated_scenes.has("/root/" + path) :
		current_scene = instantiated_scenes.get("/root/" + path)
	else :
		var s = ResourceLoader.load("res://" + path + ".tscn")
		current_scene = s.instance()
		# Add it to the active scene, as child of root.
		get_tree().get_root().add_child(current_scene)
		instantiated_scenes[path] = get_tree().get_root().get_node(path)
		
	_set_enabled(current_scene, true)
    
func free_scene(path):
    assert(instantiated_scenes.has(path))


# func get_current_scene():
# 	return current_scene