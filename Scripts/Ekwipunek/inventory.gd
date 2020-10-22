extends Node
var file
var jsonR
var items = []
func _ready():
	file=File.new()
	print(file.open("user://items/itemy.json", file.READ))
	jsonR=JSON.parse(file.get_as_text()).result
	print(jsonR)
	file.close()
	for i in jsonR.size()-1:
		items.insert(i, Item.new(self, jsonR[i+1]["name"],jsonR[i+1]["id"],jsonR[i+1]["name"],jsonR[i+1]["opis"],jsonR[i+1]["hp"],jsonR[i+1]["atak"],jsonR[i+1]["rarity"], jsonR[i+1]["gniazdo"]))
	
class Item:
	var newButton : Button
	var parent : Node
	var id
	var nazwa
	var opis
	var hp
	var atak
	var rare
	var gniazdo
	func _init(_parent, _text, _id, _name, _opis, _hp, _atak, _rare, _gniazdo):
		parent = _parent
		id=_id
		nazwa=_name
		opis=_opis
		hp=_hp
		atak=_atak
		rare=_rare
		gniazdo=_gniazdo
		newButton = Button.new()
		newButton.text = _text
		newButton.size_flags_horizontal=3
		newButton.rect_min_size=Vector2(80, 80)
		var dynamic_font = DynamicFont.new()
		dynamic_font.font_data = load("res://resources/PTC55F.ttf")
		dynamic_font.size = 30
		dynamic_font.outline_size = 0
		dynamic_font.outline_color = Color( 0, 0, 0, 1 )
		dynamic_font.use_filter = true
		newButton.add_font_override("font", dynamic_font)
		newButton.connect("pressed", self, "_on_Button_pressed")
		_parent.add_child(newButton)
		pass

	func _on_Button_pressed():
		parent.get_parent().get_parent().get_node("miniBG").pojaw(nazwa,opis,hp,atak,rare)
		parent.get_parent().get_parent().get_node("miniBG").visible=true
		parent.get_parent().get_parent().get_node("miniBG").get_node("Button").przekaz(id, gniazdo)
		pass
