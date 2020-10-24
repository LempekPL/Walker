extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var label
var labels=[]
var jsonI
var jsonL
func _ready():
	var file=File.new()
	file.open()
	pass 

func ustaw(przeciwnik, wynik):
	get_parent().get_node("Label").text=wynik
	get_parent().get_parent().get_node("Background3").visible=false
	if wynik=="Wygrana":
		for i in przeciwnik["nagrody"].size():
			label= Label.new()
			label.align=Label.ALIGN_CENTER
			var dynamic_font = DynamicFont.new()
			dynamic_font.font_data = load("res://resources/PTC55F.ttf")
			dynamic_font.size = 30
			dynamic_font.outline_size = 0
			dynamic_font.outline_color = Color( 0, 0, 0, 1 )
			dynamic_font.use_filter = true
			label.add_color_override("font_color", Color(0,0,0,1))
			label.add_font_override("font", dynamic_font)
			if przeciwnik["nagrody"][i]["name"]=="przedmiot":
				label.text=przeciwnik["nagrody"][i]["name"]+": "+przeciwnik["nagrody"][i]["value"]["name"]
				
			else:
				label.text=przeciwnik["nagrody"][i]["name"]+": "+str(przeciwnik["nagrody"][i]["value"])
			add_child(label)
			labels.push_back(label)
	get_parent().get_parent().position=Vector2(-1420, 0)
	
