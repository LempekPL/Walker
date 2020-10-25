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

var st=true

var tyG
var wG

func _ready():
	tyG=self.get_parent().get_node("ktos")
	wG=self.get_parent().get_node("ktos2")
	self.visible=true
	file=File.new()
	file.open("user://player/data.json", File.READ)
	jsonR=JSON.parse(file.get_as_text()).result
	file.close()
	label=get_parent().get_node("Label")
	koloWrog=get_parent().get_node("koloWrog/Sprite")
	koloTy=get_parent().get_node("koloTy/Sprite")
	tyG.set_texture(load("res://resources/Walka/normal/pielegniarka-min.png"))
	var Is = tyG.get_texture().get_size() #image size
	var th = 5 #target height
	var tw = 6 #target width
	var scale = Vector2((Is.x/(Is.x/tw))/50, (Is.y/(Is.y/th))/50)
	tyG.set_scale(scale)
	get_parent().get_node("pasekTy").get_node("krokibar/krokibar").max_value=int(jsonR["hp"])
	get_parent().get_node("pasekTy").get_node("krokibar/krokibar").value=int(jsonR["hp"])


func _process(delta):
	tyStatus=koloTy.status
	wrogStatus=koloWrog.status
	if tyStatus==0&&wrogStatus==0&&st:
		self.visible=true
		if status:
			wylosowano()
	else:
		self.visible=false

func incjacja(_przeciwnik):
	przeciwnik=_przeciwnik
	get_node("/root/Node2D/Background3/koloWrog/Sprite").ustaw(_przeciwnik)
	wG.set_texture(load("res://resources/Walka/normal/"+przeciwnik["name"]+".png"))
	var Is = tyG.get_texture().get_size() #image size
	var th = 5 #target height
	var tw = 6 #target width
	var scale = Vector2((Is.x/(Is.x/tw))/50, (Is.y/(Is.y/th))/50)
	wG.set_scale(scale)
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
		tyHp-=item["atak"]
		if item["atak"]>0:
			status=false
			tyG.set_texture(load("res://resources/Walka/damage/piel_dam-min.png"))
			yield(get_tree().create_timer(2.0), "timeout")
			tyG.set_texture(load("res://resources/Walka/normal/pielegniarka-min.png"))
			status=true
		wrogHp+=int(item["hp"])
		if item["hp"]>0:
			status=false
			wG.set_texture(load("res://resources/Walka/healing/"+przeciwnik["name"]+".png"))
			yield(get_tree().create_timer(2.0), "timeout")
			wG.set_texture(load("res://resources/Walka/normal/"+przeciwnik["name"]+".png"))
			status=true
		
	elif kolejka==0:
		wrogHp-=item["atak"]
		if item["atak"]>0:
			status=false
			wG.set_texture(load("res://resources/Walka/damage/"+przeciwnik["name"]+".png"))
			yield(get_tree().create_timer(2.0), "timeout")
			wG.set_texture(load("res://resources/Walka/normal/"+przeciwnik["name"]+".png"))
			status=true
		tyHp+=item["hp"]
		if item["hp"]>0:
			status=false
			tyG.set_texture(load("res://resources/Walka/healing/piel_heal-min.png"))
			yield(get_tree().create_timer(2.0), "timeout")
			tyG.set_texture(load("res://resources/Walka/normal/pielegniarka-min.png"))
			status=true

	get_parent().get_node("HpTy").text=str(tyHp)
	get_parent().get_node("pasekTy").get_node("krokibar")._on_kroki_updated(tyHp,0)
	get_parent().get_node("pasekWrog").get_node("krokibar")._on_kroki_updated(wrogHp,0)
	get_parent().get_node("HpWrog").text=str(wrogHp)
	status=false
	if tyHp<=0:
		przegrana()
	elif wrogHp<=0:
		wygrana()

func przegrana():
	st=false
	self.visible=0
	yield(get_tree().create_timer(3.0), "timeout")
	get_parent().get_parent().get_node("Background4/VBoxContainer").ustaw(przeciwnik, "Przegrana")

func wygrana():
	st=false
	self.visible=0
	yield(get_tree().create_timer(3.0), "timeout")
	get_parent().get_parent().get_node("Background4/VBoxContainer").ustaw(przeciwnik, "Wygrana")
