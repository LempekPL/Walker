extends Button

var hour
var minutes
var seconds

var leftHour
var leftMinutes
var leftSeconds

var isDaily = false
var count = 0
onready var i = 0

var flag = false
var drop = 0
var daily
var flag2 = true

onready var timer = get_node("Timer")

func _ready():
	var file = File.new()
	file.open("user://player/daily.json", File.READ)
	daily = JSON.parse(file.get_as_text()).result
	isDaily = daily[0]['isDaily']
	count = daily[0]['countDaily']
	file.close()
	timer.set_wait_time(1)
	timer.start()
	
	pass

func _process(delta):
	var time = OS.get_datetime()
	var file = File.new()
	file.open("user://player/stuff.json", File.READ)
	var day = JSON.parse(file.get_as_text()).result
	file.close()
	if(int(day['data'])-int(time['day']) > 0 && flag2):
		file = File.new()
		file.open("user://player/daily.json", File.READ)
		var data = JSON.parse(file.get_as_text()).result
		file.close()
		var dir = Directory.new()
		dir.remove("user://player/daily.json")
		file = File.new()
		file.open("user://player/daily.json", File.WRITE)
		file.store_string(to_json(data))
		file.close()
		count += 1
		flag2 = false
	if(int(day['data'])-int(time['day']) == 0):
		flag = true
	if(count < 1):
		self.disabled = true
	hour = time.hour
	minutes = time.minute
	seconds = time.second
	self.text = "Odbierz za: " + str(leftHour) + "h" + str(leftMinutes) + "min." + str(leftSeconds) + "sek."
	
	if(leftHour == 0 && leftMinutes == 0 && leftSeconds == 1 && i == 0):
		self.disabled = false
		file = File.new()
		file.open("user://player/daily.json", File.READ)
		var data = JSON.parse(file.get_as_text()).result
		data[0]['isDaily'] = true
		data[0]["countDaily"] += 1
		file.close()
		file = File.new()
		var Dir = Directory.new()
		Dir.remove("user://player/daily.json")
		file.open("user://player/daily.json", File.WRITE)
		file.store_string(to_json(data))
		isDaily = true
		i+=1
	pass

func TimerTimeOut():
	leftHour = 24-int(hour)
	leftMinutes = 60-int(minutes)
	leftSeconds = 60-int(seconds)
	pass


func _on_dailychest_pressed():
	if(count > 0 && isDaily == true):
		count -= 1
		var loot_items = openJSON()
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
		var file = File.new()
		file.open("res://data/items/itemy.json", File.READ)
		var items = JSON.parse(file.get_as_text()).result
		file.close()
		var Dir = Directory.new()
		Dir.remove("user://player/daily.json")
		file.open("user://player/daily.json", File.WRITE)
		daily[0]['countDaily'] -= 1
		file.store_string(to_json(daily))
		
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
		var data = JSON.parse(toSave.get_as_text()).result
		data.push_back(winItem)
		toSave.close()
		var dir = Directory.new()
		dir.remove("user://items/itemy.json")
		file = File.new()
		file.open("user://items/itemy.json", File.WRITE)
		file.store_string(to_json(data))
		file.close()
		file = File.new()
		file.open("user://player/level.json", File.READ)
		data = JSON.parse(file.get_as_text()).result
		file.close()
		dir.remove("user://player/level.json")
		file = File.new()
		file.open("user://player/level.json", File.WRITE)
		file.store_string(to_json(data))
		file.close()
	if(flag):
		flag = false
	pass
	pass

func openJSON():
	var file = File.new()
	file.open("res://data/shop/dailyChest.json", File.READ)
	var loot_items = JSON.parse(file.get_as_text()).result
	file.close()
	return loot_items
	pass

func level():
	var file = File.new()
	file.open("res://data/player/level.json", File.READ)
	var lvl = JSON.parse(file.get_as_text()).result
	file.close()
	return lvl[0]['level']
	pass
