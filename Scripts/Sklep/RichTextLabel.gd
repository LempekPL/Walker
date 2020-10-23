extends RichTextLabel
	
func _ready():
	set_process(true)
	pass



func _process(delta):
	var money = 0
	var data = []
	var file = File.new()
	file.open("user://player/level.json", File.READ)
	data = JSON.parse(file.get_as_text()).result
	money = data[0]['money']
	
	var LabelNode = get_parent().get_node("counter")
	LabelNode.text = str(money)+" HealthCoins"
	pass
