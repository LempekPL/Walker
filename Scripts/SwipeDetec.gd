extends Node

signal swiped(direction)
signal swpie_canceled(start_position)

export(float, 1.0, 1.5) var MAX_DIAGONAL_SLOPE = 1.3

onready var timer = $Timer
var start_swipe_pos = Vector2()

func _input(event):
	if not event is InputEventScreenTouch:
		return
	pass 




func _on_Timer_timeout():
	pass # Replace with function body.
