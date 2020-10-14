extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	$button.connect("pushed",self,"click",[$button])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func click(toggled, target):
	get_tree().change_scene("WalkaScena.tscn")
