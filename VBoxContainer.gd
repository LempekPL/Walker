extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var button
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 100:
		button= Button.new()
		button.text="poziom"+String(i)
		button.size_flags_horizontal=0
		button.rect_min_size=Vector2(700,50)
		add_child(button)
