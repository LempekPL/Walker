extends Button

var przeciwnik
var item

var status=false
var kolejka=0

var label

var koloTy
var tyStatus

var koloWrog
var wrogStatus

func _ready():
	label=get_parent().get_node("Label")
	koloWrog=get_parent().get_node("koloWrog/Sprite")
	koloTy=get_parent().get_node("koloTy/Sprite")

	pass

func _process(delta):
	tyStatus=koloTy.status
	wrogStatus=koloWrog.status
	if tyStatus==0&&wrogStatus==0:
		self.visible=true
		if status:
			wylosowano()
	else:
		self.visible=false

func incjacja(_przeciwnik):
	przeciwnik=_przeciwnik
	get_node("/root/Node2D/Background3/koloWrog/Sprite").ustaw(_przeciwnik)


func _on_Button_pressed():
	if kolejka==0:
		item=koloWrog.losuj()
		status=true
		kolejka=1
	elif kolejka==1:
		item=koloTy.losuj()
		status=true
		kolejka=0

func wylosowano():
	label.text=item["name"]+"\n +hp: "+String(item["hp"])+" atak: "+String(item["atak"])
	
