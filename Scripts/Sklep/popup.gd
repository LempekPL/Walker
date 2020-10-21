extends Popup

var loot1_items
var drop = 0

func _on_buy_pressed():
	openJSON()
	drop = loot1_items[loot1_items.size()-1]['szansa']
	var random_number = int(rand_range(0, drop))
	var after
	var before
	var win_item

	for item in loot1_items.size():
		before = 0
		if(item != 0):
			before = loot1_items[item-1]['szansa']
		
		after = loot1_items[item]['szansa']
		if(random_number > before && random_number < after):
			win_item = loot1_items[item]['id']
			break
	var file = File.new()
	file.open("res://data/items/itemy.json", File.READ)
	var items = JSON.parse(file.get_as_text()).result
	file.close()
	var winItem
	for item in items:
		if(item['id'] == win_item):
			winItem = item
	var toSave = File.new()
	toSave.open("user://items/ekwipunek.json", File.READ)
	var data = JSON.parse(toSave.get_as_text()).result
	data.push_back(winItem)
	toSave.close()
	var dir = Directory.new()
	dir.remove("user://items/ekwipunek.json")
	file = File.new()
	file.open("user://items/ekwipunek.json", File.WRITE)
	file.store_string(to_json(data))
	file.close()
	pass

func openJSON():
	var file = File.new()
	file.open("res://data/shop/loot1.json", File.READ)
	loot1_items = JSON.parse(file.get_as_text()).result
	file.close()
	pass
