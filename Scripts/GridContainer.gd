extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var button


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 60: #dlugosc tablicy-1
		button=Button.new()
		button.size_flags_horizontal=3
		button.rect_min_size=Vector2(80, 80)
		add_child(button)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
