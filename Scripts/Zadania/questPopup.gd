extends Popup

func _ready():
	pass 

func _on_Button_pressed():
	popup_centered()

func _on_ButtonCan_pressed():
	get_node("../Popup").hide()

func _on_ButtonAcc_pressed():
	pass 
