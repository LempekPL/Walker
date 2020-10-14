extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var press = get_click_mask()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(press):
		get_tree().change_scene("WalkaScena.tscn")

