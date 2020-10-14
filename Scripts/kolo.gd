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
	print(prz[0][0])
	print(prz[0][1])
	print("work")
	pass

func _draw():
	for i in prz.size():
		print(prz[0][0])
		var center = Vector2(350, 350)
		var radius = 200
		var angle_from = int(prz[i][0])
		var angle_to = int(prz[i][1])
		var color = Color(randf(), randf(), randf())
		draw_circle_arc_poly(center, radius, angle_from, angle_to, color)
	#for i in prz.size():
	#	draw_circle_arc_poly(Vector2(350,350), int(prz[0][0]), int(prz[0][1]), 90, Color(0.0,1.0,0.0))
	#draw_circle_arc_poly(Vector2(350,350), 1, 90, 90, Color(0.0,1.0,0.0))
	pass
func _process(delta):
	#update()
	pass
