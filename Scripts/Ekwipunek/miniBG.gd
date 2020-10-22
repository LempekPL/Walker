extends Sprite

var file
var jsonR
func _ready():
	file=File.new()
	file.open("user://items/itemy.json", file.READ)
	jsonR=JSON.parse(file.get_as_text()).result
	file.close()	
func pojaw(name, opis, hp, atak,rare):
	$nazwa.text=name
	$opis.text=opis
	$hp.text=String(hp)
	$atak.text=String(atak)
	$rare.text=rare
