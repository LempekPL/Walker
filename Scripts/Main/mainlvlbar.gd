extends Node2D

var data = []
var maxExp
var experience
var level

func _ready():
	var file = File.new()
	file.open("user://player/level.json", File.READ)
	data = JSON.parse(file.get_as_text()).result
	file.close()
	
	experience = data[0]['exp']
	level = data[0]['level']
	maxExp = int(48*pow(log(level+15),2)/pow(log(5),2))
	
	print(maxExp)
	print(experience)
	
	get_parent().get_node("Bar/levelbar/lvlbar").value = experience
	get_parent().get_node("Bar/levelbar/lvlbar").max_value = maxExp
	pass

func _process(delta):
	if(experience > maxExp):
		experience = experience - maxExp
		level += 1
		maxExp = int()
		print("level " + str(level))
		print("maxExp " + str(maxExp))
		print("experience " + str(experience))
		saveToFile(experience, level)
	get_parent().get_node("Bar/levelbar/lvlbar").value = experience
	get_parent().get_node("Bar/levelbar/lvlbar").max_value = maxExp
	pass


func saveToFile(experience, level):
	var dir = Directory.new()
	dir.remove("user://player/level.json")
	var file = File.new()
	var data = [{"level": level, "exp": experience}]
	file.open("user://player/level.json", File.WRITE)
	file.store_string(to_json(data))
	file.close()
	pass
