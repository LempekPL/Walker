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
var v=0.1
var label
const RADIUS = 200
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
		var angl=((prz[i][1]-prz[i][0])/2)+prz[i][0]+ (-15 if prz[i][0]>180 else 15)
		var x=sin(angl*PI/180)*RADIUS
		var y=cos(angl*PI/180)*RADIUS
		label.rect_position=Vector2(x, y)
		label.add_font_override("font", dynamic_font)
		label.add_color_override("font_color", Color.red)
		add_child(label)
	
	print("work")
	pass

func _draw():
	for i in prz.size():
		var center = Vector2(0, 0)
		var angle_from = int(prz[i][0])
		var angle_to = int(prz[i][1])
		var color = Color(jsonR[i]["color"][0], jsonR[i]["color"][1], jsonR[i]["color"][2])
		draw_circle_arc_poly(center, RADIUS, angle_from, angle_to, color)
		self.rotation_degrees+=v
	pass
func _process(delta):
	update()
	pass

func losuj():
	var w=randi()%361
	for i in jsonR.size():
		
