# https://docs.godotengine.org/en/latest/classes/class_directory.html?highlight=folder#class-directory-method-list-dir-begin
class_name Dir

var path = null

func _init(path1):
    assert(path1.length() > 0)
    path = path1

# f : funcref
func for_each(f):
    _dir_contents(path, f)

func _dir_contents(path, f):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()

		var entity_name = dir.get_next()
		while (entity_name != ""):
			if dir.current_is_dir():
				if entity_name != "." and entity_name != ".." :
					_dir_contents(path + entity_name + "/", f)
			else:
				var p = path + entity_name
				if p.find(".import") == -1 :
					f.call_func(p)
			entity_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("An error occurred when trying to access the path.")