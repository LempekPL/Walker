extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SwipeDetector_swiped(direction):
	if direction == Vector2(1, 0):
		get_tree().change_scene("res://Tscn/main.tscn")
	pass # Replace with function body.
