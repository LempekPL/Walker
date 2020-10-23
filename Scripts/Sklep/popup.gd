extends Popup

var loot_items
var drop = 0
var flag = false
var path

func _on_buy2_pressed():
	self.popup()
	get_parent().get_node("popup/WindowDialog").popup()
	path = "res://data/shop/loot2.json"
	pass 

func _on_buy_pressed():
	self.popup()
	get_parent().get_node("popup/WindowDialog").popup()
	path = "res://data/shop/loot1.json"
	pass

func _process(delta):
	var file = File.new()
	file.open("user://player/level.json", File.READ)
	var data = JSON.parse(file.get_as_text()).result
	var money = data[0]['money']
	file.close()
	if(flag && money > 399):
		drop = 0
		loot_items = []
		openJSON()
		drop = loot_items[loot_items.size()-1]['szansa']
		var random_number = int(rand_range(0, drop))
		var after
		var before
		var win_item
		var level = level()

		for item in loot_items.size():
			before = 0
			if(item != 0):
				before = loot_items[item-1]['szansa']
			
			after = loot_items[item]['szansa']
			if(random_number > before && random_number < after):
				win_item = loot_items[item]['id']
				break
		file = File.new()
		file.open("res://data/items/itemy.json", File.READ)
		var items = JSON.parse(file.get_as_text()).result
		file.close()
		
		var winItem

		for item in items:
			if(item['id'] == win_item):
				winItem = item
				break
		winItem['hp'] *= int(pow(sqrt(log(level+2)), 4) * ((randf() - randf() )/10 + 1))
		winItem['atak'] *= int(pow(sqrt(log(level+2)), 4) * ((randf() - randf() )/10 + 1))
		var toSave = File.new()
		toSave.open("user://items/ekwipunek.json", File.READ)
		data = JSON.parse(toSave.get_as_text()).result
		data.push_back(winItem)
		toSave.close()
		var dir = Directory.new()
		dir.remove("user://items/itemy.json")
		file = File.new()
		file.open("user://items/itemy.json", File.WRITE)
		file.store_string(to_json(data))
		file.close()
	if(flag):
		flag = false
	pass

func openJSON():
	var file = File.new()
	file.open(path, File.READ)
	loot_items = JSON.parse(file.get_as_text()).result
	file.close()
	pass

func level():
	var file = File.new()
	file.open("res://data/player/level.json", File.READ)
	var lvl = JSON.parse(file.get_as_text()).result
	file.close()
	return lvl[0]['level']
	pass


func _on_yes_pressed():
	flag = true
	self.hide()
	get_parent().get_node("popup/WindowDialog").hide()
	pass


func _on_no_pressed():
	self.hide()
	get_parent().get_node("popup/WindowDialog").hide()
	pass 



