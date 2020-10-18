extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var button
# Called when the node enters the scene tree for the first time.
var file
var jsonR

var buttons=[]

func _ready():
	file=File.new()
	file.open("res://data/enemies/data.json", File.READ)
	jsonR=JSON.parse(file.get_as_text()).result
	for i in jsonR.size():
		buttons.insert(i, Poziom.new(self, jsonR[i]))
		
class Poziom:
	var przeciwnik
	var button
	var parent:Node
	func _init(_parent ,_przeciwnik):
		przeciwnik=_przeciwnik
		parent=_parent
		button= Button.new()
		button.text=przeciwnik["name"]
		button.size_flags_horizontal=0
		button.rect_min_size=Vector2(700,50)
		button.connect("pressed", self, "wybierz")
		parent.add_child(button)
		
	func wybierz():
		parent.get_node(NodePath("/root/Node2D/Background3/Button")).incjacja(przeciwnik)
		var scena:Node2D
		scena=parent.get_node("/root/Node2D")
		scena.position=Vector2(-720, 0)
