extends Node2D



func _on_Shop_pressed():
	get_tree().change_scene("res://shop/shop.tscn")
	pass 




func _on_SwipeDetector_swiped(direction):
	if direction == Vector2(1, 0):

		get_tree().change_scene("res://Tscn/ekwipunek.tscn")

	if direction == Vector2(-1, 0):


		get_tree().change_scene("res://Tscn/questy.tscn")


	pass # Replace with function body.
