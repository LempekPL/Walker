extends Button

var jsonI=[]
var jsonU = []
var fileU
var fileI

var id
var gniazdo

func przekaz(_id, _gniazdo):
	id=_id
	gniazdo=_gniazdo

func _ready():
	print(OS.get_user_data_dir())
	fileU=File.new()
	fileU.open("user://items/ekwipunek.json", File.READ)
	jsonU=JSON.parse(fileU.get_as_text()).result
	fileU.close()
	fileI=File.new()
	fileI.open("user://items/itemy.json", File.READ)
	jsonI=JSON.parse(fileI.get_as_text()).result
	fileI.close()
	pass # Replace with function body.



func _on_Button_pressed():
#	var fileU=File.new()
#	var fileI=File.new()
#	print(fileI.open("res://data/items/itemy.json", File.READ_WRITE))
#	fileU.open("res://data/items/ekwipunek.json", File.READ_WRITE)
	var temp

	for i in jsonI.size()-1:
		if jsonI[i+1]["id"]==id:
			temp=jsonI[i+1]
			jsonI.remove(i+1)
			break
	for i in jsonU.size():
		if jsonU[i]["gniazdo"]==gniazdo:
			jsonI.push_back(jsonU[i])
			jsonU[i]=temp
			break
	
	saveToFile(jsonI, "itemy")
	saveToFile(jsonU, "ekwipunek")
	get_parent().get_parent().get_node("ScrollContainer/GridContainer")._ready()
	get_parent().get_parent().get_node("VBoxContainer")._ready()
	get_parent().get_parent().get_node("VBoxContainer2")._ready()
	get_parent().visible=false
	pass 

func saveToFile(json, name):
	var dir = Directory.new()
	dir.remove("user://items/"+name+".json")
	var file = File.new()
	file.open("user://items/"+name+".json", File.WRITE)
	file.store_string(to_json(json))
	file.close()
	pass
