extends Button

var przeciwnik
var ekwipunek

func _ready():
	pass # Replace with function body.

func incjacja(przeciwnik):
	get_node("/root/Node2D/Background3/koloWrog/Sprite").ustaw(przeciwnik)
