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

var tyHp
var wrogHp

var file
var jsonR

func _ready():
	file=File.new()
	file.open("user://player/data.json", File.READ)
	jsonR=JSON.parse(file.get_as_text()).result
	label=get_parent().get_node("Label")
	koloWrog=get_parent().get_node("koloWrog/Sprite")
	koloTy=get_parent().get_node("koloTy/Sprite")
	get_parent().get_node("pasekTy").get_node("krokibar/krokibar").max_value=int(jsonR["hp"])
	get_parent().get_node("pasekTy").get_node("krokibar/krokibar").value=int(jsonR["hp"])
	

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
	print(przeciwnik["hp"])
	wrogHp=przeciwnik["hp"]
	get_parent().get_node("HpWrog").text=str(wrogHp)	
	get_parent().get_node("pasekWrog").get_node("krokibar/krokibar").max_value=int(przeciwnik["hp"])
	get_parent().get_node("pasekWrog").get_node("krokibar/krokibar").value=int(przeciwnik["hp"])
	tyHp=jsonR["hp"]

func _on_Button_pressed():
	self.visible=false
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
	if kolejka==1:
		print(wrogHp)
		tyHp-=item["atak"]
		wrogHp+=int(item["hp"])
		print(wrogHp)
		kolejka+=0
	elif kolejka==0:
		wrogHp-=item["atak"]
		tyHp+=item["hp"]
	if tyHp<=0:
		przegrana()
	elif wrogHp<=0:
		wygrana()
	get_parent().get_node("HpTy").text=str(tyHp)
	get_parent().get_node("pasekTy").get_node("krokibar")._on_kroki_updated(tyHp,0)
	get_parent().get_node("pasekWrog").get_node("krokibar")._on_kroki_updated(wrogHp,0)
	get_parent().get_node("HpWrog").text=str(wrogHp)
	
	status=false
func przegrana():
	print("przegrana")

func wygrana():
	print("wygrana")
