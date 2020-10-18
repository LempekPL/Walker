extends Node2D

var paths = ["user://enemies/", "user://items/", "user://player/", "user://quests/"]
var files = ["res://data/enemies/data.json", "res://data/items/ekwipunek.json", "res://data/items/itemy.json", "res://data/player/data.json", "res://data/player/level.json", "res://data/player/quests.json", "res://data/quests/data.json"]
var copyFiles = ["user://enemies/data.json", "user://items/ekwipunek.json", "user://items/itemy.json", "user://player/data.json", "user:player/level.json", "user://player/quests.json", "user://quests/data.json"]

func _ready():
	var i = 0
	for path in paths:
		if(!is_dir(path)):
			make_dr(path.split("/")[2])
		if(!is_file(copyFiles[i])):
			create_file(files[i], copyFiles[i])
		i += 1
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
	var dir = Directory.new()
	print("PathToCopy " + str(pathToCopy) + "\n pathToCreate " + str(pathToCreate))
	dir.copy(pathToCreate, pathToCopy)
	pass
