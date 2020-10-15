extends RichTextLabel
	
func _ready():
	set_process(true)
	pass
	
var score = 30 #łączenie z bazą

func _process(delta):
	var LabelNode = get_parent().get_node("counter")
	LabelNode.text = str(score)+" HealthCoins"
	pass
