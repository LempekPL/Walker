extends Button

var loot1_items
var suma = 0

func _ready():
	openJSON()
	for obj in loot1_items:
		suma = suma + obj["szansa"]
	print(suma)
	pass

func openJSON():
	var file = File.new()
	file.open("res://data/shop/loot1.json", File.READ)
	loot1_items = JSON.parse(file.get_as_text()).result
	pass
