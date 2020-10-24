extends Node2D

var file = File.new()
var fileUser = File.new()
var fajl = File.new()
var stp
var jsonR
var jsonL
var rng = RandomNumberGenerator.new()
var dru = false
var Ndata
var levl

func _ready():
	fileUser.open("user://player/quests.json", File.READ_WRITE)
	jsonR=JSON.parse(fileUser.get_as_text()).result
	rng.randomize()
	if jsonR.quests == [] || jsonR.quests == null || jsonR.quests.empty():
		file.open("res://data/quests/data.json", File.READ)
		jsonL=JSON.parse(file.get_as_text()).result
		var rand1 = rng.randi_range(0, jsonL.size()-1)
		var rand2 = rng.randi_range(0, jsonL.size()-1)
		if rand1 == rand2:
			rand2 = rng.randi_range(0, jsonL.size()-1)
		var rand3 = rng.randi_range(0, jsonL.size()-1)
		if rand2 == rand3 || rand1 == rand3:
			rand3 = rng.randi_range(0, jsonL.size()-1)
		var a = ["","",""]
		a[0] = jsonL[1].text.replace("#RAND#", rng.randi_range(1, 10))
		a[1] = jsonL[3].text.replace("#RAND#", rng.randi_range(1, 10))
		a[2] = jsonL[2].text.replace("#RAND#", rng.randi_range(1, 10))
		Ndata = { "quests": [
			a[0],
			a[1],
			a[2]
		]}
		fileUser.store_line(JSON.print(Ndata))
		file.close()
	
	
	if jsonR.quests == [] || jsonR.quests == null || jsonR.quests.empty():
		$VBoxContainer/TextureRect2/Label.text = Ndata.quests[0]
		$VBoxContainer/TextureRect3/Label2.text = Ndata.quests[1]
		$VBoxContainer/TextureRect4/Label3.text = Ndata.quests[2]
	else:
		$VBoxContainer/TextureRect2/Label.text = jsonR.quests[0]
		$VBoxContainer/TextureRect3/Label2.text = jsonR.quests[1]
		$VBoxContainer/TextureRect4/Label3.text = jsonR.quests[2]
	
	
	fileUser.close()

# warning-ignore:unused_argument
func _process(delta):
	fajl.open("user://player/step.json", File.READ_WRITE)
	stp=JSON.parse(fajl.get_as_text()).result
	if stp == null:
		var datea = {
			"step": 0
		}
		fajl.store_line(JSON.print(datea))
	else:
		var acc = Input.get_accelerometer()
		if dru == false && acc.y<0:
			dru = true
		if dru == true && acc.y>0:
			stp.step += 1
			dru = false
		fajl.store_line(JSON.print(stp))
		$VBoxContainer/TextureRect/kroki.text = String(stp.step)
		if stp.step>=6000:
			stp.step=0
			file.open("user://player/level.json", File.READ_WRITE)
			levl=JSON.parse(file.get_as_text()).result
			rng.randomize()
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
	fajl.close()

func _on_SwipeDetector_swiped(direction):
	if direction == Vector2(1, 0):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Tscn/Main/main.tscn")
	pass # Replace with function body.
