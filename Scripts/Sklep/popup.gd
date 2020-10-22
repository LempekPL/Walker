extends Popup

var loot1_items
var drop = 0

func _on_buy_pressed():
	drop = 0
	loot1_items = []
	openJSON()
	drop = loot1_items[loot1_items.size()-1]['szansa']
	var random_number = int(rand_range(0, drop))
	var after
	var before
	var win_item
	var level = level()

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
			break
	print(winItem['name'])
	winItem['hp'] *= int(pow(sqrt(log(level+2)), 4) * ((randf() - randf() )/10 + 1))
	winItem['atak'] *= int(pow(sqrt(log(level+2)), 4) * ((randf() - randf() )/10 + 1))
	print(winItem['hp'])
	var toSave = File.new()
	toSave.open("user://items/itemy.json", File.READ)
	var data = JSON.parse(toSave.get_as_text()).result
	data.push_back(winItem)
	print(data)
	toSave.close()
	var dir = Directory.new()
	dir.remove("user://items/itemy.json")
	file = File.new()
	file.open("user://items/itemy.json", File.WRITE)
	file.store_string(to_json(data))
	file.close()
	pass

func openJSON():
	var file = File.new()
	file.open("res://data/shop/loot1.json", File.READ)
	loot1_items = JSON.parse(file.get_as_text()).result
	file.close()
	pass

func level():
	var file = File.new()
	file.open("res://data/player/level.json", File.READ)
	var lvl = JSON.parse(file.get_as_text()).result
	file.close()
	return lvl[0]['level']
	pass
