extends Node2D


func _on_SwipeDetector_swiped(direction):
	if direction == Vector2(1, 0):

		print("left")
		position.x +=  720
		#RIGHT

	if direction == Vector2(-1, 0):
		print("right")
		position.x -=  720
		#LEFT
		

	pass # Replace with function body.
