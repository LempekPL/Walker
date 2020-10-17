extends Popup

func _ready():
	pass 

func _on_Button_pressed():
	popup_centered()

func _on_ButtonCan_pressed():
	get_node("../Popup").hide()

var file
var jsonR
var rng = RandomNumberGenerator.new()

func _on_ButtonAcc_pressed():
	file=File.new();
	file.open("user://data/player/level.json", file.WRITE)
	jsonR=JSON.parse(file.get_as_text()).result
	rng.randomize()
	var rand = rng.randi_range(5, 20)
	#jsonR.exp += rand
	#file.store_line(to_json(jsonR))
	file.close()
	get_node("../Popup").hide()
