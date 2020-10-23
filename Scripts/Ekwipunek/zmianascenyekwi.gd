extends Node2D

onready var miniBG = get_node("miniBG")
var jsonR
func _ready():
	var file =File.new()
	file.open("user://items/ekwipunek.json", File.READ)
	jsonR=JSON.parse(file.get_as_text()).result
	pass # Replace with function body.


func _on_SwipeDetector_swiped(direction):
	if direction == Vector2(-1, 0):
		get_tree().change_scene("res://Tscn/Main/main.tscn")
	pass # Replace with function body.



func _on_Button_pressed():
	miniBG.pojaw(jsonR[0]["name"], jsonR[0]["opis"], jsonR[0]["hp"], jsonR[0]["atak"], jsonR[0]["rarity"], jsonR[0]['gniazdo'], jsonR[0]['szansa'])
	miniBG.visible=true
	miniBG.get_node("Button").przekazEq(0)
	pass # Replace with function body.


func _on_Button2_pressed():
	miniBG.pojaw(jsonR[1]["name"], jsonR[1]["opis"], jsonR[1]["hp"], jsonR[1]["atak"], jsonR[1]["rarity"], jsonR[1]['gniazdo'], jsonR[1]['szansa'])
	miniBG.visible=true
	miniBG.get_node("Button").przekazEq(1)
	pass # Replace with function body.


func _on_Button3_pressed():
	miniBG.pojaw(jsonR[2]["name"], jsonR[2]["opis"], jsonR[2]["hp"], jsonR[2]["atak"], jsonR[2]["rarity"], jsonR[2]['gniazdo'], jsonR[2]['szansa'])
	miniBG.visible=true
	miniBG.get_node("Button").przekazEq(2)
	pass # Replace with function body.


func _on_Button00_pressed():
	miniBG.pojaw(jsonR[3]["name"], jsonR[3]["opis"], jsonR[3]["hp"], jsonR[3]["atak"], jsonR[3]["rarity"], jsonR[3]['gniazdo'], jsonR[3]['szansa'])
	miniBG.visible=true
	miniBG.get_node("Button").przekazEq(3)
	pass # Replace with function body.


func _on_Button22_pressed():
	miniBG.pojaw(jsonR[4]["name"], jsonR[4]["opis"], jsonR[4]["hp"], jsonR[4]["atak"], jsonR[4]["rarity"], jsonR[4]['gniazdo'], jsonR[4]['szansa'])
	miniBG.visible=true
	miniBG.get_node("Button").przekazEq(4)
	pass # Replace with function body.


func _on_Button33_pressed():
	miniBG.pojaw(jsonR[5]["name"], jsonR[5]["opis"], jsonR[5]["hp"], jsonR[5]["atak"], jsonR[5]["rarity"], jsonR[5]['gniazdo'], jsonR[5]['szansa'])
	miniBG.visible=true
	miniBG.get_node("Button").przekazEq(5)
	pass # Replace with function body.
