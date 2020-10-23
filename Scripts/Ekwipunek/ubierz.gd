extends Button

var jsonI=[]
var jsonU = []
var fileU
var fileI

var id
var gniazdo
var G

func przekaz(_id, _gniazdo):
	id=_id
	gniazdo=_gniazdo

func przekazEq(_id):
	G=_id

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
	pass



func _on_Button_pressed():
	if G==null:
		var temp
		temp=jsonI[id]
		jsonI.remove(id)
		for i in jsonU.size():
			if jsonU[i]["gniazdo"]==gniazdo:
				jsonI.push_back(jsonU[i]) if jsonU[i]["name"]!="nic" else null
				jsonU[i]=temp
				break
	else:
		if jsonU[G]["name"]=="nic":
			pass
		else:
			jsonI.push_back(jsonU[G])
			jsonU[G]={
				"name":"nic",
				"opis":"te gniazdo jest puste",
				"hp":0,
				"atak":0,
				"gniazdo":jsonU[G]["gniazdo"],
				"rarity":"ultra_legend",
				"szansa":35,
				"color":[randf(),randf(),randf()]
			}
		G==null
	saveToFile(jsonI, "itemy")
	saveToFile(jsonU, "ekwipunek")
	get_tree().reload_current_scene()
	pass 

func saveToFile(json, name):
	var dir = Directory.new()
	dir.remove("user://items/"+name+".json")
	var file = File.new()
	file.open("user://items/"+name+".json", File.WRITE)
	file.store_string(to_json(json))
	file.close()
	pass
