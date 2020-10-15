extends Node
var file
var jsonR
var items = []
func _ready():
	file=File.new()
	file.open("res://data/items/itemy.json", file.READ)
	jsonR=JSON.parse(file.get_as_text()).result
	for i in jsonR.size()-1:
		items.insert(i, Item.new(self, jsonR[i+1]["name"],jsonR[i+1]["id"],jsonR[i+1]["name"],jsonR[i+1]["opis"],jsonR[i+1]["hp"],jsonR[i+1]["atak"],jsonR[i+1]["rzadkość"]))
	
class Item:
	var newButton : Button
	var parent : Node
	var id
	var nazwa
	var opis
	var hp
	var atak
	var rare
	func _init(_parent, _text, _id, _name, _opis, _hp, _atak, _rare):
		parent = _parent
		id=_id
		nazwa=_name
		opis=_opis
		hp=_hp
		atak=_atak
		rare=_rare
		newButton = Button.new()
		newButton.text = _text
		newButton.size_flags_horizontal=3
		newButton.rect_min_size=Vector2(80, 80)
		newButton.connect("pressed", self, "_on_Button_pressed")
		_parent.add_child(newButton)
		pass

	func _on_Button_pressed():
		parent.get_parent().get_parent().get_node("miniBG").pojaw(nazwa,opis,hp,atak,rare)
		parent.get_parent().get_parent().get_node("miniBG").visible=true
		pass
