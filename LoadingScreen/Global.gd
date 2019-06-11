
# cache
var global_cache = []
var operations_pool = []

var cross_words
var player_attributes = {coins_amount = 0, level = 0, finished_bonus_words = {}, release_prizes = {}}
var settings = {music_enabled = true, sound_enabled = true}
var shop_data
var levels_map_data
var game_attributes = {}

# cache logic
func get_loading_operations_pool():
	var resources_paths = [] # sprites
	var sounds_paths = [] # audio

	if RESOURCES_CACHING_ENABLED :
		var raw_resources_paths = load_resources_paths("Resources")
		resources_paths = get_correct_paths(raw_resources_paths, "Resources")
		var raw_sounds_paths = load_resources_paths("Sounds")
		sounds_paths = get_correct_paths(raw_sounds_paths, "Sounds")

		for i in range(resources_paths.size()):
			operations_pool.append({method = funcref(self, "load_resource"), args = [resources_paths[i]]})
		for i in range(sounds_paths.size()):
			operations_pool.append({method = funcref(self, "load_resource"), args = [sounds_paths[i]]})

	# order is important
	# первой операцией выполнится "load_cross_words"
	operations_pool.append({method = funcref(self, "_setup")})
	operations_pool.append({method = funcref(self, "load_settings")})
	operations_pool.append({method = funcref(self, "load_levels_map_data")})
	operations_pool.append({method = funcref(self, "load_shop_data")})
	operations_pool.append({method = funcref(self, "load_player_attributes")})
	operations_pool.append({method = funcref(self, "load_game_attributes")})
	operations_pool.append({method = funcref(self, "load_cross_words")})

	return operations_pool

func load_resource(args):
	var path = args[0]
	# print(path)
	global_cache.append(load(path))


func load_cross_words():
	var file = File.new()
	file.open("res://data.json", file.READ)
	var text = file.get_as_text()
	cross_words = parse_json(text)
	file.close()

func load_game_attributes():
	var file = File.new()
	file.open("res://GameAttributes.json", file.READ)
	var text = file.get_as_text()
	game_attributes = parse_json(text)
	file.close()

func load_shop_data():
	var file = File.new()
	file.open("res://UI/Shop/ShopData.json", file.READ)
	var text = file.get_as_text()
	shop_data = parse_json(text)
	file.close()

func load_levels_map_data():
	var file = File.new()
	file.open("res://Scenes/Map/LevelsData.json", file.READ)
	var text = file.get_as_text()
	levels_map_data = parse_json(text)
	file.close()

func load_player_attributes():
	var save_game = File.new()
	if not save_game.file_exists("user://save_game.save"):
		player_attributes.level = game_attributes.init_level
		player_attributes.coins_amount = game_attributes.init_coins_amount
		return

	save_game.open("user://save_game.save", File.READ)
	var text = save_game.get_as_text()
	var p = parse_json(text)
	player_attributes.level = p["level"]
	player_attributes.coins_amount = p["coins_amount"]
	player_attributes.finished_bonus_words = p["finished_bonus_words"]
	player_attributes.release_prizes = p["release_prizes"]
	save_game.close()

func load_settings():
	var settings_file = File.new()
	if settings_file.file_exists("user://settings.save"):
		settings_file.open("user://settings.save", File.READ)
		var text = settings_file.get_as_text()
		var p = parse_json(text)
		settings.music_enabled = p["music_enabled"]
		settings.sound_enabled = p["sound_enabled"]
		settings_file.close()

func load_resources_paths(path):
	var paths = []
	var file = File.new()
	path = "res://" + path + "/files.txt"
	if not file.file_exists(path):
        print("files not exist")
	file.open(path, file.READ)
	while not file.eof_reached():
        paths.append(file.get_line())
	file.close()

	return paths

# source :
# e:\Repository\CrossWords\Resources\beams.png
# e:\Repository\CrossWords\Resources\beams.png.import
# result :
# "res://Resources/beams.png"

func get_correct_paths(raw_paths, root_name):
	var result = []
	for i in range(raw_paths.size()):
		var path = raw_paths[i]
		var start_index = path.find(root_name)
		var finish_index = path.length() - 1
		var p = "res://" + path.substr(start_index, finish_index)
		if p.find(".import") == -1 :
			result.append(p.replace("\\", "/"))
	return result