extends Node2D

var paths = ["res://data/enemies/", "res://data/items/", "res://data/player/", "res://data/quests/"]
var files = ["res://data/enemies/data.json", "res://data/items/ekwipunek.json", "res://data/items/itemy.json", "res://data/player/data.json", "res://data/player/level.json", "res://data/player/quests.json", "res://data/quests/data.json"]
var crFiles = ["user://data/enemies/data.json", "user://data/items/ekwipunek.json", "user://data/items/itemy.json", "user://data/player/data.json", "user://data/player/level.json", "user://data/player/quests.json", "user://data/quests/data.json"]

func _ready():
	var i = 0
	for path in paths:
		if(!is_dir(path)):
			make_dr(path.split("/")[3])
	for file in files:
		i += 1
		if(!is_file(file)):
			create_file(crFiles[i], file)
	pass


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
	var file = File.new()
	var copyFile = File.new()
	var data = []
	copyFile.open(pathToCopy, File.READ)
	while !copyFile.eof_reached():
		var line = copyFile.get_line
		data.push_back(line)
	file.open(pathToCreate, File.WRITE)
	file.store_string(data)
	file.close()
