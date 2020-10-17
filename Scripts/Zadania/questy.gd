extends Node2D

var file
var file_user
var file_save
var jsonR
var rng = RandomNumberGenerator.new()

func _ready():
	file=File.new();
	file_user=File.new();
	if not file_user.file_exists("user://data/player/quests.json"):
		file_save=File.new();
		file_save.open("user://data/player/quests.json", File.WRITE)
		file.open("res://data/quests/data.json", File.READ)
		jsonR=JSON.parse(file.get_as_text()).result
		rng.randomize()
		var rand1 = rng.randi_range(0, 9)
		var rand2 = rng.randi_range(0, 9)
		if rand1 == rand2:
			rand2 = rng.randi_range(0, 9)
		var rand3 = rng.randi_range(0, 9)
		if rand2 == rand3 || rand1 == rand3:
			rand3 = rng.randi_range(0, 9)
		
		
		
	#$VBoxContainer/TextureRect2/Label.text = jsonR[]
	#$VBoxContainer/TextureRect3/Label2.text = jsonR[]
	#$VBoxContainer/TextureRect4/Label3.text = jsonR[]

func _on_SwipeDetector_swiped(direction):
	if direction == Vector2(1, 0):
		get_tree().change_scene("res://Tscn/Main/main.tscn")
	pass # Replace with function body.
