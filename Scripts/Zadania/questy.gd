extends Node2D

var file
var fileUser
var fil
var stp
var jsonR
var jsonL
var rng = RandomNumberGenerator.new()
var dru = false

func _ready():
	file=File.new();
	fileUser=File.new();
	fileUser.open("user://player/quests.json", File.READ_WRITE)
	jsonR=JSON.parse(fileUser.get_as_text()).result
	if jsonR.quests == null:
		file.open("res://quests/data.json", File.READ)
		jsonL=JSON.parse(file.get_as_text()).result
		rng.randomize()
		var rand1 = rng.randi_range(0, jsonL.length)
		var rand2 = rng.randi_range(0, jsonL.length)
		if rand1 == rand2:
			rand2 = rng.randi_range(0, jsonL.length)
		var rand3 = rng.randi_range(0, jsonL.length)
		if rand2 == rand3 || rand1 == rand3:
			rand3 = rng.randi_range(0, jsonL.length)
		var Ndata = [
			jsonL[rand1].text,
			jsonL[rand2].text,
			jsonL[rand3].text
		]
		jsonR.quests.store_line(to_json(Ndata))
		jsonL.close()
		
	
	$VBoxContainer/TextureRect2/Label.text = jsonR.quests[0]
	$VBoxContainer/TextureRect3/Label2.text = jsonR.quests[1]
	$VBoxContainer/TextureRect4/Label3.text = jsonR.quests[2]
	
	
	jsonR.close()

func _process(delta):
	fil.open("user://player/step.json", File.READ_WRITE)
	stp=JSON.parse(fileUser.get_as_text()).result
	
	var acc = Input.get_accelerometer()
	if dru == false && acc.y<0:
		dru = true
	if dru == true && acc.y>0:
		stp.step += 1
		dru = false
	
	fil.store_line(to_json(stp))
	$VBoxContainer/TextureRect4/Label3.text = stp.step
	fil.close()

func _on_SwipeDetector_swiped(direction):
	if direction == Vector2(1, 0):
		get_tree().change_scene("res://Tscn/Main/main.tscn")
	pass # Replace with function body.
