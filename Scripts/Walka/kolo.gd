extends Sprite

#nie patrz na to nie wiem co to robi ale działa
func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	points_arc.push_back(center)
	var colors = PoolColorArray([color])

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)
var file
var jsonR
var angles
var prz
var v=0.0
var label

var speed=0
var status=0
var licznikStatus=-1
var zatrzymanie=0

const RADIUS = 200

var labels=[]

func _ready():
	file=File.new();
	file.open("res://data/items/ekwipunek.json", file.READ)
	jsonR=JSON.parse(file.get_as_text()).result
	angles=range(jsonR.size())
	prz=range(jsonR.size())
	var sum=0.0
	for i in jsonR.size():
		sum+=jsonR[i]["szansa"]
	for i in jsonR.size():
		angles[i]=float(jsonR[i]["szansa"])/sum*360
	var licznik=-1.0
	for i in angles.size():
		prz[i]=[licznik+1.0,0]
		prz[i][1]=prz[i][0]+angles[i]
		licznik+=angles[i]
	
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://resources/PTC55F.ttf")
	dynamic_font.size = 30
	dynamic_font.outline_size = 5
	dynamic_font.outline_color = Color( 0, 0, 0, 1 )
	dynamic_font.use_filter = true
	

	
	for i in jsonR.size():
		label=Label.new()
		label.text=jsonR[i]["name"]
		var angl:float
		angl=prz[i][0]-((prz[i][0]-prz[i][1])/2)
		var x=sin(angl*PI/180.0)*RADIUS
		var y=-cos(angl*PI/180.0)*RADIUS
		label.rect_position=Vector2(x, y)
		label.add_font_override("font", dynamic_font)
		label.add_color_override("font_color",Color(jsonR[i]["color"][0],jsonR[i]["color"][1],jsonR[i]["color"][2]) )
		#label.rect_rotation=90-angl
		add_child(label)
		print(label.rect_position)
		labels.insert(i, label)
	
	print("work")
	print(losuj())
	pass
#var li=0
func _draw():
	for i in prz.size():
		var center = Vector2(0, 0)
		var angle_from = int(prz[i][0])
		var angle_to = int(prz[i][1])
		var color = Color(jsonR[i]["color"][0], jsonR[i]["color"][1], jsonR[i]["color"][2])
		draw_circle_arc_poly(center, RADIUS, angle_from, angle_to, color)
		self.rotation_degrees+=v
		controlStatus()
	#	li+=1
	#	if li%100==0:
	#		print(li)
	pass

# warning-ignore:unused_argument
func _process(delta):
	update()
	pass

func losuj():
	if status==0:
		randomize()
		ukryj()
		var w=randi()%360
		zatrzymanie=w
		status=3
		for i in angles.size()-1:
			if angles[i]>w && angles[i+1]<w:
				return jsonR[i]
			else:
				return jsonR[jsonR.size()-1]

func controlStatus():
	match status:
		3:
			if licznikStatus==-1:
				speed=0.005
				licznikStatus=300
			elif licznikStatus>0:
				v+=speed
				licznikStatus-=1
			elif licznikStatus==0:
				status=2
				licznikStatus=-1
				speed=0
		2:
			if licznikStatus==-1:
				speed=-0.001
				licznikStatus=0
			elif licznikStatus==0:
				if v<=0.1:
					status=1
					licznikStatus=-1
					speed=0
					v=0.1
				else:
					v+=speed
		1:
			if abs(360-int(self.rotation_degrees)%361)<zatrzymanie+0.1&&abs(360-int(self.rotation_degrees)%361)>zatrzymanie-0.1:
				v=0
				status=0
				pojaw()
func ukryj():
	for i in labels.size():
		labels[i].visible=false
	pass
	
func pojaw():
	for i in labels.size():
		labels[i].visible=true
	pass

func rewerse():
	for i in labels.size():
		labels[i].visible=false if labels[i].visible else true
	
func _on_Button_pressed():
	rewerse()
	pass # Replace with function body.


func _on_BEkw_pressed():
	losuj()
	pass # Replace with function body.
