extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var label
var labels=[]
var jsonI
var jsonL
func _ready():
	pass 

func ustaw(przeciwnik, wynik):
	var fileL=File.new()
	fileL.open("user://player/level.json", File.READ)
	jsonL=JSON.parse(fileL.get_as_text()).result
	var fileI=File.new()
	fileI.open("user://items/itemy.json", File.READ)
	jsonI=JSON.parse(fileI.get_as_text()).result
	fileI.close()
	fileL.close()
	
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://resources/PTC55F.ttf")
	dynamic_font.size = 30
	dynamic_font.outline_size = 0
	dynamic_font.outline_color = Color( 0, 0, 0, 1 )
	dynamic_font.use_filter = true
	
	get_parent().get_node("Label").text=wynik
	get_parent().get_parent().get_node("Background3").visible=false
	
	if wynik=="Wygrana":
		for i in przeciwnik["nagrody"].size():
			label= Label.new()
			label.align=Label.ALIGN_CENTER
			label.add_color_override("font_color", Color(0,0,0,1))
			label.add_font_override("font", dynamic_font)
			if przeciwnik["nagrody"][i]["name"]=="przedmiot":
				label.text=przeciwnik["nagrody"][i]["name"]+": "+przeciwnik["nagrody"][i]["value"]["name"]
				przeciwnik["nagrody"][i]["value"]["color"]=[randf(),randf(),randf()]
				przeciwnik["nagrody"][i]["value"]["opis"]="nagroda za pokonanie przeciwnika"
				przeciwnik["nagrody"][i]["value"]["rarity"]="epik"
				
				jsonI.push_front(przeciwnik["nagrody"][i]["value"])
			else:
				label.text=przeciwnik["nagrody"][i]["name"]+": "+str(przeciwnik["nagrody"][i]["value"])
				if przeciwnik["nagrody"][i]["name"]=="HealCoins":
					jsonL[0]["money"]+=przeciwnik["nagrody"][i]["value"]
				elif przeciwnik["nagrody"][i]["name"]=="doświadczenie":
					jsonL[0]["exp"]+=przeciwnik["nagrody"][i]["value"]
			add_child(label)
			labels.push_back(label)
	elif wynik=="Przegrana":
		label= Label.new()
		for i in przeciwnik["nagrody"].size():	
			label.align=Label.ALIGN_CENTER
			label.add_color_override("font_color", Color(0,0,0,1))
			label.add_font_override("font", dynamic_font)
			if przeciwnik["nagrody"][i]["name"]=="przedmiot":
				false
			else:
				label.text=przeciwnik["nagrody"][i]["name"]+": "+str(przeciwnik["nagrody"][i]["value"]/10)
				if przeciwnik["nagrody"][i]["name"]=="HealCoins":
					jsonL[0]["money"]+=przeciwnik["nagrody"][i]["value"]/10
				elif przeciwnik["nagrody"][i]["name"]=="doświadczenie":
					jsonL[0]["exp"]+=przeciwnik["nagrody"][i]["value"]/10
			add_child(label)
			labels.push_back(label)
	get_parent().get_parent().position=Vector2(-1420, 0)
	saveToFile(jsonI, "user://items/itemy.json")
	saveToFile(jsonL, "user://player/level.json")
	
func saveToFile(json, name):
	var dir = Directory.new()
	dir.remove(name)
	var file = File.new()
	file.open(name, File.WRITE)
	file.store_string(to_json(json))
	file.close()
	pass
	
