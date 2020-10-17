extends Node2D

func _on_Shop_pressed():
	get_tree().change_scene("res://Tscn/Sklep/shop.tscn")
	pass 




func _on_SwipeDetector_swiped(direction):
	if direction == Vector2(1, 0):

		get_tree().change_scene("res://Tscn/Ekwipunek/ekwipunek.tscn")

	if direction == Vector2(-1, 0):


		get_tree().change_scene("res://Tscn/Zadania/questy.tscn")


	pass # Replace with function body.


func _on_Fight_pressed():
	get_tree().change_scene("res://Tscn/Walka/WalkaScena.tscn")
	pass # Replace with function body.
