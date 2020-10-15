extends Node2D

func _ready():
	pass # Replace with function body.


func _on_SwipeDetector_swiped(direction):
	if direction == Vector2(1, 0):
		get_tree().change_scene("res://Tscn/Main/main.tscn")
	pass # Replace with function body.


