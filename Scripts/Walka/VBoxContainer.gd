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
	file.open("user://enemies/data.json", File.READ)
	jsonR=JSON.parse(file.get_as_text()).result
	for i in jsonR.size():
		buttons.insert(i, Poziom.new(self, jsonR[i], i))
		
class Poziom:
	var przeciwnik
	var button
	var parent:Node
	var i
	func _init(_parent ,_przeciwnik, _i):
		przeciwnik=_przeciwnik
		parent=_parent
		i=_i
		button= Button.new()
		button.text=przeciwnik["name"]
		button.size_flags_horizontal=0
		button.rect_min_size=Vector2(700,50)
		var dynamic_font = DynamicFont.new()
		dynamic_font.font_data = load("res://resources/PTC55F.ttf")
		dynamic_font.size = 30
		dynamic_font.outline_size = 0
		dynamic_font.outline_color = Color( 0, 0, 0, 1 )
		dynamic_font.use_filter = true
		button.add_font_override("font", dynamic_font)
		button.connect("pressed", self, "wybierz")
		parent.add_child(button)
		
	func wybierz():
		var file= File.new()
		file.open("user://player/level.json", File.READ)
		var jsonR= JSON.parse(file.get_as_text()).result
		file.close()
		if i<=jsonR[0]["level"]/2:
			parent.get_node(NodePath("/root/Node2D/Background3/Button")).incjacja(przeciwnik)
			var scena:Node2D
			scena=parent.get_node("/root/Node2D")
			scena.position=Vector2(-720, 0)
		else:
			button.text="potrzebujesz "+ str(i*2)+" poziomu"
			yield(parent.get_tree().create_timer(3.0), "timeout")
			button.text=przeciwnik["name"]
