extends Popup

func _ready():
	pass 

var info

func _on_Button_pressed():
	info = 0
	popup_centered()

func _on_Button2_pressed():
	info = 1
	popup_centered()


func _on_Button3_pressed():
	info = 2
	popup_centered()

func _on_ButtonCan_pressed():
	get_node("../Popup").hide()

var file
var fajl
var fil
var levl
var data
var datauser
var rng = RandomNumberGenerator.new()
var Ndata

func _on_ButtonAcc_pressed():
	rng.randomize()
	get_node("../Popup").hide()
	fajl=File.new()
	fil=File.new()
	fil.open("user://player/quests.json", File.READ_WRITE)
	datauser=JSON.parse(fil.get_as_text()).result
	fajl.open("res://data/quests/data.json", File.READ)
	data=JSON.parse(fajl.get_as_text()).result
	var rand1 = rng.randi_range(0, data.size()-1)
	var a = [datauser.quests[0],datauser.quests[1],datauser.quests[2]]
	a[info] = data[rand1].text.replace("#RAND#", rng.randi_range(1, 10))
	Ndata = { "quests": [
		a[0],
		a[1],
		a[2]
	]}
	fil.store_line(JSON.print(Ndata))
	fil.close()
	fajl.close()
	file=File.new();
	file.open("user://player/level.json", File.READ_WRITE)
	levl=JSON.parse(file.get_as_text()).result
	levl[0].exp+=rng.randi_range(1, 10)
	levl[0].money+=rng.randi_range(5, 30)
	var nev = [
		{
			"level": levl[0].level,
			"exp": levl[0].exp,
			"money": levl[0].money
		}
	]
	file.store_line(JSON.print(nev))
	file.close()
	get_tree().change_scene("res://Tscn/Main/main.tscn")
	get_tree().change_scene("res://Tscn/Zadania/questy.tscn")
