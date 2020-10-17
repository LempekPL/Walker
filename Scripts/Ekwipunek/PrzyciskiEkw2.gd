extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var file
var jsonR

func _ready():
	file=File.new();
	file.open("res://data/items/ekwipunek.json", file.READ)
	jsonR=JSON.parse(file.get_as_text()).result
	$Button.text=jsonR[3]["name"]
	$Button2.text=jsonR[4]["name"]
	$Button3.text=jsonR[5]["name"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
