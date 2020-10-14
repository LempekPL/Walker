extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

<<<<<<< HEAD
func _on_Button_pressed():
	get_tree().change_scene("res://Tscn/WalkaScena.tscn") # Replace with function body.
	pass
=======
func _ready():
	$button.connect("toggled",self,"click",[$button])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func click(toggled, target):
	get_tree().change_scene("WalkaScena.tscn")
>>>>>>> 2ca8ae0d18e37aedd2c061308df73dfcba960a26
