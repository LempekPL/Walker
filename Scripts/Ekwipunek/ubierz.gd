extends Button

var jsonI
var jsonU 
var fileU
var fileI

var id
var gniazdo

func przekaz(_id, _gniazdo):
	id=_id
	gniazdo=_gniazdo

func _ready():
	var fileU=File.new()
	print(fileU.open("res://data/items/ekwipunek.json", fileU.READ_WRITE))
	jsonU=JSON.parse(fileU.get_as_text()).result
	var fileI=File.new()
	fileI.open("res://data/items/itemy.json", fileI.READ_WRITE)
	jsonI=JSON.parse(fileI.get_as_text()).result
	fileI.close()
	fileU.close()
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
	fileI.store_line(to_json(jsonI))
	fileU.store_line(to_json(jsonU))

	get_parent().visible=false
	pass 
