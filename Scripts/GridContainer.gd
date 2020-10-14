extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var button
var file
var jsonR
# Called when the node enters the scene tree for the first time.
func _ready():
	file=File.new()
	file.open("res://data/items/data.json", file.READ)
	jsonR=JSON.parse(file.get_as_text()).result
	for i in jsonR.size(): #dlugosc tablicy-1
		button=Button.new()
		button.text=jsonR[String(i+1)]["name"]
		button.size_flags_horizontal=3
		button.rect_min_size=Vector2(80, 80)
		add_child(button)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
