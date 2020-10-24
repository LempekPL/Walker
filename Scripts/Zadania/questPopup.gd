extends Popup

func _ready():
	pass 

func _on_Button_pressed():
	popup_centered()

func _on_ButtonCan_pressed():
	get_node("../Popup").hide()

var file
var levl
var rng = RandomNumberGenerator.new()

func _on_ButtonAcc_pressed():
	file=File.new();
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
	get_node("../Popup").hide()
