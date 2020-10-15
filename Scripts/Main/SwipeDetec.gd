extends Node

signal swiped(direction)
signal swpie_canceled(start_position)

export(float, 1.0, 1.5) var MAX_DIAGONAL_SLOPE = 1.3

onready var timer = $Timer
var start_swipe_pos = Vector2()


func _input(event):
	if not event is InputEventScreenTouch:
		return
	if event.pressed:
		_start_detection(event.position)
	elif not timer.is_stopped():
		_end_detection(event.position)
	pass
	
func _start_detection(position):
	start_swipe_pos = position
	timer.start()
	pass
	
	
func _end_detection(position):
	timer.stop()

	var direction = (position - start_swipe_pos).normalized()

	if abs(direction.x) + abs(direction.y) >= MAX_DIAGONAL_SLOPE:
		return



	if abs(direction.x) > abs(direction.y):

		emit_signal("swiped", Vector2(-sign(direction.x), 0.0))

	else:

		emit_signal("swiped", Vector2(0.0, -sign(direction.y)))
	
	pass 





func _on_Timer_timeout():
	emit_signal("swipe_canceled", start_swipe_pos)
	pass # Replace with function body.
