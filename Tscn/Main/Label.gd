extends Label



func _process(delta):
	var file = File.new()
	file.open("user://player/level.json", File.READ)
	var data = JSON.parse(file.get_as_text()).result
	file.close()
	get_parent().get_node("Lvl").text = str(data[0]["level"]) + " Level"
	pass
