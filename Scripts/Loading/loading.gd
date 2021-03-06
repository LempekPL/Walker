extends Node2D

var paths = ["user://enemies/", "user://items/", "user://player/", "user://quests/"]
var files = ["res://data/enemies/data.json", "res://data/items/ekwipunek.json", "res://data/items/itemyPuste.json", "res://data/player/data.json", "res://data/player/level.json", "res://data/player/quests.json", "res://data/quests/data.json", "res://data/player/step.json", "res://data/player/level.json", "res://data/player/daily.json", "res://data/player/stuff.json"]
var copyFiles = ["user://enemies/data.json",     "user://items/ekwipunek.json",   "user://items/itemy.json",          "user://player/data.json",      "user://player/level.json",    "user://player/quests.json",      "user://quests/data.json",    "user://player/step.json",     "user://player/level.json", "user://player/daily.json", "user://player/stuff.json"]

func _ready():
	var time = OS.get_datetime()
	print(time)
	for path in paths:
		if(!is_dir(path)):
			make_dr(path.split("/")[2])
	for i in files.size():
		if(!is_file(copyFiles[i])):
			create_file(files[i], copyFiles[i])
	var file = File.new()
	file.open("user://player/stuff.json", File.READ)
	var data = JSON.parse(file.get_as_text()).result
	file.close()
	data['data'] = str(time['day'])
	var dir = Directory.new()
	dir.remove("user://player/stuff.json")
	file = File.new()
	file.open("user://player/stuff.json", File.WRITE)
	file.store_string(to_json(data))
	file.close()
	get_tree().change_scene("res://Tscn/Main/main.tscn")
	



func make_dr(dir_name):
	var dir = Directory.new()
	dir.open("user://")
	dir.make_dir(dir_name)
	pass

func is_dir(path):
	var dir = Directory.new()
	return dir.dir_exists(path)
	pass

func is_file(path):
	var directory = Directory.new();
	return directory.file_exists(path)
	pass

func create_file(pathToCreate, pathToCopy):
	var dir = Directory.new()
	dir.copy(pathToCreate, pathToCopy)
	pass
